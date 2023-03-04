# Cahier des charges du projet
Virginie Van den Schrieck, J. Noël | 9 février 2023 | convertis en markdown
## 1. Description de l’entreprise et du projet
Le client est l’entreprise WoodyToys (WT), qui fabrique de manière artisanale des jouets en bois. Elle travaille en B2B, c’est-à-dire qu’elle ne s’occupe pas de la vente directe de ses produits, mais les fournit à des revendeurs (magasins de jouets). L’entreprise possède une infrastructure informatique pour le support de la production et des services comptables et commerciaux. Cette infrastructure fournit actuellement principalement un service Web, et utilise un service extérieur pour le service Mail. L’entreprise souhaite remplacer ses serveurs utilisant des technologies dépassées, et fait appel à vous pour la phase de conception, de validation et de sécurisation d’une nouvelle infrastructure d’hébergement des services informatiques. Elle souhaite une infrastructure basée sur des containers, afin de pouvoir héberger celle-ci dans le cloud et permettre une migration facile en cas de changement de fournisseur. Par ailleurs, la direction de l’entreprise, en concertation avec ses employés, s’est engagée dans une démarche de transition et a instauré le développement durable comme valeur forte. Elle souhaite donc que votre réalisation soit en phase avec cette orientation, notamment par l’intégration de critères "Développement Durable" dans les analyses et les choix effectués.

## 1.1. Structure de l’entreprise
L’usine comporte un atelier où sont fabriqués les jouets, un hangar de stockage d’où partent les produits vers les revendeurs, le bureau du directeur et les bureaux où travaillent les employés. Parmi ceux-ci, il y a des comptables, des commerciaux et une secrétaire. L’usine dispose d’une connexion à Internet. L’atelier, le hangar et le bureau sont reliés via une infrastructure IP. Un réseau Wifi permet aux employés d’utiliser des appareils portables (laptops et smartphones). Le plan ci-dessous représente schématiquement l’organisation des bureaux de l’entreprise.

![](https://cdn.discordapp.com/attachments/1081507557023170620/1081507641953624125/image.png)

## 2. Objectif client
Avant de se lancer dans une migration de grande ampleur, l’entreprise
souhaite évaluer la faisabilité de ce projet en faisant développer un prototype
des configurations des services dont elle a besoin.

## 3. Intervenants
L’entreprise WoodyToys sera représentée par Mr Cooper, qui est l’in-
formaticien en charge de l’infrastructure informatique. Le prestataire est
le département TI de la haute école EPHEC, représenté par M. Van den
Schrieck et M. Noël. Il est convenu que la tâche de prototypage sera confiée
aux étudiants de 2ème bachelier dans le cadre d’un de leurs projet.

## 4. Public cible et utilisateurs
Le prototype simulera une infrastructure qui sera exploitée par plusieurs
types d’utilisateurs :
- Les employés de l’entreprise, utilisateurs des services internes
- Les clients de l’entreprise, via le site web public
- Les revendeurs des produits de l’entreprise (clients B2B)
En ce qui concerne le prototype, il est destiné à deux personnes en par-
ticulier :
- Mr Delfosse, CEO de l’entreprise, qui doit valider l’adéquation des
services sur base du prototype du point de vue fonctionnel
- Mr Cooper, présenté plus haut, qui, en cas de validation d’un proto-
type, sera chargé de la mise en oeuvre des configurations produites
sur base de la documentation produite par les prestataire de l'Ephec.

## 5. Planification et organisation
Les intervenants se sont accordés sur la date du 30 juin pour la présenta-
tion des prototypes les plus convainquants à l’entreprise. Cette présentation
sera réalisée par M. Van den Schrieck et M. Noël, qui auront au préalable
évalué l’ensemble des prototypes produits par les étudiants et sélectionné
ceux qui répondent au cahier des charges.

## 6. Demandes fonctionnelles
### 6.1. Hébergement distant
L’entreprise souhaite une délocalisation de ses services dans le Cloud.
Vous devez donc proposer une solution d’hébergement qui conviennent au
besoin, en explorant et comparant les possibilités. La mise en oeuvre des
services conteneurisés sur l’hébergement choisi est incluse dans le prototype
attendu. Une réflexion doit être initiée concernant les accès aux services in-
ternes dans le cas où ceux-ci sont hébergés à distance (adressage, sécurisation
des accès via VPN, ...).
### 6.2. Services internes
Les postes des employés doivent pouvoir accéder à Internet et également
aux services internes et externes, via un adressage IP adéquat. L’entreprise
souhaite ne pas dépendre de fournisseurs de services extérieurs pour la réso-
lution de noms. Un contrôle du trafic web généré par les employés pourrait
s’avérer intéressant.
Au niveau du prototype, Mr Cooper souhaite que vous modélisiez quelques
postes clients sous forme de container fournissant des outils (explorateur,
client mail, ...) en ligne de commandes, afin de valider les fonctionnalités que
vous aurez configurées.
#### 6.2.1. Web
La vente des produits s’effectue uniquement en B2B (revendeurs). L’en-
treprise dispose d’un portail Web public présentant ses produits (www.woodytoys.be),
d’un site de vente en ligne réservé aux revendeurs (b2b.woodytoys.be), et
d’un site de gestion interne (ERP). Le code source de ces trois sites est pré-
existant, il s’agit d’un site statique en HTML/CSS pour le site vitrine, et de
sites dynamiques en PHP/MySQL pour le site b2b et l’intranet. Ces deux
derniers sont alimentés par une base de données commune. Pour le proto-
type, le client déclare pouvoir se contenter d’un proof of concept composé de
pages web très simples utilisant les technologies sus-mentionnées. L’objectif
est de tester l’accès à la DB et les contrôles d’accès aux sites web.
#### 6.2.2. Mail
L’entreprise souhaite fournir une adresse mail à chacun de ses employés,
au format nom.prenom@woodytoys.be. Elle dispose également d’adresses
mail génériques, dont actuellement :
- contact@woodytoys.be, redirigée chez la secrétaire
- b2b@woodytoys.be, redirigée sur les commerciaux
Les employés doivent pouvoir consulter leur courrier électronique et en
envoyer à l’aide d’un client mail classique (lourd) (pas de webmail) de-
puis les postes de l’entreprise. Ils doivent également être en mesure d’utiliser
leur mail en déplacement ou à domicile.
### 6.3. Fonctionnalités supplémentaires
Si le temps disponible le permet, le client souhaite également explorer
différentes possibilités, et si possible les implémenter dans le prototype :
- La possibilité de déployer automatiquement l’entièreté de l’infrastruc-
ture (containers et hôtes éventuels) sur base de fichiers de configura-
tion (par ex. avec l’outil Ansible)
- Un système de gestion de fichiers partagés, fournissant des répertoires
personnels et des répertoires partagés accessibles depuis l’explorateur
de fichiers natif des postes clients.
- un système d’annuaire type LDAP
- Un service de téléphonie sur IP
- un système centralisé de monitoring de l’infrastructure.