# Liber
Liber permet de bloquer des applications, d’analyser les habitudes d’utilisation et de les présenter sous forme de statistiques afin de sensibiliser l’utilisateur aux améliorations nécessaires pour mieux gérer son temps d’écran.

## Table des matières
1. [**Description du projet**](#description-du-projet)
    - [L’idée](#lidée)
    - [L’utilité](#lutilité)
    - [L’innovation](#linnovation)
    - [Cas d’utilisation](#cas-dutilisation)
    - [Public cible](#public-cible)
    - [Liens avec les autres matières](#liens-avec-les-autres-matières)
3. [**Technologies utilisées**](#technologies-utilisées)
   - [Outils et environnements](#outils-et-environnements)
   - [Justification des choix](#justification-des-choix)
   - [Défis et difficultés](#défis-et-difficultés)
5. [**Conception de l’application**](#conception-de-lapplication)
   - [Analyse du projet](#analyse-du-projet)
   - [Modélisation UML](#modélisation-uml)
   - [Vues](#vues)
7. [**Auteurs**](#auteurs)

## Description du projet
### L’idée 
- La problématique à laquelle nous cherchons à apporter une solution est celle de la surutilisation des écrans de façon récréative.
- L’objectif du projet est de donner aux utilisateurs, voulant se sortir de ses mauvaises habitudes, un outil de régulation puissant et facile d’accès tout en leur offrant des statistiques leur permettant de pleinement prendre conscience du réel temps qu’ils consacrent aux écrans.
### L’utilité 
- Liber est une application qui permet à l’utilisateur d’améliorer son temps d’écran. Pour ce faire elle permet de bloquer des applications et offre des statistiques poussées qui permettent de mieux comprendre le comportement de l’utilisateur.
- S’imposer à soi-même une limite de temps d’écran est une tâche qui demande beaucoup d’assiduité. L’application liber est un outil permettant aux utilisateurs de faciliter et d’automatiser la gestion de leur propre temps d’écran.
### L’innovation 
- Comparé aux applications similaires existantes sur le marché, Liber innove de manières principales. Premièrement, l’accessibilité aux statistiques. L’utilisateur a accès à ses statistiques d’utilisation ainsi qu’a ses habitudes avec celles de l’utilisateur moyen. Ces données sont également utilisées afin de faire des prédictions statistiques sur les habitudes de l’utilisateur. Deuxièmement, Liber offre des options de blocages plus personnalisés que celles disponibles sur le marché actuel. Une application peut être bloqué selon son temps d’utilisation, selon des horaires préétablis ou selon un certain nombre d’ouvertures par jour (exemples 3 ouverture d’une durée de 15 minutes chaque).
- Ces innovations permettent à l’utilisateur de mieux comprendre son utilisation ainsi que lui offrir des moyens très diversifies pour pouvoir s’améliorer plus facilement.
### Cas d’utilisation 
- Il y a deux auteurs : l’utilisateur et l’administrateur.
- L’utilisateur peut se définir des limites et peut aussi voir ses statistiques personnelles pour les comparer aux autres utilisateurs.
- L’administrateur peut consulter les statistiques globales et configurer des paramètres globaux.

<img height="300" alt="image" src="https://github.com/user-attachments/assets/9dd5b440-680e-444b-92c7-8ddd767e2364" />

### Public cible 
- Notre application cible tous les utilisateurs d’iPhone qui souhaitent réduire leurs de temps d’écran.
### Liens avec les autres matières 
- Nous allons évidemment utiliser l’informatique pour construire l’application avec de multiples langages de code tel que Swift et Python.
- Notre application utilise grandement les statistiques afin de classifier les utilisateurs selon leurs habitudes d’utilisation des écrans, en les situant sur une courbe de distribution normale. Elle leur permet également de se comparer à leurs propres habitudes d’utilisation afin de s’améliorer par rapport à leur propres moyennes d’usage.

## Technologies utilisées
### Outils et environnements 
- Langages: Swift, SwiftUI, Python, FastAPI
- XCode, VSCode
- GitHub, Git, MongoDB, Figma, Discord, Render
### Justification des choix 
- Python et FastAPI sont des moyens simples pour créer serveur Backend tout étant flexible en cas de problème. 
- MongoDB et Render ont été choisi pour être hôte de la base de données et du serveur Backend car il s’agit d’option gratuite, simple et flexible. 
- XCode et Swift sont nécessaires pour accéder à l’API de temps d’écran de l’iPhone donc nous étions obliges de choisir ces derniers.
### Défis et difficultés 
- Nous devons appendre à programmer en Swift et en Python. Nous devons aussi trouver comment gérer la communication entre l’application et le serveur backend.
- Les contraintes techniques sont: l’accès aux données des utilisateurs avec Apple Developer et l’exclusivité de XCode (il faut avoir être sur MacOs)

## Conception de l’application
### Analyse du projet 
- Un des enjeux principaux est que nous voulons faire une application iOS. Nous devons donc nécessairement utiliser un Mac pour développer l’application mobile. Pour résoudre ce problème, Maxime et Valeriy vont coder l’application avec leurs ordinateurs Mac pendant que Tan et Henrik s’occupe de l’autre partie du projet comme le serveur Backend. 
### Modélisation UML
<img height="300" alt="image" src="https://github.com/user-attachments/assets/6630b30c-edbb-4d92-84f6-7a4a653181dd" />
<img height="300" alt="image" src="https://github.com/user-attachments/assets/719ccdf4-6ebc-43b5-83ea-8878d458b7db" />
<img height="300" alt="image" src="https://github.com/user-attachments/assets/307ef7fd-4cbc-4cb4-a7a3-6a7d609740ba" />

### Vues
<img height="425" alt="image" src="https://github.com/user-attachments/assets/d693eabc-1775-4abe-8d63-fb2868a8eb89" />
<img height="425" alt="image" src="https://github.com/user-attachments/assets/3eda062b-efb7-401e-96e3-16405b97b01e" />
<img height="425" alt="image" src="https://github.com/user-attachments/assets/529fd8fe-fd96-4457-8714-e3c26ce0c4b0" />
<img height="425" alt="image" src="https://github.com/user-attachments/assets/cfc9ded5-6275-469e-bb4a-b6241c936d64" />

## Auteurs
- **Maxime Bier** (@MaxLoveMoute) : Application mobile iOS
- **Henrik Hughes** (@Blygart) : Serveur Backend
- **Tan Thanh Nguyen** (@jonathannguyen580-pixel) : Serveur Backend
- **Valeriy Yauseichyk** (@RealMysticalAce) : Application mobile iOS

Projet d'Intégration en Sciences, Informatique et Mathématique, 420-SF4-RE, Gr.02, Collège de Bois-de-Boulogne
