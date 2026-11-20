# Design and docs: newest vs current

Compared on 2026-11-20. Prompt 8 sorted findings 3, 4, 7 and 8 of the check: the two camera features become one (D-047, F-069 retired into the variant F-046.a), a refused invitation is deleted (D-048), the Post gets its tagged people and place, and the « code expiré » state lists « Renvoyer le code ».

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 115 -> 130)
- **D-047 « Une seule feature pour prendre une photo »** (new): F-069 « Prendre une photo pour un post » becomes the variant F-046.a of F-046 « Prendre une photo » and is retired (`ids_retires`). The camera button above the grid (P-12) and « Ouvrir l'appareil photo » of the empty gallery (P-12.a) take the same photo for the post. The design stays as it is.
- **F-046**: new description « Bouton appareil photo au-dessus de la grille : la photo prise devient la photo du post. »; variant F-046.a (P-12, P-12.a) « « Ouvrir l'appareil photo » depuis la galerie vide (D-047) »; entities E-04 and E-03; F-069's two open questions (camera screen, camera permission) move here.
- **F-069** removed, listed in `ids_retires` with D-047. P-12 and P-12.a now list F-046.a; F-044's empty-gallery state cites F-046.a; E-03 and E-04 `utilisee_par` updated; « Regroupements effectués » gains an F-046 row.
- **D-033**: « Remplacée en partie par D-047 » added; its reason no longer says that no feature takes a photo. **D-040**: « P-12.a : F-046.a, ex-F-069 (D-047) ».
- **D-048 « Invitation refusée »** (new): refusing (F-028.a) deletes the request; **E-09** `statut` is now « en attente, demandé, ami » (« refusé » removed), and the sender can send a new request.
- **E-03 Post**: new fields `personnes identifiées` (F-048) and `lieu` (F-049).
- **P-02.b « Code expiré »** now lists F-008, and **F-008** lists P-02.b in its pages.

### Fake scrolling — inventaire des écrans (`inventaire-des-ecrans.md`, rev 105 -> 106)
- P-02 « Renvoyer le code »: adds « code expiré (P-02.b) : bouton « Renvoyer un code » à la place de « Se connecter » ».

## Unchanged

Design canvas `fake-scrolling-app` (66 files).
