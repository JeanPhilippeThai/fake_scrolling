# Design and docs: newest vs current

Compared on 2026-11-26. The only change: the registry now holds the stack chosen at step 8 (D-132 to D-135). The design hasn't changed.

## Docs

### Registre canonique – Fake scrolling (`registry.md`, rev 428 -> 429)
- **D-132 Étape 8 : appli mobile**: one app for iOS and Android, React Native with Expo, in TypeScript; the generated art is drawn by Skia (react-native-skia) on both phones, at 60 fps (NFR-X-13); accessible names through React Native's accessibility props (NFR-X-14).
- **D-133 Étape 8 : serveur**: TypeScript on Node.js with Fastify; HTTPS (NFR-X-6); live messages and « en train d'écrire » (D-084) pushed over a WebSocket while the app is in the foreground; request types and the art description (D-119) live in one package shared with the app.
- **D-134 Étape 8 : stockage du serveur**: one managed PostgreSQL database for every server entity (E-01 to E-12, E-14 to E-16) and the deleted-accounts list of D-128; backups kept 7 days at most (NFR-X-4); live messages fan out through PostgreSQL LISTEN/NOTIFY, with no other store or queue.
- **D-135 Étape 8 : stockage du téléphone**: SQLite (expo-sqlite) on the phone for FL-12's pending sends, in order, the search history (E-13) and the display preferences (E-17); the session goes in the Keychain/Keystore through expo-secure-store (NFR-X-9); the draft stays in memory and is lost on a forced close (D-121).

## Unchanged

Design canvas « Fake scrolling — app » (70 files); « Conception système – Fake scrolling » (rev 147); « Fake scrolling — inventaire des écrans » (rev 152).
