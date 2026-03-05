# La décision CNIL de février 2025 — Validation et paradoxe

[← Sommaire](00_SOMMAIRE.md) | [← Audit CDC](04_AUDIT_CDC_2016.md) | [Accusations vs Réalité →](06_ACCUSATIONS_VS_REALITE.md)

---

## Contexte

- **Plainte déposée** : 2019
- **Décision de clôture** : Février 2025
- **Référence CNIL** : Saisine n°19005268, Instruction Vincent Bringer
- **Réponse d'Erard** : 25 juin 2025

---

## PARTIE I : La décision de la CNIL (février 2025)

### 1. La plainte initiale

Stéphane Erard a saisi la CNIL en 2019 contre Qwant, contestant que contrairement aux affirmations publiques de la société, celle-ci collectait des données personnelles à l'insu des utilisateurs de son moteur de recherche et les transmettait à **Microsoft Ireland Operations Limited** à des fins d'affichage de contenus publicitaires.

### 2. Constats techniques de la CNIL après contrôles

| Élément | Constat |
|---------|---------|
| **Données transmises** | IP tronquée (IP/24) + identifiant + données techniques essentielles |
| **Destinataire** | Microsoft Ireland Operations Limited |
| **Finalité** | Affichage de résultats de recherche et publicités contextuelles |
| **Prétention de Qwant** | Les données étaient « anonymisées » avant transmission |

### 3. Conclusion de la CNIL : qualification juridique

La CNIL constate, après « analyses approfondies » :

> Les données transmises à Microsoft Ireland Operations Limited **ne pouvaient pas être qualifiées d'anonymes mais de pseudonymes**.

Texte exact de la décision : « compte tenu notamment des recommandations et jurisprudences pertinentes à l'époque des faits, les données transmises à la société Microsoft Ireland Operations Limited ne pouvaient pas être qualifiées d'anonymes ».

### 4. Manquements relevés à l'encontre de Qwant

| Manquement | Article RGPD | Détail |
|-----------|--------------|--------|
| Qualification inexacte | Art. 12-13 | Qwant qualifiait les données d'« anonymes » au lieu de « pseudonymes » |
| Finalité cachée | Art. 12-13 | Aucune mention de la finalité publicitaire dans la politique de confidentialité |
| Base légale absente | Art. 12-13 | La base légale du traitement n'était pas indiquée |
| Incohérence multilingue | Art. 12-13 | Les versions italienne et allemande différaient des versions française et anglaise (jusqu'au 21 février 2020) |

**Qualification juridique** : Méconnaissance des obligations de transparence et d'information (articles 12 et 13 du RGPD).

### 5. Corrections apportées par Qwant (2020)

Dès 2020, Qwant a corrigé sa politique de confidentialité en remplaçant :
- « anonymes » → « pseudonymes »
- Ajout de la base légale
- Ajout de la finalité publicitaire
- Harmonisation dans toutes les langues

### 6. Procédure européenne de coopération

Procédure longue en vertu du Chapitre VII du RGPD :

```
1er projet de décision
    ↓ (objection d'une autorité)
2e projet révisé
    ↓ (objections de deux autorités)
Saisine du CEPD (article 65§1.a RGPD)
    ↓ (consensus des autorités)
Approbation finale (article 60§6 RGPD)
```

Résultat : Les autorités européennes ont retiré leurs objections ; le projet révisé est approuvé.

### 7. Sanction prononcée

**Nature** : Simple rappel à l'ordre (article 58.2.b du RGPD, article 20.III de la loi Informatique et Libertés)

**Motif de clémence** : La « célérité » avec laquelle Qwant a corrigé les manquements.

**Amende** : Aucune amende prononcée.

---

## PARTIE II : Réponse de Stéphane Erard (25 juin 2025)

Email adressé à SEDP@cnil.fr. Stéphane Erard annonce son intention de porter plainte contre les services de la CNIL et développe sept arguments.

### Argument n°1 : L'IP/24 est une donnée personnelle indirecte

> L'IP/24 permet indirectement de récupérer la commune de résidence de l'utilisateur.

Erard conteste la qualification par la CNIL de l'IP/24 comme simple « donnée technique ». Il demande une confirmation formelle que l'IP/24 est bien une donnée personnelle indirecte selon la propre définition de la CNIL.

### Argument n°2 : Le comportement litigieux remonte à 2016, non à 2019

Erard reproche à la CNIL de ne pas avoir recherché depuis **quand** le comportement frauduleux avait commencé. Il produit l'historique du code source du fichier « search_ads » (pages 6 et 14) montrant :

| Fait | Preuve |
|------|--------|
| Fonction `anonymizeIp()` créée en juin 2016 | Pierre Vignaux (Tech Lead) |
| Fonctionnement réel | Remplace simplement le dernier octet par des zéros (ne constitue pas une anonymisation) |
| Connaissance interne | Erard l'a dit personnellement à Pierre Vignaux |
| Accès aux preuves | La CNIL disposait de cet historique depuis fin 2019 |

### Argument n°3 : Intention délibérée de fraude (2016-2020)

Erard développe le raisonnement suivant :

**Conscience du traitement de données** : Pour produire l'IP/24 à partir de l'IP complète, il faut nécessairement opérer un traitement de données à caractère personnel. Un Tech Lead sait nécessairement qu'il y a un traitement en cours.

**Nommage trompeur** : La fonction s'appelle `anonymizeIp()` alors qu'elle ne fait que tronquer. Erard affirme avoir expliqué à Vignaux que cette fonction n'anonymisait pas.

**Non-divulgation** : Ce traitement n'a jamais été décrit aux utilisateurs, ce qui constitue une **intention délibérée de fraude** selon Erard.

**Promesse contredicatoire** : Les données tronquées étaient envoyées à Bing Ads « tout en promettant la sécurité de la vie privée » pendant 4 ans.

### Argument n°4 : Audit maquillé pour la Caisse des Dépôts (2016-2017)

Erard dénonce un audit maquillé lors de l'entrée de la CDC au capital de Qwant :

| Élément | Allégation |
|---------|-----------|
| **Période** | 2017, due diligence CDC |
| **Modification du code** | Code modifié après l'audit pour la CDC (mai 2016) |
| **Réunion de team leaders** | Jean-Charles Chemin aurait déclaré : « Ce qui va être dit ici ne doit pas en sortir » |
| **Durée de la fraude** | 4 ans de mensonges à la concurrence |
| **Conséquence** | Cela a permis à Qwant de faire entrer la CDC au capital |
| **Alternative** | « En 2016, Qwant devait être mis en liquidation s'il n'avait pas fraudé l'audit de la CDC » |

### Argument n°5 : Licenciement pour avoir dit la vérité

Erard rappelle qu'il a été **licencié précisément pour avoir dénoncé publiquement sur Twitter que l'IP/24 n'est pas anonyme et est envoyée à Bing**.

> Il l'avait déjà dit en interne. Qwant savait qu'ils fraudaient.

### Argument n°6 : La DPO (Victoire Yau) était informée dès décembre 2016

Erard produit une conversation avec Victoire Yau (DPO de Qwant) datant de décembre 2016 :

| Fait | Détail |
|------|--------|
| **Sujet** | Envoi de données pseudo-anonymisées à Bing |
| **Affirmation d'Erard** | Les CGU ne mentionnent pas cet envoi ; au sens de la CNIL, les données pseudo-anonymisées ne sont pas des données anonymisées |
| **Réponse de Yau** | L'ajout de Bing dans les FAQ « semble avoir été fait après [la] mise en arrêt maladie » d'Erard |
| **Contre-affirmation de Yau** | « On n'envoie rien à Bing, c'est eux qui récupèrent l'IP » — Erard conteste formellement |
| **Conclusion d'Erard** | Soit Victoire Yau « ment », soit « elle ne sert à rien dans son travail » de DPO |

### Argument n°7 : Critique de la décision CNIL

Erard reproche à la CNIL :

1. **Non-reconnaissance de la fraude** : « Qui est pourtant flagrante et qui a duré 4 ans »
2. **Euphémisme inacceptable** : Parler d'« erreur d'analyse » est « injustifiable » — c'est la CNIL elle-même qui a commis une erreur en ne cherchant pas depuis quand Qwant agissait ainsi
3. **Absence de sanction financière** : Aucune amende n'a été prononcée
4. **Questions manquantes** : La CNIL n'a pas posé les questions permettant de comprendre comment Qwant en est arrivé là
5. **Absence de responsabilisation** : « À quoi sert le DPO ? », « Comment cela a-t-il pu passer en prod ? »
6. **Sémantique erronée** : Qualifier d'« erreur d'analyse » un comportement délibéré est faux. « Dès qu'on traite l'IP, on sait qu'il y a un TDCP et qu'il faut le mettre en page d'information appropriée »

---

## PARTIE III : Synthèse — Ce que la CNIL confirme et ce qu'elle omet

### Ce que la CNIL confirme (donnant raison à Erard)

| Point | Validation CNIL |
|-------|-----------------|
| **Données non anonymes** | ✓ Les données transmises à Microsoft n'étaient PAS anonymes mais **pseudonymes** |
| **Politique de confidentialité inexacte** | ✓ Qwant qualifiait à tort les données d'« anonymes » |
| **Incomplétude** | ✓ La finalité publicitaire de la transmission n'était pas mentionnée |
| **Absence de base légale** | ✓ La base légale du traitement n'était pas indiquée |
| **Incohérence multilingue** | ✓ Les versions italienne et allemande différaient des versions française et anglaise |
| **Violation des articles 12-13 RGPD** | ✓ Méconnaissance des obligations de transparence et d'information |

**En clair** : La CNIL confirme le cœur même de la dénonciation d'Erard.

### Ce que la CNIL n'a pas retenu (selon Erard)

| Point | Omission CNIL |
|-------|---|
| **Intention de fraude** | ✗ Non retenue, qualifiée d'« erreur d'analyse » |
| **Durée du manquement** | ✗ La CNIL n'a pas cherché depuis quand (2016) |
| **Maquillage d'audit** | ✗ Non examiné (audit CDC 2016-2017) |
| **Rôle de la DPO** | ✗ Victoire Yau était informée depuis décembre 2016 — aucune mention |
| **Licenciement d'Erard** | ✗ Aucune reconnaissance que l'informateur a été licencié pour avoir dénoncé exactement ce que la CNIL confirme |
| **Impact concurrentiel** | ✗ Aucune mention de la fraude au détriment de la concurrence et des investisseurs publics (CDC, BEI) |
| **Sanction financière** | ✗ Aucune amende prononcée |

### Le paradoxe soulevé par Erard

```
CNIL (2025) confirme :
  Les données envoyées à Microsoft par Qwant sont pseudonymes,
  non anonymes comme Qwant le prétendait.

MAIS :

Stéphane Erard a été LICENCIÉ en 2017 pour avoir dit exactement cela.

Qwant l'a poursuivi en diffamation (tribunal correctionnel).

Ses propos ont été qualifiés de « dénigrants et mensongers »
aux prud'hommes.

→ 8 ans plus tard, la CNIL reconnaît que c'était exactement la vérité.
```

**La question centrale** : Comment un lanceur d'alerte a-t-il pu être poursuivi et licencié pour avoir dénoncé ce que l'autorité de régulation elle-même confirme aujourd'hui comme une violation des règles en vigueur ?

---

## Conclusion

La décision CNIL de février 2025 valide la substance des allégations de Stéphane Erard tout en refusant de qualifier le comportement de fraude délibérée et sans imposer de sanction financière. Ce paradoxe soulève des questions fondamentales sur :

- Le rôle des lanceurs d'alerte dans la détection des violations de conformité
- L'efficacité des contrôles de conformité interne (DPO, audit)
- La durée réelle des manquements et leur gravité
- La responsabilité de Qwant envers ses investisseurs publics
- La protection des lanceurs d'alerte en droit français

---

Document compilé par Stéphane Erard — Mars 2026 — Contact : stephane.erard@proton.me

[← Sommaire](00_SOMMAIRE.md) | [← Audit CDC](04_AUDIT_CDC_2016.md) | [Accusations vs Réalité →](06_ACCUSATIONS_VS_REALITE.md)
