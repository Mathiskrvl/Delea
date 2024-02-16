# Delea

Project of Decentralized Learning

## Abstract

## Architecture

![Architecture de Delea](Delea-graph.png)

## Description

### Création

1. Un utilisateur crée un modèle de Deep Learning compilé avec Wasm (Rust + Burn pour créer les modèles).
2. Une fois créé, l'utilisateur déploie son modèle sur un Smart Contrat prévu à cet effet.

### Smart Contrat

1. Lorsque le contrat est créé, un nombre de token est fixé et ne pourra jamais être modifié.
2. Le créateur reçoit 5% de la pool et l'accès à la fonction RollBack
3. Le contrat expose 2 fonctions publiquement train et infere.
    1. Train: Entraine le modèle directement dans le browser (ou wasm runtime) et reçoit une récompense une fois le retour de l'environnement.
    2. Infere: Envoie des tokens au contrat en échange, le contrat lui permet d'utiliser le modèle.
4. Les 2 plus gros holders de token ont accès à la fonction RollBack

Si il y a un conflit entre le créateur et les holders, les holders gagneronts.

### Tokenomic

1. Aucune inflation n'est possible car le nombre de token créé est fixé à la création du contrat et ne pourra plus jamais être modifié.
2. Un fractionnement des tokens est cependant possible. (Fonctionnalité à discuter)
3. La distribution ce fera avec une fonction qui permmettra aux premiers long train du modèle recevront plus que les prochains.

#### Fonction de distribution

##### Propriétés :

1. $\int_{x>0}^{+\infty} f(x) \, dx = R,\quad\text{avec } R \text{ ce qui reste de token dans le contrat }$
2. $\lim_{x \to +\infty} f(x) = 0$
3. $\forall x_1, x_2,\quad x_1 < x_2 \implies f(x_1) > f(x_2)$

##### Solution :

$f(x) = R\cdot u\cdot\alpha\cdot\exp(-u \cdot \alpha \cdot x),\ \forall u, \alpha > 0\text{ avec }\alpha\text{ le facteur de rapidité, }u \text{ le facteur d'update et }x\text{ le nombre d'uptade effectuer}$

#### Token

1. Les tokens sont transferable
2. Lorsqu'on utilise le modèle, nous transferons des tokens vers le contrat, le prix est fixé par la fonction de distribution. 
3. Les tokens sont divisables

### Framework Burn [![Burn repo](https://img.shields.io/badge/Burn-%20repo-green)](https://github.com/tracel-ai/burn)

- Burn est une librairie Rust, qui permet de créer et utiliser des modèles de Deep Learning avec plusieur Backend possible, dont WebGPU
- Burn permet d'importer tout type de modèle (ONNX, safetensor, PytorchTensor)
- Burn est encore en pleine évolution, des nouvelles features comme la quantization sont sur la roadmap 2024
