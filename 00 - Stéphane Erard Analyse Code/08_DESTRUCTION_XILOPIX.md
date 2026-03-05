# La destruction de Xilopix/Xaphir — 20 ans de R&D souveraine perdus

**De la destruction de Xilopix/Xaphir à la validation par la CNIL — Le plus grand fiasco de souveraineté numérique française**

Stéphane Erard
Lanceur d'alerte — Ancien développeur Qwant (2015–2017)
Mars 2026

---

## Introduction

La France disposait des compétences pour construire un moteur de recherche souverain. Elle les a méthodiquement détruites en pariant sur un projet qui n'en était pas un.

Ce document retrace vingt années de recherche et développement perdues pour la souveraineté numérique française. Il démontre comment Qwant, présenté depuis 2013 comme le « moteur de recherche français », n'a jamais été qu'un métamoteur dépendant à 75–100 % de Bing (Microsoft), tout en absorbant près de 100 millions d'euros d'argent public et en détruisant la seule alternative technologique réelle : Xilopix/Xaphir, un véritable moteur de recherche doté d'un index propriétaire, d'un robot d'indexation et d'algorithmes développés en France pendant huit ans.

Le récit qui suit s'appuie sur des faits validés par des sources multiples et convergentes : audits de la DINUM, décision de la CNIL de février 2025, rapport d'Eric Mathieu aux parlementaires, enquêtes de presse (La Lettre A, Mediapart, Next INpact, Le Media), et les propres déclarations des dirigeants de Qwant.

---

## Partie I — Qwant : 13 ans sans moteur propre (2011–2024)

### 1.1. Un métamoteur déguisé en moteur de recherche

Qwant est fondé en 2011 par Eric Léandri, Jean-Manuel Rozan et Patrick Constant (Pertimm). Le premier business plan de la société était centré sur l'exploitation de données personnelles : il s'agissait de développer un moteur capable d'agréger des données issues de Facebook, Google et d'autres sources. Ce n'est que par opportunisme que le positionnement a été réorienté vers la « souveraineté numérique » et le respect de la vie privée.

Le moteur est lancé en juillet 2013. Dès février 2013, Le Figaro révèle que Qwant utilise massivement les résultats de Bing pour alimenter ses colonnes Web et Live. Les fondateurs reconnaissent et minimisent cette dépendance. En réalité, les résultats de Bing représentaient la quasi-totalité des réponses affichées.

Selon Eric Léandri lui-même : « Nous avions mis au point une technologie de recherche, mais il fallait la faire mouliner sur des résultats. C'est pour cela que nous avons dû acheter des inventaires d'un moteur de recherche, en l'occurrence Bing. »

Cette dépendance n'a jamais été résolue. En août 2016, lorsque Stéphane Erard quitte l'entreprise en arrêt maladie, il n'existe aucun index web en production pour la section Web de Qwant Search : l'intégralité des résultats provient de Bing.

### 1.2. L'audit fraudé de 2016 et l'entrée de la CDC

Fin 2016, Qwant est au bord de l'effondrement. La société ne dispose que de 767 € en trésorerie et présente un taux d'endettement de 2 652 %. Bpifrance a déjà refusé de financer l'entreprise en raison de ses liens avec Bing.

Pour obtenir l'entrée de la Caisse des Dépôts et Consignations (CDC) dans son capital, Qwant organise un audit technique confié au cabinet Cardiweb. Des emails internes révèlent que le CTO Jean-Charles Chemin a demandé aux équipes de « faire le tour de ses projets pour remonter tout ce qu'il peut y avoir de sensible » et de ne faire « aucune mention de Bing » lors de l'audit. Une branche spéciale « demo » a été créée sur le dépôt de l'API pour en retirer les appels à Bing et les remplacer par de faux appels internes.

Sur la base de cet audit falsifié, la CDC investit 15 millions d'euros début 2017, valorisant Qwant à 75 millions d'euros — une valorisation fondée sur une comparaison trompeuse avec un véritable moteur de recherche. Le commissaire aux apports demande une réévaluation sous deux ans : elle n'aura jamais lieu.

### 1.3. L'envoi de données non anonymisées à Microsoft

C'est après l'audit pour la CDC que le code d'envoi de données pseudo-anonymisées à Bing Ads a été intégré dans le système. Pierre Vignaux, développeur, a écrit le code d'intégration de Bing Ads qui transmettait à Microsoft l'adresse IP (tronquée au dernier octet), le user-agent et les requêtes de recherche des utilisateurs. Le 15 juin 2016, le même jour où Bing Ads était déployé, Nicolas Corbi a supprimé la mention des publicités de la page de confidentialité de Qwant.

La CNIL a établi en février 2025 que ces données étaient « pseudonymes » et non « anonymes », contredisant directement les affirmations de Qwant. L'IP tronquée au dernier octet (/24) permet de géolocaliser un utilisateur à l'échelle d'un quartier, et combinée au user-agent, permet une réidentification.

### 1.4. Les audits officiels confirment la dépendance

En juillet 2019, sept ans après la création de Qwant, la Direction interministérielle du numérique (DINUM) réalise un audit technique. Les résultats sont accablants : Qwant utilise Bing dans plus de 75 % des cas. Fin septembre 2019, ce taux est encore de 65 %. Les auditeurs indiquent ne pas pouvoir exclure que les résultats soient composés quasi exclusivement de résultats Bing. La DINUM qualifie Qwant de simple « prototype » six ans après son lancement.

Comme le rapporte Next INpact : « Six ans après son lancement, Qwant n'était qu'un prototype, selon la DINUM. Mais Cédric O l'a validé sans attendre sa V2. »

Malgré ces constats, Cédric O, secrétaire d'État au Numérique, autorise l'usage de Qwant dans l'administration sans appel d'offres et sans second audit de la DINUM certifiant la V2.

### 1.5. La fin de l'illusion (2023–2024)

En juillet 2023, Octave Klaba (OVHcloud) rachète Qwant pour seulement 14 millions d'euros, alors que l'entreprise avait été valorisée 80 millions lors de sa dernière levée de fonds. C'est un aveu de destruction de valeur massive.

En novembre 2024, Qwant et Ecosia annoncent la création d'une coentreprise pour développer ensemble un index de recherche indépendant. Cette annonce, 13 ans après la création de Qwant, confirme ce que le lanceur d'alerte dénonçait depuis 2016 : la grande majorité des résultats affichés par Qwant provient toujours de Bing.

---

## Partie II — Xilopix/Xaphir : 8 ans de R&D détruits (2008–2017)

### 2.1. Un vrai moteur de recherche français

Xaphir est un moteur de recherche fondé en 2008 par la start-up Xilopix, basée à Épinal. À la différence de Qwant, la technologie était entièrement propriétaire : robot d'indexation, algorithmes de classement et index de recherche avaient été développés en interne pendant huit années de R&D intensive.

À la tête du projet : Eric Mathieu (CEO) et Cyril March (COO-CTO), respectivement président et co-fondateur du cluster image et numérique de la région Alsace. L'équipe comptait 35 personnes hautement qualifiées, dont 28 à la R&D, représentant 9 nationalités et 11 langues parlées. Parmi eux : une dizaine d'ingénieurs, six linguistes et des doctorants d'Inria.

### 2.2. Le mécanisme de destruction

Le mécanisme est simple et brutal. Eric Mathieu l'explique clairement : lorsqu'il apprend en février 2017 que la CDC investit dans Qwant, ses propres investisseurs gèlent immédiatement leurs intentions. La Banque européenne d'investissement (BEI) était déjà engagée sur Qwant. En misant sur un seul cheval, les investisseurs publics ont asséché le financement de tous les autres acteurs du secteur.

Privée de financement, Xilopix est placée en liquidation judiciaire. Qwant rachète la société pour seulement 200 000 euros — alors qu'Eric Mathieu estime sa valeur à 10 millions d'euros. Il avait même refusé une offre d'Alibaba par principe de souveraineté numérique.

### 2.3. La technologie rachetée, puis jetée

Le plus révélateur est la suite. Léandri déclare lui-même que « quand on a racheté Xilopix, on n'a pas eu accès à la technologie », alors que la raison officielle du rachat était justement la technologie. Next INpact révèle que Qwant ne comptait pas conserver Xaphir, qui pourrait être « mis au rebut avec les serveurs et la plupart des technologies ». L'intérêt résidait plutôt dans les employés.

Mais des 35 personnes de Xilopix, il ne reste bientôt plus que deux ingénieurs chez Qwant. Les fondateurs, Eric Mathieu et Cyril March, ont été éjectés après avoir travaillé cinq mois sans contrat ni salaire. Un contentieux prud'hommal les oppose encore à Qwant. La Cour de cassation a cassé un arrêt en leur faveur, renvoyant l'affaire en appel.

Eric Mathieu lui-même l'affirme : « Il n'existe pas de souveraineté numérique sans moteur de recherche. Le moteur de recherche, ce sont les yeux et les oreilles des gouvernants. »

### 2.4. Comparaison : Xilopix/Xaphir vs Qwant

| CRITÈRE | XILOPIX / XAPHIR | QWANT |
|---------|-----------------|-------|
| **Fondation** | 2008 (Épinal) | 2011 (Paris/Nice) |
| **Technologie** | 100% propriétaire | 75–100% Bing (Microsoft) |
| **Index propre** | Oui (robot, algorithmes, index) | Non (jamais en production) |
| **Équipe R&D** | 28 personnes, 9 nationalités | Effectif variable, pas de R&D moteur |
| **Partenaires académiques** | CNRS, Inria, Loria | Aucun |
| **Brevets** | Internationaux | Aucun sur le moteur |
| **Financement public** | 1 M€ levé | ~100 M€ (CDC, BEI, BPI, subventions) |
| **Destin** | Liquidée, rachetée 200 k€, technologie jetée | Rachetée 14 M€ par OVH en 2023 |
| **Résultat final** | 0 (détruite) | Toujours sans index propre en 2024 |

C'est un récit de destruction créative inversée : on a détruit le vrai pour protéger le faux.

---

## Partie III — Le lanceur d'alerte que personne n'a voulu entendre (2016–2025)

### 3.1. L'alerte interne (décembre 2016)

Stéphane Erard est développeur chez Qwant depuis mars 2015, classifié cadre position 2.2 (coefficient 130) de la convention Syntec, alors que ses responsabilités réelles correspondaient à une position 3.3. Il gère 48 projets GitLab, la chaîne CI/QA, et forme les équipes de développement. Il crée QWAPP, un outil complet d'environnement de développement. Même le CTO Jean-Charles Chemin ne sait pas redémarrer les services de base sans lui.

En août 2016, après une agression physique par le CTO et un contexte de harcèlement moral, Erard est placé en arrêt maladie pour dépression sévère (ALD 100 %). C'est dans cet état de vulnérabilité qu'il décide de lancer l'alerte.

En décembre 2016, il alerte en interne Victoire Yau, responsable juridique et conformité de Qwant. Il l'informe que Qwant transmet des données non anonymisées à Microsoft via Bing et que la dépendance à Bing est de 100 % sur les résultats web. L'alerte reste sans suite.

### 3.2. L'alerte publique et le licenciement (2017)

Face à l'inaction, et toujours en arrêt maladie, Erard publie en mars 2017 des tweets documentant la dépendance de Qwant à Bing et les problèmes de données personnelles. Qwant réagit par un avertissement signé Eric Léandri, puis le licencie en mai 2017 pour « dénigrement » et « manquement à l'obligation de loyauté ».

Le licenciement intervient exactement au moment où la CDC vient d'investir 15 millions d'euros. Le CTO Chemin envoie un SMS à Erard en mars 2017 confirmant que « les jeux étaient faits ». Deux mois plus tard, Erard est licencié.

### 3.3. Le harcèlement post-licenciement

Après le licenciement, Qwant orchestre une campagne de discrédit. Laurent Bourrelly, lié à Léandri, publie des propos injurieux contre Erard : « t'es un gros nul qui n'a jamais rien fait de sa vie », « toxique, minable et fainéant ». Le Tribunal judiciaire de Paris condamnera Bourrelly pour injure publique à 3 000 € de dommages-intérêts.

Qwant dépose également une citation directe en correctionnelle contre Erard, une procédure qualifiée de « procédure-bâillon » (SLAPP) visant à intimider un lanceur d'alerte.

### 3.4. La plainte CNIL et la validation (2019–2025)

En 2019, Erard porte plainte auprès de la CNIL contre Qwant pour transmission de données personnelles non anonymisées sans consentement. Parallèlement, il alerte l'État via Philippe Englebert, conseiller auprès de Cédric O, par messages privés puis officiellement. L'email interne d'Englebert à Côme Berbain (chargé de l'audit) porte la mention : « Il est important que Qwant ne soit pas au courant de ces échanges ».

Cinq ans plus tard, en février 2025, la CNIL rend sa décision (saisine n°19005268). Elle confirme l'intégralité des faits dénoncés et établit quatre manquements :

1. Qualification inexacte des données : les données transmises à Microsoft étaient pseudonymes, non anonymes.
2. Absence de mention de la finalité publicitaire dans la politique de confidentialité.
3. Absence de base légale pour le traitement publicitaire.
4. Incohérence entre les versions linguistiques de la politique de confidentialité.

### 3.5. Chronologie intégrale de l'alerte

| DATE | FAIT | SOURCE / PIÈCE |
|------|------|---|
| Mars 2015 | Embauche chez Qwant, position 2.2 Syntec (responsabilités réelles 3.3) | Contrat de travail |
| Août 2016 | Arrêt maladie après agression physique par le CTO Chemin | Certificat médical, ALD |
| Déc. 2016 | Alerte interne auprès de Victoire Yau (dépendance Bing + données) | Témoignage |
| Mars 2017 | Tweets publics documentant la dépendance à Bing | Captures d'écran |
| Mars 2017 | SMS de Chemin : « les jeux sont faits » (CDC investit) | Capture SMS |
| Mai 2017 | Licenciement pour « dénigrement » et « déloyauté » | Lettre de licenciement |
| 2018–2019 | Prud'hommes CPH Nice + CA Aix : débouté (Qwant ment dans ses conclusions) | Jugements |
| 2019 | Plainte CNIL (saisine n°19005268) | Accusé de réception |
| Juin 2019 | Alerte auprès de Philippe Englebert (cabinet Cédric O) | DM Twitter + email officiel |
| Juil. 2019 | Audit DINUM : Qwant utilise Bing à 75%+ | Rapport DINUM |
| 2020 | Rapport Eric Mathieu (83 pages) aux parlementaires | Document public |
| Fin 2019 | Olivier Sichel (DG CDC) ment devant la Commission de l'AN | Rapport CDC au Parlement |
| Fév. 2025 | CNIL confirme intégralement les faits dénoncés | Décision CNIL |

---

## Partie IV — Le contexte politique et financier

### 4.1. Près de 100 millions d'euros d'argent public

Le montant total de l'investissement public dans Qwant avoisine les 100 millions d'euros, en incluant l'investissement de la CDC (15 M€), le prêt de la Banque européenne d'investissement (25 M€), les subventions diverses et les marchés publics obtenus sans appel d'offres. En regard, le chiffre d'affaires de Qwant en 2019 n'était que de 7 millions d'euros.

La société Qwant avait 30 millions d'euros de cash en 2017 et était déjà en capitaux propres négatifs et en situation de faillite dès 2018, sans aucun achat de matériel significatif : où est passé l'argent ?

### 4.2. La galaxie des paradis fiscaux

Les enquêtes de La Lettre A révèlent l'existence d'une galaxie de sociétés gravitant autour de Qwant, parfois implantées dans des paradis fiscaux. Bad Boys SA, société luxembourgeoise portée par Alberto Chalon (actionnaire historique et ancien DG de Qwant), a été rebaptisée AVC Ventures fin 2019 au moment où les critiques fusaient, après avoir été détectée dans les Panama Papers. Deux autres membres du board apparaissent dans au moins 300 sociétés, dont beaucoup sont établies au Grand-Duché de Luxembourg.

### 4.3. Le mensonge d'Olivier Sichel devant l'Assemblée nationale

Fin 2019, Olivier Sichel, directeur général de la CDC, présente des « bons retours » sur Qwant devant la Commission de contrôle et de suivi de la Caisse des Dépôts à l'Assemblée nationale. Il omet de mentionner que Qwant envoie des données pseudo-anonymisées à Microsoft depuis 2016, et qu'il reste dépendant à 100 % de Bing. La CDC est sous le contrôle exclusif du Parlement : ce mensonge devant les représentants de la Nation constitue un fait d'une gravité exceptionnelle.

### 4.4. Le soutien politique aveugle

Le soutien politique à Qwant n'a jamais failli malgré les alertes convergentes : celles d'Erard dès 2016, celles de la presse dès 2013, celles de la DINUM en 2019, celles d'Eric Mathieu en 2020. Le secrétaire d'État Cédric O a imposé Qwant dans l'administration française sans appel d'offres ni certification de la version V2. Les ministres Axelle Lemaire et Emmanuel Macron (alors ministre de l'Économie) avaient déjà soutenu le déploiement de Qwant.

Cette protection politique a permis à Qwant de survivre malgré l'absence totale de technologie propre, d'assécher les financements des concurrents légitimes comme Xilopix, et de faire taire les lanceurs d'alerte.

---

## Partie V — Le bilan : 20 ans de R&D perdus

### 5.1. Ce qui a été détruit

La France disposait, avec Xilopix/Xaphir, d'un véritable moteur de recherche souverain : un index propriétaire, un robot d'indexation, des algorithmes de classement, des brevets internationaux, un partenariat avec le CNRS/Inria/Loria, et une équipe de 35 personnes représentant l'état de l'art en matière de recherche d'information multilingue.

Tout cela a été détruit par l'effet d'aspiration de l'investissement public dans Qwant. L'investissement de la CDC dans un projet sans technologie réelle a non seulement gaspillé l'argent public, mais a activement éliminé la seule alternative technologique crédible. Eric Mathieu avait refusé Alibaba pour préserver la souveraineté française ; c'est l'État français qui a détruit ce qu'Alibaba ne pouvait pas acheter.

### 5.2. Ce qui a été gaspillé

| POSTE | MONTANT / CHIFFRE | COMMENTAIRE |
|-------|-------------------|-------------|
| **Investissement CDC** | 15 M€ (2017) | Sur audit fraudé, valorisation 75 M€ |
| **Prêt BEI** | 25 M€ | Engagement précoce dans Qwant |
| **Subventions et marchés** | ~60 M€ cumulés | Marchés sans appel d'offres inclus |
| **Valeur de rachat (2023)** | 14 M€ | Destruction de 85% de la valorisation |
| **CA Qwant (2019)** | 7 M€ | Après 8 ans d'existence |
| **Rachat Xilopix** | 200 k€ | Entreprise estimée 10 M€ par Mathieu |
| **Employés Xilopix conservés** | 2 sur 35 | 94% de l'équipe éliminée |

### 5.3. Les 20 années perdues

En additionnant les années de R&D de Xilopix (2008–2017, soit 9 ans) et les années de promesses non tenues de Qwant (2011–2024, soit 13 ans), c'est bien près de deux décennies que la France a perdues dans la course aux moteurs de recherche. Les deux chronologies se chevauchent partiellement (2011–2017) mais représentent des trajectoires opposées : l'une construisait un vrai moteur pendant que l'autre faisait croire qu'elle en avait un.

Le résultat est sans appel. En 2026, la France ne dispose toujours pas de moteur de recherche souverain. La coentreprise Qwant-Ecosia annoncée fin 2024 n'est qu'un énième projet qui reste à construire. Pendant ce temps, les compétences accumulées par Xilopix ont été dispersées : les 35 personnes de l'équipe, dont les ingénieurs formés au Loria et à l'Inria, ont poursuivi leur carrière ailleurs, souvent à l'étranger.

### 5.4. Les responsabilités

Ce désastre résulte d'une chaîne de responsabilités :

- **La direction de Qwant** (Léandri, Chemin, Rozan) : fraude à l'audit, mensonges publics, destruction de la concurrence, harcèlement des lanceurs d'alerte.

- **La CDC et Olivier Sichel** : investissement sur audit fraudé, mensonge devant le Parlement, absence de contrôle effectif.

- **L'État** (Cédric O et les ministères successifs) : imposition de Qwant sans appel d'offres, refus de tirer les conséquences des audits, soutien politique aveugle malgré les alertes.

- **Cardiweb** : audit technique superficiel n'ayant pas détecté (ou n'ayant pas voulu détecter) la fraude.

---

## Conclusion

En février 2025, la CNIL a confirmé ce que Stéphane Erard dénonçait depuis décembre 2016 : Qwant transmettait des données personnelles pseudo-anonymisées à Microsoft, en violation de ses engagements envers le public, les utilisateurs et les investisseurs.

Cette validation intervient après huit années de déni, de harcèlement, de procédures-bâillon et de mensonges institutionnels. Pendant ces huit années, Qwant a non seulement gaspillé près de 100 millions d'euros d'argent public, mais a activement détruit la seule alternative technologique française crédible.

Ce document établit que la France avait les compétences pour construire un moteur de recherche souverain. La question n'est plus de savoir si ces 20 années de R&D ont été perdues — elles l'ont été. La question est de savoir si les responsables seront enfin appelés à rendre des comptes.

Comme l'affirme Eric Mathieu, fondateur de Xilopix : « Il n'existe pas de souveraineté numérique sans moteur de recherche. Le moteur de recherche, ce sont les yeux et les oreilles des gouvernants. »

---

## Annexe — Sources et pièces

### Sources publiques citées

- **Le Figaro**, 18 février 2013 : « Le moteur français Qwant surpris à utiliser Bing »
- **Le Point** : déclaration de Léandri sur l'achat d'inventaires Bing
- **La Lettre A**, 20 juillet 2020 : « Datas, procès et paradis fiscaux : le délicat droit d'inventaire de Qwant »
- **Next INpact** : révélations sur le rachat de Xilopix et la mise au rebut de la technologie
- **Next INpact** : « Six ans après son lancement, Qwant n'était qu'un prototype selon la DINUM »
- **Le Media**, mai 2019 : enquête révélant 64 % de résultats Bing
- **Mediapart** : témoignages d'anciens salariés sur le management Léandri
- **Le Canard Enchaîné / Next INpact** : « Le cahier de doléances des salariés de Qwant »
- **Le Journal des Entreprises** : interviews d'Eric Mathieu
- **Abondance** : analyse technique de Xaphir
- **Le Monde Informatique** : profils des fondateurs Xilopix
- **Tool Advisor** : rachat de Qwant par OVH à 14 M€
- **L'Usine Digitale** : coentreprise Qwant-Ecosia (novembre 2024)
- **Rapport CDC au Parlement** (30 juin 2020) : déclarations d'Olivier Sichel

### Pièces du dossier juridique Erard c/ Qwant

- Décision CNIL, février 2025 (saisine n°19005268)
- Emails internes Qwant : préparation de l'audit CDC/Cardiweb (juin 2016)
- Captures d'écran : SMS Chemin, DM Englebert, tweets Erard
- Rapport Eric Mathieu (83 pages) envoyé aux parlementaires (septembre 2020)
- Jugement TJ Paris : condamnation de Bourrelly pour injure publique
- Arrêt CA Aix-en-Provence : procédure prud'homale
- Analyse du code source : search_ads.php, webBrainLocales, branche demo
- Lettre d'avertissement et lettre de licenciement Qwant
- Attestation de droits : ALD 100 % depuis le 01/07/2018
- Témoignage Maxime Euzière : corroboration de la fraude à l'audit

### Note importante

Ce document constitue à la fois une pièce annexe au dossier juridique Erard c/ Qwant et un document de communication publique. Les faits présentés sont établis par des sources publiques, des décisions administratives (CNIL, DINUM) et des pièces de procédure.

---

## Faits clés

**CHIFFRE CLÉ :** Près de 100 millions d'€ d'argent public investis, pour un rachat à 14 M€ en 2023, toujours sans moteur propre

**PÉRIODE :** 2008–2026 : 18 ans de R&D française en moteurs de recherche, gelée ou détruite

**VALIDATION :** Février 2025 : la CNIL confirme intégralement les faits dénoncés par le lanceur d'alerte en 2016

---

[← Sommaire](00_SOMMAIRE.md) | [← SLAPP](07_SLAPP_REPRESAILLES.md) | [Forensique Git →](09_FORENSIQUE_GIT.md)

---

Document compilé par Stéphane Erard — Mars 2026 — Contact : stephane.erard@proton.me
