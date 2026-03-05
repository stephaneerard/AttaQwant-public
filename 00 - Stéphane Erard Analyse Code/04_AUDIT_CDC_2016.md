# L'audit CDC fraudé de juin 2016 — Analyse forensique de la branche « demo »

**Preuve de falsification du code source pour l'audit CDC/Cardiweb — Juin 2016**

Document établi à partir du dépôt git API-API-TAG-PACKAGER et des emails internes Qwant — Mars 2026

---

## 1. Objet de l'analyse

Le présent document analyse le dépôt git « API-API-TAG-PACKAGER » (code source de l'API front Qwant, framework CodeIgniter PHP) afin d'établir la preuve matérielle qu'une branche nommée « demo » a été délibérément créée pour falsifier le code source présenté à l'auditeur CDC/Cardiweb en juin 2016.

Cette branche a supprimé tous les appels à l'API Bing et les a remplacés par des appels « fake » (terme utilisé par le développeur lui-même) à un service « WebBrain » dont le tableau de locales était initialisé à vide — **100% des requêtes continuaient d'aller sur Bing**. Le code falsifié a ensuite été mergé dans la branche de production et livré dans 125 releases.

## 2. Contexte : l'audit CDC-DIDL / Cardiweb

| Élément | Détail |
|--------|--------|
| **Mandant** | Caisse des Dépôts et Consignations (CDC), dans le cadre d'une due diligence avant investissement de 15 millions d'euros dans Qwant SAS |
| **Auditeur** | Benjamin Dossat, Directeur Technique, Cardiweb (14 rue Auber, 75009 Paris) |
| **Contacts CDC** | Cédric Clément, Marion Eymar, Nicolas Guerin (@caissedesdepots.fr) |
| **Kick-off** | ~mi-mai 2016. Journée sur site prévue le 31 mai → reportée |
| **Audit réel** | Durant juin 2016 (entre ~21 et ~28 juin d'après les emails) |

## 3. La chaîne d'emails « Audit de code » (17-20 juin 2016)

Les captures Thunderbird du webmail Zimbra de Stéphane Erard (s.erard@qwant.com) établissent la chronologie suivante :

### 3.1. JC Chemin — 17 juin 2016, 20:44

Le CTO transfère à l'équipe technique (Vignaux, Luddeni, Massiere, Erard, Cassar, Corbi, Savinel, Laville) la liste des projets que Cardiweb souhaitait auditer. **C'est l'acte déclencheur de la falsification.**

### 3.2. Pierre Vignaux — 20 juin 2016, 09:25

Vignaux propose des intervenants pour chaque projet, puis pose une question révélatrice suivie d'une proposition opérationnelle :

> La question fondamentale est : « il faut préparer l'API avant ». Pourquoi faudrait-il procéder à des modifications du code source pour le montrer à un auditeur, si Qwant disposait réellement de son propre moteur de recherche ? Le besoin même de « préparer » l'API révèle que le code en production ne pouvait pas être montré tel quel — parce qu'il n'était qu'un proxy vers Bing. **La proposition subsidiaire « sur une branche à part » est la genèse opérationnelle de la branche « demo ».**

### 3.3. Jonathan Cassar — 20 juin 2016, 09:53

Vingt-huit minutes plus tard, Cassar répond à toute l'équipe (JC Chemin en copie) :

> **« retiré le code d'appel a Bing » — « call fake » — « Comme demandé » — « juste un fake » — « Prez de l'api »** (présentation pour l'audit)

**Constat :** La rapidité d'exécution et la simplicité de la modification démontre qu'il ne s'agit que d'un déport d'appel de l'api vers un nouveau service « webBrain ».

Ce service WebBrain est une instance du logiciel WebBrain qui a été modifié pour procéder lui-même aux appels à l'API Bing : **c'est un « proxy ».**

C'est d'ailleurs ce pourquoi Stéphane Erard a du produire une CI pour WebBrain.

### 3.4. Stéphane Erard — 20 juin 2016, 10:36

Erard prépare les projets SonarQube (CI/QA) pour l'audit : FRONT/SEARCH, FRONT/BOARDS, FRONT/SEARCH-LITE, FRONT/BOARDS-LITE, INSTANT-ANSWERS (http://sonar.qwant.ci:9000/). **Cela confirme que l'audit n'avait pas encore eu lieu.**

### 3.5. Pierre Vignaux — 20 juin 2016, 10:51

> La question « On a + droit sur la date JC ? » prouve que la visite d'audit n'avait pas encore eu lieu au 20 juin.

## 4. Analyse du dépôt git

### 4.1. Structure du dépôt

| Paramètre | Valeur |
|-----------|--------|
| Repository | API-API-TAG-PACKAGER (Qwant front API, CodeIgniter PHP) |
| Workflow | Gitflow (feature branches → develop → prelive → master) |
| Tags | 180+ (v1.13.0 à v1.32.1) |
| Déploiement | Script bin/mep.sh — git clone + rsync vers serveurs de production |

### 4.2. Commits de la branche « demo »

| Date | Événement |
|------|-----------|
| 9 juin 2016 | Premier commit : « get WebBrain results » (Jonathan Cassar) |
| 21 juin 2016 | Commit : « web brain aggregator » |
| 22 juin 2016 | Commit : « update webBrain/bing » |
| 24 juin 2016 | Nettoyage massif (201 373 lignes supprimées) |
| 29 juin 2016 | **Merge** : Pierre Vignaux merge demo → develop (commit f5e6e5fbe, MR !995) |
| 30 juin 2016 | **Tag v1.19.0** : merge prelive → master = release de production |

**Diff total :** 2 159 fichiers modifiés, 37 127 insertions, 201 373 suppressions

### 4.3. Modification de search_web.php

**AVANT la branche demo — appel direct à Bing :**

```php
// Code original : appel direct à l'API Bing
```

**APRÈS la branche demo — façade WebBrain (tableau vide) :**

```php
$webBrainLocales = [];  // Tableau vide — 100% Bing
```

**Constat :** `$webBrainLocales` est initialisé à un tableau vide `[]`. **Aucune locale ne correspond. 100% des requêtes vont sur Bing.** WebBrain est purement cosmétique — une façade pour tromper l'auditeur.

### 4.4. Tags contenant la branche demo

Le merge de la branche demo (f5e6e5fbe) est contenu dans **125+ tags** de v1.19.0 (30 juin 2016) à v1.32.1 (dernier tag). Chaque tag correspond à un merge prelive → master, soit une mise en production.

## 5. Corroboration : email Vignaux du 28 juin 2016

Cet email confirme que l'audit était encore en cours le 28 juin (« bientôt terminé »). **L'audit s'est donc déroulé durant juin 2016, sur le code falsifié de la branche « demo ».**

## 6. Chronologie consolidée

```
17 juin 2016, 20:44     → JC Chemin envoie liste d'audit à l'équipe
20 juin 2016, 09:25     → Vignaux : « il faut préparer l'API » + « branche à part »
20 juin 2016, 09:53     → Cassar : « retiré le code d'appel a Bing, call fake »
20 juin 2016, 10:36     → Erard : préparation SonarQube
20 juin 2016, 10:51     → Vignaux : « On a + droit sur la date JC ? »
21-24 juin 2016         → Commits de falsification massifs
28 juin 2016            → Vignaux : audit « bientôt terminé »
29 juin 2016            → Merge demo → develop (f5e6e5fbe)
30 juin 2016            → Tag v1.19.0 — production
```

## 7. Qualification juridique

### 7.1. Escroquerie (art. 313-1 CP)

- **Manœuvres frauduleuses :** création d'une branche « demo » avec code « fake » (mot utilisé par le développeur) pour masquer l'appel à Bing devant l'auditeur mandaté par la CDC
- **Tromperie de la victime :** CDC/Cardiweb n'a pas détecté Bing pendant l'audit de juin 2016
- **Remise de fonds :** 15 millions d'euros d'investissement public (janvier 2017)
- **Intention :** « Comme demandé » = ordre hiérarchique ; préméditation documentée sur 3 semaines (9-30 juin)

### 7.2. Faux et usage de faux (art. 441-1 CP)

Le code source présenté à l'auditeur était une version falsifiée (branche « demo »). Le vrai code (branche develop/master) appelait Bing à 100%. **Altération de la vérité dans un document technique servant de base à un investissement de 15 millions d'euros de fonds publics.**

### 7.3. Participation (art. 121-6 et 121-7 CP)

| Rôle | Personne | Détail |
|------|----------|--------|
| **Commanditaire** | JC Chemin | Organise l'audit (17 juin), en copie du « comme demandé » |
| **Exécutant** | Jonathan Cassar | Développe le code « fake », utilise le mot « fake » deux fois |
| **Co-organisateur** | Pierre Vignaux | Propose la « branche à part », merge le code le 29 juin |
| **Informé** | Frédéric Luddeni | En copie de toute la chaîne d'emails |

## 8. Pièces jointes

1. **Pièce 1** — Email JC Chemin → équipe technique, 30 mai 2016 — programme audit CDC-DIDL (PDF Zimbra)
2. **Pièce 2** — Email JC Chemin, 17 juin 2016 — « Voici les projets que voulait auditer Cardiweb » (capture cardiweb_1.PNG)
3. **Pièce 3** — Email Pierre Vignaux, 20 juin 2016 09:25 — « il faut préparer l'API, branche à part ? » (capture cardiweb_2.PNG)
4. **Pièce 4** — Email Jonathan Cassar, 20 juin 2016 09:53 — « branche demo, retiré Bing, fake. Comme demandé. » (capture cardiweb_3.PNG)
5. **Pièce 5** — Email Stéphane Erard, 20 juin 2016 10:36 — préparation SonarQube (capture cardiweb_4.PNG)
6. **Pièce 6** — Email Pierre Vignaux, 20 juin 2016 10:51 — « On a + droit sur la date JC ? » (capture cardiweb_5.PNG)
7. **Pièce 7** — Email Pierre Vignaux → Stéphane Erard, 28 juin 2016 — « audit bientôt terminé » (Gmail)
8. **Pièce 8** — Extraction git : log branche « demo », diff search_web.php, liste des 125+ tags (v1.19.0 à v1.32.1)

---

**Document établi à partir des pièces du dossier — Mars 2026**

---

[← Sommaire](00_SOMMAIRE.md) | [← Tribune](03_TRIBUNE.md) | [Décision CNIL →](05_CNIL_VALIDATION.md)

---

Document compilé par Stéphane Erard — Mars 2026 — Contact : stephane.erard@proton.me
