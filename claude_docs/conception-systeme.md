<!-- Source: https://claude.ai/artifact/V35ZLk13bPhs4byZvSoaXg, tab "Tab 1", rev 2, exported 2026-11-24 -->
# Conception système – Fake scrolling

Nov 24, 2026 · @Jp

Les flows de l'appli (prompt 5 de la méthode), un par section, écrits uniquement avec les IDs du [Registre canonique – Fake scrolling](https://claude.ai/artifact/A5qaJU9xAkPWfJ6JUNfWHV). Les choix qu'ils ont demandés sont dans les `decisions` du registre.

## FL-01 Se connecter

Une personne non connectée (R-01) arrive sur P-01 et en ressort connectée (R-02) sur P-03, par un compte tiers ou par un code reçu par e-mail. Mobile seulement. Décisions : D-024, D-052, D-053, D-054.

### Entrées

- Ouverture de l'appli sans session sur l'appareil → P-01. Avec une session ouverte, l'appli s'ouvre sur P-03 sans passer par ce flow (D-053).
- Lien de post ouvert sans connexion → P-01 ; le post attend la fin du flow (D-024, D-054).
- Déconnexion F-071 sur P-21, ou suppression du compte F-063 → P-01 (D-053).

### Séquence

| Étape | Page | Feature | Entités lues | Entités écrites |
| --- | --- | --- | --- | --- |
| 1. Accueil de la connexion | P-01 | F-002, F-004 | E-17 (thème de l'icône) | — |
| 2a. Compte tiers | P-01 → P-01.a | F-001 (Google) ou F-001.a (Apple) | E-02 (fournisseur), E-01 (compte existant ?) | E-02 (fournisseur, session) |
| 2b. Demande du code | P-01 → P-01.d | F-003 | — | E-02 (adresse e-mail, code à 6 chiffres, délai avant renvoi) |
| 3b. Saisie du code | P-02 | F-006, F-007 | E-02 (adresse, code), E-01 (compte existant ?) | E-02 (session) |
| 3b'. Renvoi du code | P-02 | F-008 | E-02 (délai avant renvoi) | E-02 (nouveau code) |
| 4. Inscription, si aucun compte | P-27 | F-070 | E-02 (fournisseur ou adresse) | E-01 (pseudo, identifiant), E-02 (session) |
| 5. Arrivée sur le fil | P-03.a → P-03 | F-009 | E-03 (posts ; d'abord le post du lien, D-054) | — |

Suite simple : P-01 → F-001 / F-001.a → (P-27 → F-070) → P-03, ou P-01 → F-003 → P-02 → F-007 → (P-27 → F-070) → P-03. Les entités suivent les `operations` des features : F-003, F-008 écrivent E-02 ; F-006 la lit ; F-001, F-007, F-070 lisent et écrivent. À partir de P-03, le grisage F-024 s'applique ; P-01, P-02 et P-27 ne sont jamais grisées (D-009, D-019, D-052).

### Points de décision et erreurs

| Où | Cas | Suite |
| --- | --- | --- |
| P-01 | Compte tiers ou e-mail | F-001 / F-001.a, ou F-003 |
| P-01.a | Le fournisseur échoue | P-01.b : réessayer F-001 / F-001.a, ou passer à F-003 |
| P-01.a | Annulation sur l'écran du fournisseur | Retour à P-01, à confirmer avec cet écran (question ouverte de F-001) |
| P-01 | Adresse invalide | P-01.c : bouton désactivé, on reste sur P-01 |
| P-01.d | L'envoi du code échoue | P-01.e : « Réessayer » relance P-01.d |
| P-02 | Mauvaise adresse | F-005 : retour à P-01 |
| P-02 | Code faux | P-02.a : corriger les cases, puis F-007 |
| P-02 | Code expiré | P-02.b : F-008 « Renvoyer un code », puis P-02 |
| P-02 | Code pas reçu | F-008 après le décompte de 30 s |
| F-001, F-007 | Compte trouvé (lecture E-01) | P-03 |
| F-001, F-007 | Aucun compte | P-27, F-070 (D-052) |
| P-27 | Abandon | F-005 : retour à P-01, sans compte créé |
| P-27 | Identifiant pris, erreur d'enregistrement | Non dessinés (questions ouvertes de F-070) |
| P-03.a | Le fil ne charge pas | P-03.b : « Réessayer » (F-009) |
| P-03 | Post du lien expiré, supprimé ou hors audience | Non défini (question ouverte de F-009) |

Fin du flow : P-03, en R-02, session ouverte (D-053).

### Manques du registre

Ajoutés le 24 novembre 2026 :

- P-27 Inscription et F-070 Créer son compte : aucun écran ne faisait choisir le pseudo et l'identifiant d'un nouveau compte (D-052). À dessiner.
- F-071 Se déconnecter sur P-21, et la session dans E-02 : la seule sortie était la suppression du compte (D-053). À dessiner.
- La suite d'un lien de post après la connexion (D-054).

Restent ouverts, dans les `questions_ouvertes` des features :

- F-001 : l'écran d'autorisation du fournisseur et son annulation.
- F-007 : durée de validité du code et nombre d'essais faux avant blocage.
- F-070 : règles de l'identifiant ; photo et description à l'inscription ou plus tard ; états de chargement et d'erreur.
- F-071 : confirmation avant la déconnexion.
- F-009 : post du lien devenu invisible.
