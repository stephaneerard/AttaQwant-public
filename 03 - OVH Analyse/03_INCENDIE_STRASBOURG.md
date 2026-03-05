# 03 – L'INCENDIE DU DATACENTER DE STRASBOURG

## 10 mars 2021 — SBG2

---

## Les faits

### Chronologie de la nuit
- **1h00** : Déclenchement de l'alarme incendie sur le site de Strasbourg (Port du Rhin)
- **~1h00-7h00** : Le feu se propage, alimenté par les batteries UPS et les structures en conteneurs du datacenter SBG2
- **7h00** : Le feu est contenu par les pompiers
- **Aucune victime** humaine

### Bilan matériel
- **SBG2** : **intégralement détruit** — 30 000 serveurs physiques réduits en cendres
- **SBG1** : partiellement endommagé (4 salles sur 12 détruites)
- **SBG3 et SBG4** : intacts mais coupés préventivement (alimentation électrique commune)

### Impact sur les clients
- **3,6 millions de sites web** affectés
- **~65 000 clients** touchés directement
- Services gouvernementaux français impactés (data.gouv.fr, Centre Pompidou, etc.)
- Des milliers d'entreprises en panne totale pendant des jours

---

## Les causes

### Investigations
Plusieurs enquêtes ont été menées :
- Enquête judiciaire
- Expertises techniques indépendantes

### Causes identifiées
Selon les investigations publiées :
- **Onduleurs (UPS)** : un onduleur récemment maintenu aurait pris feu
- **Structure en conteneurs** : SBG2, construit en 2016, utilisait des conteneurs maritimes empilés et modifiés — hautement inflammables
- **Absence de système d'extinction automatique** dans SBG2 (contrairement à SBG1 qui avait un système partiel)
- **Délai de coupure électrique** : il a fallu environ **1 heure pour couper le courant**, ce qui a alimenté l'incendie
- **Proximité des bâtiments** : SBG1 et SBG2 étaient très proches, facilitant la propagation

### Facteurs aggravants
- Architecture low-cost de SBG2 (conteneurs vs bâtiment traditionnel)
- Densification extrême des serveurs
- Absence de compartimentage feu adapté
- Certaines sauvegardes stockées **dans le même datacenter** que les données primaires

---

## Pertes de données

### Le problème des sauvegardes co-localisées
Le point le plus grave : OVHcloud proposait des options de sauvegarde, mais certaines de ces sauvegardes étaient physiquement stockées dans le même datacenter (SBG2) ou dans le datacenter adjacent (SBG1) — également endommagé.

Résultat : **des clients ayant souscrit l'option de sauvegarde ont quand même perdu définitivement toutes leurs données.**

### Ampleur
- Données définitivement perdues pour un nombre indéterminé de clients
- Aucune possibilité de récupération pour les serveurs physiquement détruits
- Impact particulièrement sévère pour les TPE/PME sans politique de sauvegarde externe

---

## Conséquences judiciaires

### Actions individuelles

| Date | Affaire | Montant | Issue |
|------|---------|---------|-------|
| 2022 | **Bati Courtage** vs OVH (Tribunal commerce Lille) | >100 000 € | **Condamné** en 1ère instance |
| Mars 2023 | **Bluepad** vs OVH | ~145 000 € | **Condamné** (2e condamnation) |
| Appel | Bati Courtage en appel (Cour d'appel de Douai) | 1 800,48 € | **Réduit drastiquement** en appel |

### Action collective
- **170 entreprises** regroupées dans un recours collectif
- Réclamation totale : **>9 millions d'euros**
- Un groupe du CAC 40 et trois sociétés ont engagé des actions individuelles séparées

### Problématique contractuelle
Les conditions générales d'OVH limitaient fortement la responsabilité de l'hébergeur. Les tribunaux ont dû trancher entre :
- Les clauses limitatives de responsabilité d'OVH
- L'obligation de moyens d'un hébergeur professionnel
- Le caractère « consommateur » ou « professionnel » des clients

---

## Impact sur l'IPO

### Le timing dramatique
- **8 mars 2021** : Annonce officielle de l'intention d'IPO
- **10 mars 2021** : Incendie de Strasbourg
- **Octobre 2021** : IPO finalement réalisée, 7 mois après

### Conséquences sur la valorisation
- La fourchette de prix initialement envisagée (~20-25 €) a été revue à la baisse
- Prix final fixé à **18,50 € par action** (bas de fourchette)
- Capitalisation à l'IPO : ~3,5 Mds€ au lieu des 4-5 Mds€ initialement espérés
- L'incendie a significativement entamé la confiance des investisseurs

---

## Frôlement d'un second incendie

Le **19 mars 2021**, soit 9 jours après le premier incendie, OVHcloud a frôlé un **second incendie** sur le même site de Strasbourg, obligeant l'entreprise à suspendre son plan de redémarrage des datacenters. Cet incident a renforcé les inquiétudes sur la sécurité du site.

---

## Mesures correctives annoncées

Après l'incendie, OVHcloud a annoncé :
- Construction de nouveaux datacenters aux normes renforcées
- Séparation physique systématique des sauvegardes
- Investissements dans les systèmes d'extinction automatique
- Révision de l'architecture des salles serveurs
- Abandon du modèle « conteneurs empilés »
