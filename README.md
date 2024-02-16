# Delea

Project of Decentralized Learning

## Architecture

![Architecture de Delea](Delea-graph.png)

## Description

### Création

1. Un user crée un modèle de Deep Learning compilé avec Wasm (Rust + Burn pour crée les modèles).
2. Une fois crée l'utilisateur déploie son modèle sur un Contrat prévu à cette effet.

### Contrat

1. Lorsque le contrat est crée, un nombre de token fix et ne pourra jamais être modifié.
2. Le createur reçoit 5% (valeur modifiable) de la pool et l'accès a la fonction RollBack
3. Le contrat expose 2 fonctions publiquement train et infere.
    1. Train: Entraine le model directement dans le browser (ou wasm runtime) et reçoit une récompense une fois le retour de l'environnement.
    2. Infere: Envoie des tokens au contrat en écheange le contrat lui permet d'utiliser le model.
4. Les 2 plus gros holder de token ont accès à la fonction RollBack,

Si il y a un conflit entre le créateur et les holders, les holders gagneronts

### Tokenomic

1. Aucune inflattion n'est possible le nombre de token crée est fixé à la création du contrat et ne pourra pu jamais être modifié.
2. Un fractionnement des tokens est cependant possible. (Fonctionnalité à discuter)
3. La distribution ce fera avec une fonction de façon a que les premiers long train du model recevront plus que les prochains

#### Fonction de distribution

1. $\int f(x) \, dx = R $ avec R ce qui reste de token dans le contrat
2. $\lim_{x \to +\infty} f(x) = 0$
