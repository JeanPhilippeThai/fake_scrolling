-- The checks of workflow_docs/design_and_docs_check.md that a query can answer, then, under CODE-xx, the checks
-- of the code against the docs (.claude/skills/test-code-conformity): the names in the code that carry an ID.
-- Each block starts with its header; each row it returns is a finding (how: Query)
-- or a lead to read before it becomes one (how: Query, then read).
-- needs: the docs content the check reads; without it the check is "not reached".
-- Scopes: 'canonical' is the registry in force; 'web', 'desktop', 'mobile' are archived per-platform registries.
-- A row whose `scope` column is not 'canonical' comes from a frozen archive: it is shown, and never fails the build.
-- L3 rows from an archive are not shown at all: an archive passed L3 before the merge (L4-01).

-- check: L0-04
-- title: Every doc the database reads parses, and every item in it has an ID
-- how: Query
-- severity: Blocking
-- needs:
SELECT path, line, message FROM problems ORDER BY path, line;

-- check: L0-05
-- title: The registry is at its fixed path: docs/registry.yaml, or claude_docs/registry.md, the import of its Claude Doc (never a plain page); each archived per-platform registry is claude_docs/registry-<platform>-archive.md (or .yaml)
-- how: Query
-- severity: Major
-- needs: registry
-- The column is `registry`, not `scope`: an archive's file name is set by the import, so it fails the build too.
SELECT DISTINCT path, scope AS registry,
  CASE scope WHEN 'canonical' THEN 'the registry must be docs/registry.yaml, or claude_docs/registry.md imported from a Claude Doc'
       ELSE 'an archived ' || scope || ' registry must be claude_docs/registry-' || scope || '-archive.md (or .yaml)' END AS problem
FROM sources
WHERE content = 'registry'
  AND ((scope = 'canonical' AND path NOT IN ('docs/registry.yaml', 'claude_docs/registry.md'))
    OR (scope != 'canonical' AND path NOT IN ('claude_docs/registry-' || scope || '-archive.md',
                                              'claude_docs/registry-' || scope || '-archive.yaml')))
ORDER BY 1;

-- check: L1-04
-- title: No feature is marked design_a_mettre_a_jour: true. A flagged feature is redrawn in the repo's claude_design/ (step 4 of the design cycle), then prompt 9 clears the flag; a feature whose design already matches only has its flag cleared
-- how: Query, then read
-- severity: Major
-- needs: registry
-- Each row is a redraw decided and not yet drawn. Read the design to tell a redraw from a flag to clear.
-- Not a plain Query: an app's CI stays green between the decision and the redraw. Archives are frozen, so canonical only.
SELECT d.id, d.name, d.path, d.line
FROM defs d
WHERE d.scope = 'canonical' AND d.kind = 'feature'
  AND (json_extract(d.data, '$.design_a_mettre_a_jour') = 1
       OR lower(CAST(json_extract(d.data, '$.design_a_mettre_a_jour') AS TEXT)) IN ('true', 'oui', 'yes'))
ORDER BY d.id COLLATE idnum;

-- check: L3-01
-- title: Every ID has its kind's format and is unique; every page state's page exists and is on the same platform; no ID in ids_retires is defined again; no two IDs share a number (D-01 and D-001)
-- how: Query
-- severity: Major
-- needs: registry
SELECT scope, id, problem, path, line FROM id_problems WHERE registry
UNION ALL
SELECT s.scope, s.id,
  CASE WHEN p.id IS NULL THEN 'a page state whose page ' || substr(s.id, 1, instr(s.id, '.') - 1) || ' is not defined'
       ELSE 'a page state on ' || COALESCE(s.platform, '(none)') || ' whose page is on ' || COALESCE(p.platform, '(none)') END,
  s.path, NULL
FROM pages s
LEFT JOIN pages p ON p.scope = s.scope AND p.id = substr(s.id, 1, instr(s.id, '.') - 1)
WHERE instr(s.id, '.') > 0
  AND (p.id IS NULL OR s.platform IS NOT p.platform)
UNION ALL
SELECT d.scope, d.id, 'listed in ids_retires (' || COALESCE(r.decision, 'no decision') || ') and defined again', d.path, d.line
FROM defs d JOIN retired r ON r.scope = d.scope AND r.id = d.id
ORDER BY 1, 2;

-- check: L3-02
-- title: Pages list their features and features list their pages, both ways (a variant counts for its feature; a page state counts as a page of its own)
-- how: Query
-- severity: Major
-- needs: registry
WITH pairs AS (
  SELECT scope, source AS page, target AS written, 'page' AS side, path FROM refs WHERE rel = 'page_feature'
  UNION ALL
  SELECT scope, target, source, 'feature', path FROM refs WHERE rel IN ('feature_page', 'variant_page')
), fam AS (
  SELECT *, CASE WHEN instr(written, '.') > 0 THEN substr(written, 1, instr(written, '.') - 1) ELSE written END AS feature
  FROM pairs
)
SELECT DISTINCT a.scope, a.page, a.written AS feature,
  CASE a.side WHEN 'page' THEN 'the page lists it; neither its feature nor a variant lists the page'
              ELSE 'it lists the page; the page lists neither its feature nor a variant' END AS problem,
  a.path
FROM fam a
WHERE EXISTS (SELECT 1 FROM defs d WHERE d.scope = a.scope AND d.id = a.written)
  AND EXISTS (SELECT 1 FROM defs d WHERE d.scope = a.scope AND d.id = a.page)
  AND NOT EXISTS (SELECT 1 FROM fam b WHERE b.scope = a.scope AND b.page = a.page AND b.feature = a.feature AND b.side != a.side)
ORDER BY 1, 2, 3;

-- check: L3-03
-- title: No feature without a page or a role; no entity, role or variant without its feature; every role cited exists
-- how: Query
-- severity: Major
-- needs: registry
SELECT f.scope, f.id, 'feature with no page' AS problem, f.path
FROM features f
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = f.scope AND r.rel = 'feature_page' AND r.source = f.id)
  AND NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = f.scope AND r.rel = 'page_feature' AND r.target = f.id)
UNION ALL
SELECT f.scope, f.id, 'feature with no role in acces', f.path
FROM features f
WHERE EXISTS (SELECT 1 FROM roles o WHERE o.scope = f.scope)
  AND NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = f.scope AND r.rel = 'feature_role' AND r.source = f.id)
UNION ALL
SELECT e.scope, e.id, 'entity no feature uses', e.path
FROM entities e
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = e.scope AND r.rel = 'entity_feature' AND r.source = e.id)
  AND NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = e.scope AND r.rel = 'feature_entity' AND r.target = e.id)
UNION ALL
SELECT o.scope, o.id, 'role no feature gives access to', o.path
FROM roles o
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = o.scope AND r.rel IN ('feature_role','variant_role') AND r.target = o.id)
UNION ALL
SELECT v.scope, v.id, 'variant listed under ' || v.feature || ', not under its own feature', v.path
FROM variants v WHERE substr(v.id, 1, instr(v.id, '.') - 1) != v.feature
UNION ALL
SELECT DISTINCT r.scope, r.source, 'cites role ' || r.target || ', which is not in roles', r.path
FROM refs r
WHERE r.rel IN ('feature_role','variant_role')
  AND NOT EXISTS (SELECT 1 FROM roles o WHERE o.scope = r.scope AND o.id = r.target)
ORDER BY 1, 2;

-- check: L3-04
-- title: Features and entities list each other both ways (entites, utilisee_par)
-- how: Query
-- severity: Major
-- needs: registry
SELECT r.scope, r.source AS feature, r.target AS entity, 'the feature lists the entity; the entity does not list it in utilisee_par' AS problem, r.path
FROM refs r
WHERE r.rel = 'feature_entity'
  AND EXISTS (SELECT 1 FROM entities e WHERE e.scope = r.scope AND e.id = r.target)
  AND NOT EXISTS (SELECT 1 FROM refs x WHERE x.scope = r.scope AND x.rel = 'entity_feature' AND x.source = r.target AND x.target = r.source)
UNION ALL
SELECT r.scope, r.target, r.source, 'the entity lists the feature in utilisee_par; the feature does not list it', r.path
FROM refs r
WHERE r.rel = 'entity_feature'
  AND EXISTS (SELECT 1 FROM features f WHERE f.scope = r.scope AND f.id = r.target)
  AND NOT EXISTS (SELECT 1 FROM refs x WHERE x.scope = r.scope AND x.rel = 'feature_entity' AND x.source = r.target AND x.target = r.source)
ORDER BY 1, 2, 3;

-- check: L3-08
-- title: Every variant has its platform and pages, and its own acces only when it differs from its feature's
-- how: Query, then read
-- severity: Minor
-- needs: registry
SELECT v.scope, v.id, 'no plateforme' AS problem, v.path
FROM variants v
WHERE EXISTS (SELECT 1 FROM pages p WHERE p.scope = v.scope AND p.platform IS NOT NULL)
  AND NOT EXISTS (SELECT 1 FROM variant_platforms x WHERE x.scope = v.scope AND x.variant = v.id)
UNION ALL
SELECT v.scope, v.id, 'no pages', v.path
FROM variants v
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = v.scope AND r.rel = 'variant_page' AND r.source = v.id)
UNION ALL
SELECT v.scope, v.id, 'its own acces is the same as its feature''s', v.path
FROM variants v
WHERE v.own_access = 1
  AND NOT EXISTS (SELECT 1 FROM refs a WHERE a.scope = v.scope AND a.rel = 'variant_role' AND a.source = v.id
                  AND NOT EXISTS (SELECT 1 FROM refs b WHERE b.scope = v.scope AND b.rel = 'feature_role' AND b.source = v.feature AND b.target = a.target))
  AND NOT EXISTS (SELECT 1 FROM refs b WHERE b.scope = v.scope AND b.rel = 'feature_role' AND b.source = v.feature
                  AND NOT EXISTS (SELECT 1 FROM refs a WHERE a.scope = v.scope AND a.rel = 'variant_role' AND a.source = v.id AND a.target = b.target))
ORDER BY 1, 2;

-- check: L3-10
-- title: Every decision has an ID, a subject, a choice and a reason
-- how: Query
-- severity: Minor
-- needs: registry
SELECT scope, id,
  TRIM((CASE WHEN COALESCE(subject, '') = '' THEN 'no sujet ' ELSE '' END)
    || (CASE WHEN COALESCE(choice, '') = '' THEN 'no choix ' ELSE '' END)
    || (CASE WHEN COALESCE(reason, '') = '' THEN 'no raison' ELSE '' END)) AS problem,
  path
FROM decisions
WHERE COALESCE(subject, '') = '' OR COALESCE(choice, '') = '' OR COALESCE(reason, '') = ''
ORDER BY 1, 2;

-- check: L4-02
-- title: Every item of every per-platform registry appears in the canonical registry through its alias, or in ids_retires
-- how: Query, then read
-- severity: Blocking
-- needs: registry, multi_platform
WITH a AS (
  SELECT al.id, al.alias, COALESCE(al.platform, p.platform) AS platform
  FROM aliases al LEFT JOIN pages p ON p.scope = 'canonical' AND p.id = al.id
)
SELECT d.scope AS platform, d.id, d.kind, 'no canonical item has it as alias: check the merge notes' AS problem, d.path
FROM defs d
WHERE d.scope NOT IN ('canonical', 'unknown')
  AND d.expected_kind IN ('role','page','feature','variant','entity','decision')
  AND NOT EXISTS (SELECT 1 FROM a WHERE a.alias = d.id AND a.platform = d.scope)
ORDER BY 1, 3, 2;

-- check: L4-03
-- title: No per-platform ID is the alias of two canonical IDs, and no canonical ID has two aliases from the same platform, unless the split (alias_partiel) or the merge (alias_decision) is declared; an old variant counts with its own feature
-- how: Query
-- severity: Major
-- needs: registry, multi_platform
WITH a AS (
  SELECT al.kind, al.id, al.alias, al.partial, COALESCE(al.platform, p.platform) AS platform
  FROM aliases al LEFT JOIN pages p ON p.scope = 'canonical' AND p.id = al.id
  WHERE al.retired = 0
), split AS (
  SELECT platform, alias, kind, COUNT(DISTINCT id) AS n,
    COUNT(DISTINCT CASE WHEN partial = 0 THEN id END) AS plain, GROUP_CONCAT(DISTINCT id) AS ids
  FROM a GROUP BY platform, alias, kind
), folded AS (
  -- an old variant whose own feature is an alias of the same item counts with that feature
  SELECT * FROM a x
  WHERE NOT (instr(x.alias, '.') > 0
             AND EXISTS (SELECT 1 FROM a y WHERE y.id = x.id AND y.platform IS x.platform
                         AND y.alias = substr(x.alias, 1, instr(x.alias, '.') - 1)))
), merged AS (
  SELECT platform, id, COUNT(DISTINCT alias) AS n,
    COUNT(DISTINCT CASE WHEN partial = 0 THEN alias END) AS plain, GROUP_CONCAT(DISTINCT alias) AS aliases
  FROM folded GROUP BY platform, id, kind
)
SELECT platform AS alias_platform, alias AS id,
  'alias of ' || n || ' canonical IDs (' || ids || '), ' || plain || ' of them without it in alias_partiel' AS problem
FROM split WHERE n > 1 AND plain > 1
UNION ALL
SELECT platform, id, 'has ' || n || ' aliases from ' || platform || ' (' || aliases || ') and no alias_decision naming an existing decision'
FROM merged m
WHERE n > 1 AND plain > 1
  AND NOT EXISTS (SELECT 1 FROM alias_decisions ad JOIN decisions d ON d.scope = ad.scope AND d.id = ad.decision
                  WHERE ad.scope = 'canonical' AND ad.id = m.id)
UNION ALL
SELECT 'canonical', ad.id, 'alias_decision names ' || ad.decision || ', which is not a decision'
FROM alias_decisions ad
WHERE ad.scope = 'canonical' AND NOT EXISTS (SELECT 1 FROM decisions d WHERE d.scope = 'canonical' AND d.id = ad.decision)
ORDER BY 1, 2;

-- check: L4-04
-- title: Pages carry their platform prefix and their plateforme matches it; a feature's plateformes equals the platforms of its pages
-- how: Query
-- severity: Major
-- needs: registry, multi_platform
WITH pp AS (
  SELECT DISTINCT r.source AS feature, p.platform
  FROM refs r JOIN pages p ON p.scope = r.scope AND p.id = r.target
  WHERE r.scope = 'canonical' AND r.rel = 'feature_page' AND p.platform IS NOT NULL
)
SELECT id, 'page prefix and plateforme ' || COALESCE(platform, '(none)') || ' do not match' AS problem, path
FROM pages
WHERE scope = 'canonical'
  AND NOT ((id GLOB 'P-W[0-9]*' AND platform = 'web') OR (id GLOB 'P-D[0-9]*' AND platform = 'desktop')
        OR (id GLOB 'P-M[0-9]*' AND platform = 'mobile'))
UNION ALL
SELECT fp.feature, 'lists platform ' || fp.platform || ' but has no page on it', f.path
FROM feature_platforms fp JOIN features f ON f.scope = fp.scope AND f.id = fp.feature
WHERE fp.scope = 'canonical' AND NOT EXISTS (SELECT 1 FROM pp WHERE pp.feature = fp.feature AND pp.platform = fp.platform)
UNION ALL
SELECT pp.feature, 'has a page on ' || pp.platform || ' but does not list that platform', f.path
FROM pp JOIN features f ON f.scope = 'canonical' AND f.id = pp.feature
WHERE NOT EXISTS (SELECT 1 FROM feature_platforms fp WHERE fp.scope = 'canonical' AND fp.feature = pp.feature AND fp.platform = pp.platform)
ORDER BY 1;

-- check: L4-08
-- title: One entity model: each entity's fields are the union of every platform's fields
-- how: Query, then read
-- severity: Major
-- needs: registry, multi_platform
-- A field is compared by its name before " (", against every canonical entity that has the
-- platform entity as alias, partial or not.
WITH fam AS (
  SELECT DISTINCT platform, alias, id FROM aliases WHERE kind = 'entity' AND retired = 0
), fields AS (
  SELECT scope, entity, field,
    LOWER(TRIM(CASE WHEN instr(field, ' (') > 0 THEN substr(field, 1, instr(field, ' (') - 1) ELSE field END)) AS name
  FROM entity_fields
), canon AS (
  SELECT f.platform, f.alias, c.name
  FROM fam f JOIN fields c ON c.scope = 'canonical' AND c.entity = f.id
)
SELECT GROUP_CONCAT(DISTINCT f.id) AS entities, f.platform, f.alias, pf.field AS platform_field,
  'no field of that name in the canonical entities that have it as alias' AS problem
FROM fam f
JOIN fields pf ON pf.scope = f.platform AND pf.entity = f.alias
WHERE NOT EXISTS (
  SELECT 1 FROM canon c WHERE c.platform = f.platform AND c.alias = f.alias AND c.name = pf.name)
GROUP BY f.platform, f.alias, pf.field
ORDER BY 2, 3, 4;

-- check: L4-13
-- title: No later document still uses a per-platform ID instead of the canonical one
-- how: Query
-- severity: Major
-- needs: registry, multi_platform
SELECT m.path, m.line, m.id, 'per-platform ID, not defined in the canonical registry' AS problem
FROM mentions m
WHERE m.scope = 'canonical'
  AND m.path NOT IN (SELECT path FROM sources WHERE content = 'registry')
  AND m.path NOT IN (SELECT path FROM docs WHERE archived = 1)
  AND m.kind IN ('role','page','page_state','feature','variant','entity','decision')
  AND NOT EXISTS (SELECT 1 FROM defs d WHERE d.scope = 'canonical' AND d.id = m.id)
  AND EXISTS (SELECT 1 FROM defs d WHERE d.scope != 'canonical' AND d.id = m.id)
ORDER BY 1, 2;

-- check: L5-01
-- title: Every flow uses only canonical registry IDs (P, F, E, and the roles and decisions it cites)
-- how: Query
-- severity: Major
-- needs: registry, flows
-- A flow is a heading that starts with its FL ID; `lines` are the lines of its section that cite the ID.
SELECT r.source AS flow, r.target AS id,
  CASE WHEN EXISTS (SELECT 1 FROM aliases a WHERE a.alias = r.target AND a.id IS NOT NULL AND a.retired = 0)
         THEN 'a per-platform ID: cite its canonical ID ' || (SELECT MIN(a.id) FROM aliases a WHERE a.alias = r.target AND a.id IS NOT NULL AND a.retired = 0)
       WHEN EXISTS (SELECT 1 FROM retired t WHERE t.scope = r.scope AND t.id = r.target)
         THEN 'retired by ' || COALESCE((SELECT MIN(t.decision) FROM retired t WHERE t.scope = r.scope AND t.id = r.target), 'no decision')
       ELSE 'not in the canonical registry' END AS problem,
  r.path,
  (SELECT GROUP_CONCAT(m.line) FROM mentions m WHERE m.path = r.path AND m.id = r.target
     AND m.line > f.line AND m.line <= f.end_line) AS lines
FROM refs r
JOIN flows f ON f.scope = r.scope AND f.id = r.source AND f.path = r.path
WHERE r.scope = 'canonical'
  AND r.rel IN ('flow_page', 'flow_feature', 'flow_entity', 'flow_role', 'flow_decision')
  AND NOT EXISTS (SELECT 1 FROM defs d WHERE d.scope = 'canonical' AND d.id = r.target)
GROUP BY r.source, r.target, r.path
ORDER BY r.source COLLATE idnum, r.target COLLATE idnum;

-- check: L5-06
-- title: A feature on several platforms that a flow cites is reachable by a flow on each: one that cites the feature (or one of its variants) and a page of that platform
-- how: Query, then read
-- severity: Major
-- needs: registry, flows
-- A feature in no flow yet is left to L5-07, so that the leads hold while step 5 is in progress.
WITH ff AS (
  SELECT r.source AS flow, COALESCE(v.feature, r.target) AS feature
  FROM refs r LEFT JOIN variants v ON v.scope = r.scope AND v.id = r.target
  WHERE r.scope = 'canonical' AND r.rel = 'flow_feature'
), fp AS (
  SELECT r.source AS flow, p.platform
  FROM refs r JOIN pages p ON p.scope = r.scope AND p.id = r.target
  WHERE r.scope = 'canonical' AND r.rel = 'flow_page'
)
SELECT f.feature, f.platform,
  'on ' || f.platform || ', but no flow cites it with a ' || f.platform || ' page' AS problem
FROM feature_platforms f
WHERE f.scope = 'canonical'
  AND (SELECT COUNT(DISTINCT g.platform) FROM feature_platforms g WHERE g.scope = 'canonical' AND g.feature = f.feature) > 1
  AND EXISTS (SELECT 1 FROM ff WHERE ff.feature = f.feature)
  AND NOT EXISTS (SELECT 1 FROM ff JOIN fp ON fp.flow = ff.flow WHERE ff.feature = f.feature AND fp.platform = f.platform)
ORDER BY f.feature COLLATE idnum, f.platform;

-- check: L5-07
-- title: Every feature used across pages (on two pages or more, a page's states counting as that page) appears in at least one flow, itself or through one of its variants
-- how: Query
-- severity: Minor
-- needs: registry, flows_done
-- Flows are written one at a time: this runs once step 8 has started (a data model or data flows
-- exist), since prompts 11 and 12 run once every flow is written.
WITH fpages AS (
  SELECT scope, source AS feature, target AS page FROM refs WHERE rel = 'feature_page'
  UNION SELECT scope, target, source FROM refs WHERE rel = 'page_feature'
  UNION SELECT r.scope, v.feature, r.target FROM refs r JOIN variants v ON v.scope = r.scope AND v.id = r.source
        WHERE r.rel = 'variant_page'
), across AS (
  SELECT feature,
    GROUP_CONCAT(DISTINCT CASE WHEN instr(page, '.') > 0 THEN substr(page, 1, instr(page, '.') - 1) ELSE page END) AS pages,
    COUNT(DISTINCT CASE WHEN instr(page, '.') > 0 THEN substr(page, 1, instr(page, '.') - 1) ELSE page END) AS n
  FROM fpages WHERE scope = 'canonical' GROUP BY feature
)
SELECT f.id AS feature, f.name, a.pages, 'on ' || a.n || ' pages, but in no flow' AS problem, f.path
FROM features f JOIN across a ON a.feature = f.id
WHERE f.scope = 'canonical' AND a.n > 1
  AND NOT EXISTS (SELECT 1 FROM refs r LEFT JOIN variants v ON v.scope = r.scope AND v.id = r.target
                  WHERE r.scope = 'canonical' AND r.rel = 'flow_feature' AND COALESCE(v.feature, r.target) = f.id)
ORDER BY f.id COLLATE idnum;

-- check: L8-01
-- title: Every table has an ID, a name, a type, a store (N-xx) and the entity it stores, or "aucune" with a reason
-- how: Query
-- severity: Major
-- needs: data_model
SELECT id,
  TRIM((CASE WHEN COALESCE(name, '') = '' THEN 'no nom ' ELSE '' END)
    || (CASE WHEN COALESCE(type, '') NOT IN ('table', 'collection') THEN 'type is not table or collection ' ELSE '' END)
    || (CASE WHEN COALESCE(store, '') NOT GLOB 'N-[0-9]*' THEN 'no stockage N-xx ' ELSE '' END)
    || (CASE WHEN COALESCE(entity, '') = '' THEN 'no entite ' ELSE '' END)
    || (CASE WHEN LOWER(COALESCE(entity, '')) LIKE 'aucune%' AND COALESCE(reason, '') = '' THEN 'aucune without raison' ELSE '' END)) AS problem,
  path
FROM data_tables
WHERE COALESCE(name, '') = '' OR COALESCE(type, '') NOT IN ('table', 'collection')
   OR COALESCE(store, '') NOT GLOB 'N-[0-9]*' OR COALESCE(entity, '') = ''
   OR (LOWER(COALESCE(entity, '')) LIKE 'aucune%' AND COALESCE(reason, '') = '')
ORDER BY 1;

-- check: L8-02
-- title: Every canonical entity is stored in at least one table, and every table cites the entity it stores
-- how: Query
-- severity: Blocking
-- needs: registry, data_model
SELECT e.id, 'no table stores it' AS problem, e.path
FROM entities e
WHERE e.scope = 'canonical'
  AND NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'table_entity' AND r.target = e.id)
UNION ALL
SELECT t.id, 'stores ' || t.entity || ', which is not a canonical entity', t.path
FROM data_tables t
WHERE LOWER(COALESCE(t.entity, '')) NOT LIKE 'aucune%'
  AND NOT EXISTS (SELECT 1 FROM entities e WHERE e.scope = 'canonical' AND e.id = t.entity)
ORDER BY 1;

-- check: L8-04
-- title: Every foreign key points to an existing TB-xx.column
-- how: Query
-- severity: Major
-- needs: data_model
SELECT c.table_id, c.name AS column_name, c.reference, 'no such table column' AS problem
FROM table_columns c
WHERE COALESCE(c.reference, '') != ''
  AND NOT EXISTS (SELECT 1 FROM table_columns t WHERE t.table_id || '.' || t.name = c.reference)
ORDER BY 1, 2;

-- check: L9-01
-- title: One actor node per role
-- how: Query
-- severity: Major
-- needs: registry, data_flows
SELECT o.id, 'role with no actor node' AS problem, o.path
FROM roles o
WHERE o.scope = 'canonical'
  AND NOT EXISTS (SELECT 1 FROM nodes n WHERE n.type = 'acteur' AND n.role = o.id)
UNION ALL
SELECT n.id, 'actor node whose role ' || COALESCE(n.role, '(none)') || ' is not in roles', n.path
FROM nodes n
WHERE n.type = 'acteur' AND NOT EXISTS (SELECT 1 FROM roles o WHERE o.scope = 'canonical' AND o.id = n.role)
UNION ALL
SELECT n.role, 'role with ' || COUNT(*) || ' actor nodes: ' || GROUP_CONCAT(n.id), MIN(n.path)
FROM nodes n WHERE n.type = 'acteur' GROUP BY n.role HAVING COUNT(*) > 1
ORDER BY 1;

-- check: L9-02
-- title: Every flow goes one way and cites the entities it carries and the features that trigger it, or the flow (FL) of a background job
-- how: Query
-- severity: Major
-- needs: data_flows
SELECT f.id, 'no de or no vers' AS problem, f.path
FROM data_flows f WHERE COALESCE(f.source, '') = '' OR COALESCE(f.target, '') = ''
UNION ALL
SELECT f.id, 'carries no entity (donnees)', f.path
FROM data_flows f
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'data_flow_entity' AND r.source = f.id)
UNION ALL
SELECT f.id, 'cites no feature and no flow FL', f.path
FROM data_flows f
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel IN ('data_flow_feature', 'data_flow_flow') AND r.source = f.id)
ORDER BY 1;

-- check: L9-03
-- title: A flow that leaves an actor cites only features that actor's role may use
-- how: Query
-- severity: Blocking
-- needs: registry, data_flows
SELECT f.id AS flow, n.id AS actor, n.role, r.target AS feature, 'the role is not in the feature''s acces' AS problem
FROM data_flows f
JOIN nodes n ON n.id = f.source AND n.type = 'acteur'
JOIN refs r ON r.scope = 'canonical' AND r.rel = 'data_flow_feature' AND r.source = f.id
WHERE NOT EXISTS (SELECT 1 FROM refs a WHERE a.scope = 'canonical' AND a.rel IN ('feature_role', 'variant_role')
                  AND a.source = r.target AND a.target = n.role)
ORDER BY 1, 4;

-- check: L9-04
-- title: No actor talks to a store directly (the query cannot tell an app from the server: both are infra)
-- how: Query
-- severity: Major
-- needs: data_flows
SELECT f.id, a.id || ' (' || a.type || ') -> ' || b.id || ' (' || b.type || ')' AS problem, f.path
FROM data_flows f JOIN nodes a ON a.id = f.source JOIN nodes b ON b.id = f.target
WHERE (a.type = 'acteur' AND b.type IN ('stockage', 'acteur')) OR (a.type = 'stockage' AND b.type = 'acteur')
ORDER BY 1;

-- check: L9-05
-- title: Every feature that reads or writes data appears in a flow; every store is reached by a flow
-- how: Query
-- severity: Major
-- needs: registry, data_flows
SELECT f.id, 'reads or writes data (' || f.operations || ') but no flow cites it' AS problem, f.path
FROM features f
WHERE f.scope = 'canonical' AND (f.operations LIKE '%lecture%' OR f.operations LIKE '%criture%')
  AND NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'data_flow_feature' AND r.target = f.id)
UNION ALL
SELECT n.id, 'store no flow reaches', n.path
FROM nodes n
WHERE n.type = 'stockage' AND NOT EXISTS (SELECT 1 FROM data_flows f WHERE n.id IN (f.source, f.target))
ORDER BY 1;

-- check: L10-01
-- title: Every page of every platform has a contract, and every contract's page exists in the canonical registry
-- how: Query
-- severity: Blocking
-- needs: registry, page_contract
SELECT p.id, 'no page contract' AS problem, p.path
FROM pages p
WHERE p.scope = 'canonical' AND NOT EXISTS (SELECT 1 FROM page_contracts c WHERE c.page = p.id)
UNION ALL
SELECT c.page, 'contract of a page that is not in the canonical registry', c.path
FROM page_contracts c
WHERE NOT EXISTS (SELECT 1 FROM pages p WHERE p.scope = 'canonical' AND p.id = c.page)
ORDER BY 1;

-- check: L10-03
-- title: Every component's feature is listed on its page in the registry, and every feature of the page has a component
-- how: Query
-- severity: Major
-- needs: registry, page_contract
SELECT c.id, c.page, c.feature, 'the page does not list this feature in the registry' AS problem, c.path
FROM components c
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'page_feature' AND r.source = c.page AND r.target = c.feature)
UNION ALL
SELECT NULL, r.source, r.target, 'listed on the page in the registry, but no component of its contract', pc.path
FROM refs r JOIN page_contracts pc ON pc.page = r.source
WHERE r.scope = 'canonical' AND r.rel = 'page_feature'
  AND NOT EXISTS (SELECT 1 FROM components c WHERE c.page = r.source AND c.feature = r.target)
ORDER BY 2, 3;

-- check: L10-06
-- title: Every column read or written exists, and a flow cited by the component carries its entity
-- how: Query
-- severity: Major
-- needs: data_model, page_contract
SELECT cc.component, cc.column_ref, cc.mode, 'no such table column' AS problem
FROM component_columns cc
WHERE NOT EXISTS (SELECT 1 FROM table_columns t WHERE t.table_id || '.' || t.name = cc.column_ref)
UNION ALL
SELECT cc.component, cc.column_ref, cc.mode, 'none of the flows it cites carries ' || t.entity
FROM component_columns cc
JOIN data_tables t ON cc.column_ref LIKE t.id || '.%'
WHERE t.entity GLOB 'E-[0-9]*'
  AND NOT EXISTS (SELECT 1 FROM refs f JOIN refs e ON e.scope = 'canonical' AND e.rel = 'data_flow_entity' AND e.source = f.target AND e.target = t.entity
                  WHERE f.scope = 'canonical' AND f.rel = 'component_data_flow' AND f.source = cc.component)
ORDER BY 1, 2;

-- check: L10-07
-- title: Every role that can open the page may use the feature of each of its components (acces)
-- how: Query
-- severity: Blocking
-- needs: registry, page_contract
SELECT c.id, c.page, c.feature, a.target AS role, 'the page is open to this role, the feature is not' AS problem
FROM components c
JOIN refs a ON a.scope = 'canonical' AND a.rel = 'contract_role' AND a.source = c.page
WHERE NOT EXISTS (
  SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.target = a.target
    AND ((r.rel = 'variant_role' AND r.source = c.feature)
      OR (r.rel = 'feature_role' AND r.source = c.feature)
      OR (r.rel = 'feature_role' AND instr(c.feature, '.') > 0 AND r.source = substr(c.feature, 1, instr(c.feature, '.') - 1)
          AND NOT EXISTS (SELECT 1 FROM variants v WHERE v.scope = 'canonical' AND v.id = c.feature AND v.own_access = 1))))
ORDER BY 1, 4;

-- check: L10-10
-- title: Accessible names are unique on each page
-- how: Query, then read
-- severity: Major
-- needs: page_contract
SELECT page, accessible_name, GROUP_CONCAT(id) AS components, 'same accessible name' AS problem
FROM components WHERE COALESCE(accessible_name, '') != ''
GROUP BY page, accessible_name HAVING COUNT(*) > 1
ORDER BY 1, 2;

-- check: L10-12
-- title: No MANQUANT is left
-- how: Query
-- severity: Blocking
-- needs: page_contract
SELECT path, line, text FROM missing ORDER BY 1, 2;

-- check: B4-01
-- title: Every canonical item has an alias in at least one per-platform registry, or a decision created it after the merge
-- how: Query, then read
-- severity: Blocking
-- needs: registry, multi_platform
-- A decision with no alias was taken after the merge: one that cites the item explains it.
SELECT d.kind, d.id, 'no alias, and no decision taken after the merge cites it' AS problem, d.path
FROM defs d
WHERE d.scope = 'canonical' AND d.expected_kind IN ('role', 'page', 'feature', 'variant', 'entity')
  AND NOT EXISTS (SELECT 1 FROM aliases a WHERE a.id = d.id)
  AND NOT EXISTS (SELECT 1 FROM refs r JOIN decisions x ON x.scope = 'canonical' AND x.id = r.source
                  WHERE r.scope = 'canonical' AND r.rel = 'decision_cites' AND r.target = d.id
                    AND NOT EXISTS (SELECT 1 FROM aliases a WHERE a.id = x.id))
ORDER BY 1, 2;

-- check: B8-03
-- title: Every store is a node in the data-flow file
-- how: Query
-- severity: Major
-- needs: data_model, data_flows
SELECT t.id, t.store, 'its store is not a stockage node' AS problem, t.path
FROM data_tables t
WHERE NOT EXISTS (SELECT 1 FROM nodes n WHERE n.id = t.store AND n.type = 'stockage')
ORDER BY 1;

-- check: B9-03
-- title: Every entity a flow carries is used by one of that flow's features
-- how: Query
-- severity: Major
-- needs: registry, data_flows
SELECT e.source AS flow, e.target AS entity, 'none of the flow''s features uses this entity' AS problem
FROM refs e
WHERE e.scope = 'canonical' AND e.rel = 'data_flow_entity'
  AND EXISTS (SELECT 1 FROM refs f WHERE f.scope = 'canonical' AND f.rel = 'data_flow_feature' AND f.source = e.source)
  AND NOT EXISTS (SELECT 1 FROM refs f JOIN refs u ON u.scope = 'canonical' AND u.rel = 'feature_entity' AND u.source = f.target AND u.target = e.target
                  WHERE f.scope = 'canonical' AND f.rel = 'data_flow_feature' AND f.source = e.source)
ORDER BY 1, 2;

-- check: B10-02
-- title: Every condition (visible_si, actif_si) tests a role, a state, a flag or a column
-- how: Query, then read
-- severity: Major
-- needs: page_contract
SELECT c.component, c.mode, c.condition, 'cites no ID: nothing says where it comes from' AS problem
FROM component_conditions c
WHERE NOT EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'component_condition' AND r.source = c.component)
ORDER BY 1;

-- check: G-01
-- title: Every ID of the system design and the page contracts has its kind's format and is unique
-- how: Query
-- severity: Major
-- needs:
SELECT scope, id, problem, path, line FROM id_problems WHERE NOT registry ORDER BY 1, 2;

-- check: G-02
-- title: Every ID cited anywhere exists or is in ids_retires (for the kinds the database reads: P, F, E, R, D, TB, N, DF, FL, C); an ID followed by … is an example; a range cites every ID in it; archives are not checked
-- how: Query
-- severity: Major
-- needs:
SELECT m.scope, m.id, m.path, GROUP_CONCAT(m.line) AS lines, 'cited, but not defined' AS problem
FROM mentions m
WHERE m.scope = 'canonical'
  AND m.path NOT IN (SELECT path FROM docs WHERE archived = 1)
  AND m.kind IN ('role','page','page_state','feature','variant','entity','decision','table','node','data_flow','flow','component')
  AND EXISTS (SELECT 1 FROM defs k WHERE k.scope = m.scope
              AND k.expected_kind = CASE m.kind WHEN 'page_state' THEN 'page' ELSE m.kind END)
  AND NOT EXISTS (SELECT 1 FROM defs d WHERE d.scope = m.scope AND d.id = m.id)
  AND NOT EXISTS (SELECT 1 FROM retired r WHERE r.scope = m.scope AND r.id = m.id)
  AND NOT EXISTS (SELECT 1 FROM aliases a WHERE a.retired = 1 AND a.id IS NULL AND a.alias = m.id)
  AND NOT (m.path IN (SELECT path FROM sources WHERE content = 'registry')
           AND EXISTS (SELECT 1 FROM aliases a WHERE a.alias = m.id))
GROUP BY m.scope, m.id, m.path
ORDER BY 1, 2, 3;

-- check: G-03
-- title: No ID disappeared since the previous version of the docs unless ids_retires lists it with the decision that retired it, or it lives on as an alias: an ID is never renumbered or reused
-- how: Query
-- severity: Major
-- needs: previous
-- `prev` is the previous version (check --since REV, or the base of diff). Compared as numbers: D-01 and D-001 are one ID.
SELECT p.id, p.kind, p.path AS was_in, p.name,
  'gone since the previous version: list it in the registry''s ids_retires with the decision that retired it, or bring it back' AS problem
FROM prev.defs p
WHERE p.number IS NOT NULL
  AND p.number NOT IN (SELECT number FROM main.defs WHERE number IS NOT NULL)
  AND p.number NOT IN (SELECT idnum(id) FROM main.retired
                       WHERE id IS NOT NULL AND COALESCE(decision, '') != '')
  AND p.number NOT IN (SELECT idnum(alias) FROM main.aliases WHERE alias IS NOT NULL)
GROUP BY p.number
ORDER BY p.id COLLATE idnum;

-- check: CODE-01
-- title: Every folder of src/ui/features/ and src/server/features/ is named after a feature of the registry (F-012-apply-coupon), one folder per feature on each side; a variant has no folder of its own
-- how: Query
-- severity: Major
-- needs: code, registry
SELECT k.written AS folder, k.path,
  CASE WHEN k.id IS NULL THEN 'its name does not start with a feature ID (F-012-apply-coupon)'
       ELSE 'names ' || k.id || ', which is not a feature of the registry' END AS problem
FROM code k
WHERE k.kind = 'feature_folder'
  AND (k.id IS NULL OR NOT EXISTS (SELECT 1 FROM features f WHERE f.scope = 'canonical' AND idnum(f.id) = idnum(k.id)))
UNION ALL
SELECT GROUP_CONCAT(written, ', '), GROUP_CONCAT(path, ', '), 'several folders for ' || MIN(id) || ' on the same side'
FROM code
WHERE kind = 'feature_folder' AND id IS NOT NULL
GROUP BY idnum(id), substr(path, 1, instr(path, '/features/'))
HAVING COUNT(*) > 1
ORDER BY 2;

-- check: CODE-02
-- title: Every feature of the registry has its folder in src/ui/features/
-- how: Query, then read
-- severity: Minor
-- needs: code, registry
-- Each row is a feature not built yet: a finding only when the backlog says it is done. Runs once a first feature folder exists.
SELECT f.id AS feature, f.name, 'no folder in src/ui/features/' AS problem
FROM features f
WHERE f.scope = 'canonical'
  AND EXISTS (SELECT 1 FROM code WHERE kind = 'feature_folder' AND id IS NOT NULL)
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'feature_folder' AND k.path LIKE '%/ui/features/%'
                  AND idnum(k.id) = idnum(f.id))
ORDER BY f.id COLLATE idnum;

-- check: CODE-03
-- title: Every page that holds a built feature (one with a folder in src/ui/features/) has a route named after it in the navigation shell (P-03-cart), and every route names a page of the registry; a page state has no route
-- how: Query
-- severity: Major
-- needs: code, registry
WITH built AS (SELECT DISTINCT idnum(id) AS f FROM code
               WHERE kind = 'feature_folder' AND id IS NOT NULL AND path LIKE '%/ui/features/%'),
on_page AS (SELECT r.target AS page, idnum(r.source) AS f FROM refs r
            WHERE r.scope = 'canonical' AND r.rel = 'feature_page'
            UNION
            SELECT r.target, idnum(v.feature) FROM refs r
            JOIN variants v ON v.scope = 'canonical' AND v.id = r.source
            WHERE r.scope = 'canonical' AND r.rel = 'variant_page')
SELECT p.id AS page, 'holds a built feature, and no route is named after it' AS problem, NULL AS path, NULL AS line
FROM pages p
WHERE p.scope = 'canonical' AND instr(p.id, '.') = 0
  AND EXISTS (SELECT 1 FROM on_page o JOIN built b ON b.f = o.f WHERE o.page = p.id)
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'route' AND idnum(k.id) = idnum(p.id))
UNION ALL
SELECT k.id, 'the route ' || k.written || ' names no page of the registry', k.path, k.line
FROM code k
WHERE k.kind = 'route'
  AND NOT EXISTS (SELECT 1 FROM pages p WHERE p.scope = 'canonical' AND idnum(p.id) = idnum(k.id))
ORDER BY 1, 3;

-- check: CODE-04
-- title: Every component of a built feature carries its ID as a test identifier in that feature's UI folder (data-testid="C-D04-03"), and every test identifier names a component, in the folder of its feature; a variant's component sits in its feature's folder
-- how: Query
-- severity: Major
-- needs: code, page_contract
WITH built AS (SELECT DISTINCT idnum(id) AS f FROM code
               WHERE kind = 'feature_folder' AND id IS NOT NULL AND path LIKE '%/ui/features/%'),
comp AS (SELECT id, feature, path,
           idnum(CASE WHEN instr(feature, '.') > 0 THEN substr(feature, 1, instr(feature, '.') - 1) ELSE feature END) AS f
         FROM components)
SELECT c.id AS component, c.feature, 'no test identifier in the UI folder of its feature' AS problem, c.path, NULL AS line
FROM comp c
WHERE c.f IN (SELECT f FROM built)
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'test_identifier' AND idnum(k.id) = idnum(c.id)
                  AND idnum(k.feature) = c.f)
UNION ALL
SELECT k.id, k.feature, 'names no component of a page contract', k.path, k.line
FROM code k
WHERE k.kind = 'test_identifier'
  AND NOT EXISTS (SELECT 1 FROM comp c WHERE idnum(c.id) = idnum(k.id))
UNION ALL
SELECT k.id, c.feature, 'outside the UI folder of its feature', k.path, k.line
FROM code k JOIN comp c ON idnum(c.id) = idnum(k.id)
WHERE k.kind = 'test_identifier' AND idnum(k.feature) IS NOT c.f
ORDER BY 1, 4;

-- check: CODE-05
-- title: Every data flow between an app and the server that a built feature or a built job triggers has a file named after it in src/shared/ (DF-07-coupon-request.ts), and every such file names a data flow between an app and the server
-- how: Query
-- severity: Major
-- needs: code, data_flows
-- An app and the server are both `infra` nodes: a flow between two of them. A feature is built once it has a folder on either side.
WITH built AS (SELECT DISTINCT idnum(id) AS f FROM code WHERE kind = 'feature_folder' AND id IS NOT NULL),
app_server AS (SELECT d.id, d.path FROM data_flows d
               JOIN nodes a ON a.id = d.source AND a.type = 'infra'
               JOIN nodes b ON b.id = d.target AND b.type = 'infra')
SELECT s.id AS data_flow, 'triggered by a built feature or job, and no file of src/shared/ is named after it' AS problem, s.path
FROM app_server s
WHERE (EXISTS (SELECT 1 FROM refs r WHERE r.scope = 'canonical' AND r.rel = 'data_flow_feature' AND r.source = s.id
               AND idnum(CASE WHEN instr(r.target, '.') > 0 THEN substr(r.target, 1, instr(r.target, '.') - 1) ELSE r.target END)
                   IN (SELECT f FROM built))
    OR EXISTS (SELECT 1 FROM refs r JOIN code j ON j.kind = 'job_folder' AND idnum(j.id) = idnum(r.target)
               WHERE r.scope = 'canonical' AND r.rel = 'data_flow_flow' AND r.source = s.id))
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'contract_file' AND idnum(k.id) = idnum(s.id))
UNION ALL
SELECT k.id,
  CASE WHEN d.id IS NULL THEN 'the file names no data flow of the docs'
       ELSE 'the file names a data flow that is not between an app and the server' END, k.path
FROM code k LEFT JOIN data_flows d ON idnum(d.id) = idnum(k.id)
WHERE k.kind = 'contract_file'
  AND NOT EXISTS (SELECT 1 FROM app_server s WHERE idnum(s.id) = idnum(k.id))
ORDER BY 1, 3;

-- check: CODE-06
-- title: Every folder of src/server/jobs/ is named after a flow of the docs (FL-09-expire-coupons), like every FL folder of src/platform/, one folder per flow
-- how: Query
-- severity: Major
-- needs: code, flows
SELECT k.written AS folder, k.path,
  CASE WHEN k.id IS NULL THEN 'its name does not start with a flow ID (FL-09-expire-coupons)'
       ELSE 'names ' || k.id || ', which is not a flow of the docs' END AS problem
FROM code k
WHERE k.kind = 'job_folder'
  AND (k.id IS NULL OR NOT EXISTS (SELECT 1 FROM flows f WHERE f.scope = 'canonical' AND idnum(f.id) = idnum(k.id)))
UNION ALL
SELECT GROUP_CONCAT(written, ', '), GROUP_CONCAT(path, ', '), 'several folders for ' || MIN(id)
FROM code
WHERE kind = 'job_folder' AND id IS NOT NULL
GROUP BY idnum(id)
HAVING COUNT(*) > 1
ORDER BY 2;

-- check: CODE-07
-- title: Every background job (a flow FL that a data flow cites in its `flows`) has its job folder
-- how: Query, then read
-- severity: Minor
-- needs: code, data_flows
-- Each row is a job not built yet: a finding only when the backlog says it is done.
SELECT r.target AS flow, GROUP_CONCAT(DISTINCT r.source) AS cited_by, 'no job folder is named after it' AS problem
FROM refs r
WHERE r.scope = 'canonical' AND r.rel = 'data_flow_flow'
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'job_folder' AND idnum(k.id) = idnum(r.target))
GROUP BY r.target
ORDER BY r.target COLLATE idnum;

-- check: CODE-08
-- title: Every rule (BR), criterion (AC) and requirement (NFR) of a built feature has a test named after it (it("BR-012-3: …")), and every test named after one names an ID of the specs, in the folder of its feature
-- how: Query
-- severity: Major
-- needs: code, specs
-- A feature is built once it has a folder on either side. Hidden tests live in another repo and are not read.
WITH built AS (SELECT DISTINCT idnum(id) AS f FROM code WHERE kind = 'feature_folder' AND id IS NOT NULL),
spec AS (SELECT id, path, line,
           CASE WHEN id LIKE '%-X-%' THEN NULL
                ELSE idnum('F-' || substr(id, instr(id, '-') + 1, instr(substr(id, instr(id, '-') + 1), '-') - 1)) END AS f
         FROM defs WHERE scope = 'canonical' AND expected_kind IN ('rule', 'criterion', 'nfr'))
SELECT s.id, 'its feature is built, and no test is named after it' AS problem, s.path, s.line
FROM spec s
WHERE s.f IN (SELECT f FROM built)
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'test_name' AND idnum(k.id) = idnum(s.id))
UNION ALL
SELECT k.id, 'the test names no rule, criterion or requirement of the specs', k.path, k.line
FROM code k
WHERE k.kind = 'test_name'
  AND NOT EXISTS (SELECT 1 FROM spec s WHERE idnum(s.id) = idnum(k.id))
UNION ALL
SELECT k.id, 'the test sits in the folder of ' || k.feature || ', not of its feature', k.path, k.line
FROM code k JOIN spec s ON idnum(s.id) = idnum(k.id)
WHERE k.kind = 'test_name' AND k.feature IS NOT NULL AND s.f IS NOT NULL AND idnum(k.feature) != s.f
ORDER BY 1, 3;

-- check: CODE-09
-- title: Every app-wide criterion and requirement (AC-X, NFR-X) has a test, a benchmark or a load scenario named after it
-- how: Query, then read
-- severity: Minor
-- needs: code, specs
-- Each row is a lead: one checked outside the code (an audit, a penetration test) or not built yet is not a finding.
SELECT d.id, d.name, 'no test is named after it' AS problem, d.path, d.line
FROM defs d
WHERE d.scope = 'canonical' AND d.expected_kind IN ('rule', 'criterion', 'nfr') AND d.id LIKE '%-X-%'
  AND NOT EXISTS (SELECT 1 FROM code k WHERE k.kind = 'test_name' AND idnum(k.id) = idnum(d.id))
ORDER BY d.id COLLATE idnum;
