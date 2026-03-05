# L'affaire Qwant, c'est quoi ?

**Pendant douze ans, la France a investi des centaines de millions d'euros d'argent public dans Qwant, un « moteur de recherche souverain » qui n'en était pas un.** Qwant n'a jamais eu de technologie propre : 100 % de ses résultats provenaient de l'API Bing de Microsoft. Le « moteur souverain français » était, dans les faits, une interface graphique posée sur les serveurs d'une multinationale américaine.

Pire : pendant que l'État français finançait ce simulacre, il laissait mourir **Xilopix**, une entreprise d'Épinal qui avait développé pendant huit ans un vrai moteur de recherche souverain — avec 38 ingénieurs, 8 docteurs, 7 laboratoires publics partenaires (CNRS, INRIA, CEA-LIST) et 10 millions d'euros investis. Xilopix a été rachetée pour 180 000 euros — 1,8 % de l'investissement réel — puis immédiatement liquidée.

---

## Ce que ce dossier documente

### Une fraude technique à l'audit

En juin 2016, la Caisse des Dépôts s'apprête à investir 15 millions d'euros dans Qwant. Un audit technique est commandé à Cardiweb. **La veille de l'audit, un développeur crée une branche « demo » dans le code source pour masquer tous les appels à l'API Bing.** Le code de remplacement est qualifié de « fake » par son propre auteur dans un email interne. L'audit est passé, l'investissement validé — sur la base d'un code falsifié. Les preuves sont dans l'historique git, commit par commit.

### Une violation massive de la vie privée

Qwant promettait de « respecter votre vie privée ». En réalité, chaque recherche effectuée par un utilisateur était transmise à Microsoft avec des données d'identification — adresse IP non tronquée, identifiant unique, user-agent. **Les données n'étaient pas anonymisées, contrairement à ce que Qwant déclarait publiquement.** La CNIL l'a officiellement confirmé en février 2025, après six ans d'instruction — mais sans prononcer de sanction, les faits étant prescrits.

### Des représailles contre le lanceur d'alerte

Stéphane Erard, ingénieur chez Qwant, a alerté en interne dès 2016 sur la dépendance à Bing et la transmission de données personnelles. Il a été licencié. Quand il a rendu l'affaire publique, Qwant l'a poursuivi en citation directe pour diffamation — une procédure SLAPP (Strategic Lawsuit Against Public Participation) classique visant à réduire au silence un lanceur d'alerte par l'épuisement juridique et financier.

### La destruction d'une vraie technologie souveraine

L'affaire Qwant n'est pas qu'un gaspillage d'argent public : c'est aussi la destruction délibérée d'une alternative réelle. Xilopix/Xaphir avait développé un moteur de recherche avec des résultats parfois supérieurs à Google sur certaines requêtes. Sa destruction s'est opérée en quatre phases : assèchement des financements par la BPI, audit frauduleux par la CDC au profit de Qwant, investissement massif dans le simulacre, rachat et liquidation de la technologie réelle.

### Des centaines de millions d'euros publics sans contrôle

Entre la Caisse des Dépôts, la BPI, les aides publiques directes et les marchés imposés par décret dans les administrations et les écoles, Qwant a absorbé des centaines de millions d'euros de fonds publics. Les comptes annuels montrent un gouffre : en 2017, 17 millions d'euros de pertes pour 2,9 millions de chiffre d'affaires, et 24 millions de dette. À aucun moment les organes de contrôle n'ont exercé leur mission.

---

## Les preuves convergent

Ce dossier ne repose pas sur des allégations : il croise cinq sources de preuves indépendantes qui convergent toutes vers les mêmes conclusions.

**L'historique git** du code source de Qwant montre la branche « demo » créée pour falsifier l'audit, la variable `webBrainLocales` initialisée à vide (100 % des requêtes vers Bing), et les 125 releases contaminées par le code falsifié.

**La décision CNIL de février 2025** confirme que les données transmises à Microsoft étaient pseudonymisées et non anonymisées — validant huit ans après les alertes de Stéphane Erard.

**Les aveux de Guillaume Champeau**, ancien Directeur Éthique et Juridique de Qwant, dans une conversation privée en janvier 2022, confirment la dépendance à Bing et les problèmes de données.

**Le rapport d'Éric Mathieu** (fondateur de Xilopix), 87 pages rédigées en septembre 2020, documente la destruction délibérée de sa société depuis l'extérieur — et corrobore point par point le témoignage interne d'Erard.

**L'audit DINUM de 2019**, réalisé par une équipe interministérielle (DINSIC, ANSSI, ENS), a confirmé les défaillances techniques de Qwant — mais ses conclusions n'ont eu aucune conséquence.

---

## Ce dossier, en 12 documents

La publication est organisée en trois niveaux de lecture progressifs :

**Pour comprendre** (grand public) — La synthèse du dossier, la chronologie complète de 2008 à 2026, et la tribune du lanceur d'alerte.

**Pour approfondir** (experts, juristes, institutions) — L'audit CDC fraudé de 2016, la décision CNIL, les accusations de Qwant confrontées aux preuves, les procédures SLAPP, et la destruction de Xilopix.

**Pour vérifier** (techniciens, chercheurs) — L'analyse forensique git, l'audit DINUM 2019, l'analyse financière 2013-2022, et la synthèse croisée de l'ensemble des preuves.

---

*Dossier compilé par **Stéphane Erard** — Mars 2026*
