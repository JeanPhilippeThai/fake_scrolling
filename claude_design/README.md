# Fake scrolling — design (copie locale)

Copie du canvas claude.ai « Fake scrolling — app » (https://claude.ai/artifact/9fxJvdH8dPEDrrLKNWerJT), importée le 2026-11-18.

## Ouvrir

Depuis ce dossier :

```bash
python3 -m http.server 8000
```

Puis ouvrir http://localhost:8000/ dans le navigateur. `index.html` montre les 7 écrans côte à côte, comme sur le canvas. Chaque `*.dc.html` s'ouvre aussi seul en pleine page.

Ouvrir `index.html` directement depuis le disque marche aussi en général. Le serveur local évite les restrictions `file://` de certains navigateurs.

## Contenu

| Fichier | Écran | Pages du registre |
| --- | --- | --- |
| `Login.dc.html` | Connexion | P-01 |
| `Code.dc.html` | Code reçu par e-mail | P-02 |
| `Main.dc.html` | Accueil (fil du jour) | P-03 à P-07 |
| `Chat.dc.html` | Messages | P-08 à P-11 |
| `Compose.dc.html` | Créer un post | P-12, P-13, P-24 à P-26 |
| `Search.dc.html` | Recherche | P-14 à P-16 |
| `Profile.dc.html` | Profil et réglages | P-17 à P-23 |
| `canvas.json` | Disposition du canvas d'origine (positions, titres) | — |
| `support.js` | Moteur de rendu Design Component, avec React 18 inclus | — |

Tous les écrans sont des maquettes mobiles interactives de 390 × 844. Il n'existe pas de design web ou desktop pour Fake scrolling.

## Notes

- `support.js` est le `dc-runtime.js` du type d'artefact Design. Chaque écran le charge avec `<script src="./support.js">`.
- Seules les polices (Bricolage Grotesque, IBM Plex) viennent du réseau, depuis Google Fonts. Hors ligne, des polices de remplacement s'affichent.
- Le thème d'icône choisi dans Profil est gardé dans le `localStorage` du navigateur (clé `fs-theme`).
- Pour modifier le design, éditer le canvas sur claude.ai puis réimporter. Cette copie n'est pas synchronisée.
