On peut utiliser le convulotionelle pour tout signal spacio-temporelle : où il y a correlation entre les coordonées proches.

Pour réduire le biais causé par 2 fonctions du mm nom mais pas les memes, on peu modifier la loss pour ne pas trop punir si elle se trompe trop (par exemple dans le cas d'un nouveau wrapper).

Il existe des "autoencodeurs" qui peivent supprimer les cables d'une images, mettre un paysage en.hiver, un visage en caricature.


Attention, plus ta données est transformée, plus tu introduit des bais, c'est pourquoi l'expert regarde la chaine complete de la transformation de la donnèe.

Il y a tellement de dimensions que dans la descente de gradient, on a du mal arester attraper dans un optimum local bien lontemps : on trouve tpujours un chemin.
Il existe pleins d'extremum globaux. On reste a la fin dans un local mais c pas grave car il est satisfesant.

Bien pense a normalisé : autoir de la moyenne, divise par std et en log. Pour éviter que les grosses valeurs eclipsent les petites. Genre 10^9 dans une descte de gradient vaut + que 0.1

Lorsqu'on met bout a bout les couches, on a besoin de moi s de neurones, on va plus vite au résultat. Bien qu'en théorie une seule couche soit nécessaire pour un perceptron.

Plus c complexe, plus il faut de couches. Entre 3 et 6 c'est bien.

Conv / Mlp / Lstm (== Rnn) are feed foward NN



Optimizer, change le learning rate en dinamque : ADAM, GSD. Y'en a un qui utimise un momentum, apres 2, 3 chute, on continue de tomber dans cette direction.


# Difficultes

1. Classification
2. Prédiction : classification continue
3. Similarité : distance entre objets
4. Génération

### Transfert learning

Utiliser un réseau déjà entrainer pour effextier une autre tache.

### Early stopping

Pour lutter contre le sur apprentissage.
Sinon augmenter le nb de données d'appre tissage ou réduire la taille du modèle.

### Règles expertes
arbre de décision d'expert

### PushButton
Reseau de neirone automatiquement generé

### Random Forest
Choisir aléatoirement un batch (1%) des vecteurs d'entrés. Et ne s'interesse qu'à un sous ensemble des coordonnées. Il crée ensuite l'arbre de decision minimal qui permet de discriminer au mieux ces vecteurs. C'est comme si il crée des arbres de décision experts en chaque coordonées puis il prend la majorités des votes. Utilise `Scikit learn`. L'avantage est qu'on peut remonter à l'origine des décisipns facilement.
Chaque arbre prend un echantimlon différent.
A chaque branche de l'arbre, on ne discrimine qu'une coordonée, genre `x0 < 0.3`


### K-means

### Hot encoding

C'est pour encoder une valeur de maniere discrete. En mettant chaque possibilite comme une dimension de vecteur. Comme l'output de la reconnaissance de charactère.

### SoftMax

Permet de donner une sortie en probabilite dans des categories discrétes.
Pour l'erreur sur la fin, on utilise la cross entropy.

### Cross Validation

S'entrainer sur 90% et Vamider sur 10% mais faire 10 fois l'experience en.faisant varier les 10%, pour au final qu'ils aient couvert tout le set. Voir changer la seed du random select et refaire tout ça. Du genre faire 30 expériences pour un test. Attentions aux papiers qui affichent le meilleur resultat. C'est la moyenne qui compte.

### Matrice de cofusion

M(x, y) est le nombre d'élément de catégorie x classés y par le système.

#### Precision

Nombre de bonne classification de chaque classe / nb d'element classé dans cette classe (inclue les mauvais)

#### Rappel

Nombre de bonne classification de chaque classe / nb d'element dans cette classe

#### F1 score

Moyenne geometrique Rappel et Precision : 2p.r / (p + r)

## Stats

* Regarder le nb d'object pour chaque label
	* C'est parfois normal, par exemple pour chercher un evenement rare : une tumeur dans une image médicale


# Todo

* Exporter au format numpy (pour faciliter de load)
* Numpy sous forme binaire pour mmap rapide
* Prendre les exemples du cour pour les collegues.

* Faire des stats
	* Voir les outsiders
	* Faire un histogram

* Regarder
	* KNeighborsClassifier
	* LinearDiscriminantAnalysis

* Preparer un Golden Standard, ce qui est comme un test de non regression pour l'IA.
	
# Numpy / Plt / Scikit learn

* plt.bar(array)
* plt.boxplot(array_x, array_y)
