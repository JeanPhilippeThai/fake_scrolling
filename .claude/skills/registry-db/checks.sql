-- The checks of workflow_docs/design_and_docs_check.md that a query can answer.
-- Each block starts with its header; each row it returns is a finding (how: Query)
-- or a lead to read before it becomes one (how: Query, then read).
-- needs: the docs content the check reads; without it the check is "not reached".
-- Scopes: 'canonical' is the registry in force; 'web', 'desktop', 'mobile' are archived per-platform registries.
-- A row whose `scope` column is not 'canonical' comes from a frozen archive: it is shown, and never fails the build.

-- check: L0-04
-- title: Every doc the database reads parses, and every item in it has an ID
-- how: Query
-- severity: Blocking
-- needs:
SELECT path, line, message FROM problems ORDER BY path, line;

-- check: L3-01
-- title: Every ID has its kind's format and is unique
-- how: Query
-- severity: Major
-- needs: registry
SELECT scope, id, 'a ' || expected_kind || ' whose ID reads as a ' || kind AS problem, path, line
FROM defs WHERE kind != expected_kind AND expected_kind IN ('role','page','feature','variant','entity','decision')
UNION ALL
SELECT scope, id, 'defined ' || COUNT(*) || ' times', GROUP_CONCAT(DISTINCT path), MIN(line)
FROM defs WHERE expected_kind IN ('role','page','feature','variant','entity','decision')
GROUP BY scope, id HAVING COUNT(*) > 1
ORDER BY 1, 2;

-- check: L3-02
-- title: Pages list their features and features list their pages, both ways (a variant counts for its feature)
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
-- title: Every item of every per-platform registry appears in the canonical registry through its alias
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
-- title: No per-platform ID is the alias of two canonical IDs, and no canonical ID has two aliases from the same platform
-- how: Query
-- severity: Major
-- needs: registry, multi_platform
WITH a AS (
  SELECT al.kind, al.id, al.alias, COALESCE(al.platform, p.platform) AS platform
  FROM aliases al LEFT JOIN pages p ON p.scope = 'canonical' AND p.id = al.id
)
SELECT platform AS alias_platform, alias AS id, 'alias of ' || COUNT(DISTINCT id) || ' canonical IDs: ' || GROUP_CONCAT(DISTINCT id) AS problem
FROM a GROUP BY platform, alias, kind HAVING COUNT(DISTINCT id) > 1
UNION ALL
SELECT platform, id, 'has ' || COUNT(DISTINCT alias) || ' aliases from ' || platform || ': ' || GROUP_CONCAT(DISTINCT alias)
FROM a GROUP BY platform, id HAVING COUNT(DISTINCT alias) > 1
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
SELECT a.id AS entity, a.platform, a.alias, f.field AS platform_field,
  'not found word for word in the canonical fields' AS problem
FROM aliases a
JOIN entity_fields f ON f.scope = a.platform AND f.entity = a.alias
WHERE a.kind = 'entity'
  AND NOT EXISTS (SELECT 1 FROM entity_fields c WHERE c.scope = 'canonical' AND c.entity = a.id
                  AND LOWER(TRIM(c.field)) = LOWER(TRIM(f.field)))
ORDER BY 1, 2, 4;

-- check: L4-13
-- title: No later document still uses a per-platform ID instead of the canonical one
-- how: Query
-- severity: Major
-- needs: registry, multi_platform
SELECT m.path, m.line, m.id, 'per-platform ID, not defined in the canonical registry' AS problem
FROM mentions m
WHERE m.scope = 'canonical'
  AND m.path NOT IN (SELECT path FROM sources WHERE content = 'registry')
  AND m.kind IN ('role','page','feature','variant','entity','decision')
  AND NOT EXISTS (SELECT 1 FROM defs d WHERE d.scope = 'canonical' AND d.id = m.id)
  AND EXISTS (SELECT 1 FROM defs d WHERE d.scope != 'canonical' AND d.id = m.id)
ORDER BY 1, 2;

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
SELECT d.kind, d.id, 'no alias: find the decision that created it' AS problem, d.path
FROM defs d
WHERE d.scope = 'canonical' AND d.expected_kind IN ('role', 'page', 'feature', 'variant', 'entity')
  AND NOT EXISTS (SELECT 1 FROM aliases a WHERE a.id = d.id)
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
SELECT scope, id, 'a ' || expected_kind || ' whose ID reads as a ' || kind AS problem, path, line
FROM defs WHERE kind != expected_kind AND expected_kind NOT IN ('role','page','feature','variant','entity','decision')
UNION ALL
SELECT scope, id, 'defined ' || COUNT(*) || ' times', GROUP_CONCAT(DISTINCT path), MIN(line)
FROM defs WHERE expected_kind NOT IN ('role','page','feature','variant','entity','decision')
GROUP BY scope, id HAVING COUNT(*) > 1
ORDER BY 1, 2;

-- check: G-02
-- title: Every ID cited anywhere exists (for the kinds the database reads: P, F, E, R, D, TB, N, DF, C)
-- how: Query, then read
-- severity: Major
-- needs:
SELECT m.scope, m.id, m.path, GROUP_CONCAT(m.line) AS lines, 'cited, but not defined' AS problem
FROM mentions m
WHERE m.kind IN ('role','page','feature','variant','entity','decision','table','node','data_flow','component')
  AND EXISTS (SELECT 1 FROM defs k WHERE k.scope = m.scope AND k.expected_kind = m.kind)
  AND NOT EXISTS (SELECT 1 FROM defs d WHERE d.scope = m.scope AND d.id = m.id)
  AND NOT (m.path IN (SELECT path FROM sources WHERE content = 'registry')
           AND EXISTS (SELECT 1 FROM aliases a WHERE a.alias = m.id))
GROUP BY m.scope, m.id, m.path
ORDER BY 1, 2, 3;
