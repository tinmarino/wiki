---
description: |
    Il est possible de construire une expression rationnelle de deux façons
    :
title: 'Expressions rationnelles - JavaScript | MDN'
---


Expressions rationnelles
========================


Les expressions rationnelles sont des motifs utilisés pour correspondre
à certaines combinaisons de caractères au sein de chaînes de caractères.
En JavaScript, les expressions rationnelles sont également des objets.
Ces motifs sont utilisés avec les méthodes
[`exec`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp/exec "La méthode exec() exécute la recherche d'une correspondance sur une chaîne de caractères donnée. Elle renvoie un tableau contenant les résultats ou null.")
et
[`test`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp/test "La méthode test() vérifie s'il y a une correspondance entre un texte et une expression rationnelle. Elle retourne true en cas de succès et false dans le cas contraire.")
de
[`RegExp`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp "Le constructeur RegExp crée un objet expression rationnelle pour la reconnaissance d'un modèle dans un texte."),
et avec les méthodes
[`match`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/match "La méthode match() permet d'obtenir le tableau des correspondances entre la chaîne courante et une expression rationnelle."),
[`replace`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/replace "La méthode replace() renvoie une nouvelle chaîne de caractères dans laquelle tout ou partie des correspondances à un modèle sont remplacées par un remplacement. Le modèle utilisé peut être une RegExp et le remplacement peut être une chaîne ou une fonction à appeler pour chaque correspondance."),
[`search`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/search "La méthode search() éxecute une recherche dans une chaine de caractères grâce à une expression rationnelle appliquée sur la chaîne courante.")
et
[`split`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/split "La méthode split() permet de diviser une chaîne de caractères à partir d'un séparateur pour fournir un tableau de sous-chaînes.")
de
[`String`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String "L'objet global String est un constructeur de chaînes de caractères.").
Ce chapitre explique comment utiliser les expressions rationnelles en
JavaScript (aussi appelées expressions régulières ou « *RegExp* »).

Créer une expression rationnelle {#Créer_une_expression_rationnelle}
--------------------------------

Il est possible de construire une expression rationnelle de deux façons
:

-   Utiliser un littéral d'expression régulière, qui correspond à un
    motif contenu entre deux barres obliques, par exemple :

    ``` {.brush: .js}
    var re = /ab+c/;
    ```

    Lorsque les littéraux d'expression régulière sont utilisés,
    l'expression est compilée lors du chargement du script. Il est
    préférable d'utiliser cette méthode lorsque l'expression régulière
    reste constante, afin d'avoir de meilleurs performances.

-   Appeler le constructeur de l'objet
    [`RegExp`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp "Le constructeur RegExp crée un objet expression rationnelle pour la reconnaissance d'un modèle dans un texte."),
    par exemple :

    ``` {.brush: .js}
    var re = new RegExp("ab+c");
    ```

    Avec cette méthode, l'expression rationnelle est compilée lors de
    l'exécution. On utilisera cette méthode lorsque le motif utilisé est
    variable ou provient d'une autre source (par exemple une interaction
    utilisateur).

Écrire une expression rationnelle {#Écrire_une_expression_rationnelle}
---------------------------------

Le motif d'une expression rationnelle est composé de caractères simples
(comme `/abc/`), ou de caractères simples et spéciaux, comme `/ab*c/` ou
`/Chapitre (\d+)\.\d*/ `. Le dernier exemple utilise des parenthèses qui
permettent d'avoir une « mémoire ». La correspondance avec le motif
contenu entre parenthèses pourra être utilisée par la suite. Ceci est
décrit avec [ce paragraphe](#parentheses).

### Utiliser des motifs simples {#Utiliser_des_motifs_simples}

Les motifs simples sont construits à partir de caractères pour lesquels
on souhaite avoir une correspondance directe. Le motif `/des/`
correspond lorsqu'on observe exactement les caractères 'des' ensemble et
dans cet ordre précis. On pourrait utiliser ce motif et détecter une
correspondance dans les chaînes suivantes : "J'ai vu des licornes ?" et
"Sa description de licorne était superbe" car la chaîne de caractères
'des' y est présente (dans le mot description pour le second exemple).
Il n'y aura pas de correspondance avec la chaîne de caractères "Toc toc"
car 'des' n'est pas présente.

### Utiliser des caractères spéciaux {#Utiliser_des_caractères_spéciaux}

Lorsque le motif à trouver est plus complexe qu'une simple égalité
(trouver tous les B, les blancs...), le motif devra contenir des
caractères spéciaux. Ainsi, le motif `/ab*c/` correspond à toutes les
combinaisons de caractères qui possèdent un seul 'a' suivi de zéro ou
plusieurs 'b' (l'astérisque utilisée ici signifie que l'élément qui la
précède doit être présent zéro ou plusieurs fois) qui sont immédiatement
suivis d'un 'c'. Par exemple, la chaîne de caractère "cbbabbbbcdebc"
correspond au motif avec la chaîne de caractères 'abbbbc'.

La tableau qui suit fournit une liste complète des caractères spéciaux
pouvant être utilisés dans les expressions régulières ainsi que leur
signification.

+-----------------------------------+-----------------------------------+
| Caractère                         | Signification                     |
+===================================+===================================+
| [`\`](#special-backslash){#specia | Correspond selon les règles       |
| l-backslash}                      | suivantes :\                      |
|                                   | \                                 |
|                                   | Une barre oblique inversée        |
|                                   | (*backslash*) précédant un        |
|                                   | caractère non spécial indique que |
|                                   | le caractère qui suit est spécial |
|                                   | et qu'il ne doit pas être         |
|                                   | interprété directement. Ainsi, un |
|                                   | '`b`', sans '\\' avant,           |
|                                   | correspondra pour les 'b'         |
|                                   | minuscules quel que soit leur     |
|                                   | position. En revanche '`\b`' ne   |
|                                   | correspondra à aucun caractère    |
|                                   | mais indique [un caractère de fin |
|                                   | de mot](#special-word-boundary).\ |
|                                   | \                                 |
|                                   | Un *backslash* précédant un       |
|                                   | caractère spécial indique que le  |
|                                   | caractère qui suit doit être      |
|                                   | interprété littéralement (et non  |
|                                   | pas comme un caractère spécial).  |
|                                   | Ainsi, le motif `/a*/` utilise le |
|                                   | caractère spécial '`*`' pour      |
|                                   | correspondre à 0 ou plusieurs     |
|                                   | 'a'. Le motif `/a\*/`, au         |
|                                   | contraire, rend '`*`' non-spécial |
|                                   | pour correspondre aux chaînes de  |
|                                   | caractères qui comportent la      |
|                                   | lettre a et une astérisque, comme |
|                                   | 'a\*'.\                           |
|                                   | \                                 |
|                                   | Il ne faut pas oublier d'échapper |
|                                   | le caractère '\\' car lui-même    |
|                                   | est un caractère d'échappement    |
|                                   | dans les chaînes de caractères.   |
|                                   | Cela est utile lorsqu'on utilise  |
|                                   | la notation RegExp("motif").      |
+-----------------------------------+-----------------------------------+
| [`^`](#special-caret){#special-ca | Correspond au début la séquence.  |
| ret}                              | Si le marqueur (*flag*) de lignes |
|                                   | multiples vaut `true`, il         |
|                                   | correspondra également            |
|                                   | immédiatement après un caractère  |
|                                   | de saut de ligne.\                |
|                                   | \                                 |
|                                   | Ainsi, `/^A/` ne correspond pas   |
|                                   | au 'A' de "un A", mais correspond |
|                                   | au 'A' de "Arceau".\              |
|                                   | \                                 |
|                                   | Le caractère '`^`' possède un     |
|                                   | sens différent lorsqu'il est      |
|                                   | utilisé dans un motif d'ensemble  |
|                                   | de caractères. Voir les           |
|                                   | [compléments sur les ensembles de |
|                                   | caractères](#special-negated-char |
|                                   | acter-set)pour                    |
|                                   | plus de détails et d'exemples.    |
+-----------------------------------+-----------------------------------+
| [`$`](#special-dollar){#special-d | Correspond à la fin de la         |
| ollar}                            | séquence. Si le marqueur (*flag*) |
|                                   | de lignes multiples vaut true, il |
|                                   | correspondra également            |
|                                   | immédiatement avant un caractère  |
|                                   | de saut de ligne.                 |
|                                   |                                   |
|                                   | Ainsi, `/t$/` ne correspond pas   |
|                                   | au 't' de "printemps", mais       |
|                                   | correspond au 't' de "aliment".   |
+-----------------------------------+-----------------------------------+
| [`*`](#special-asterisk){#special | Correspond à l'expression         |
| -asterisk}                        | précédente qui est répétée 0 ou   |
|                                   | plusieurs fois.                   |
|                                   |                                   |
|                                   | Ainsi, `/bo*/` correspond à 'boo' |
|                                   | dans "Un booléen" et à 'b' dans   |
|                                   | "Un bateau bleu", mais ne         |
|                                   | correspond à rien dans "Ce        |
|                                   | matin".                           |
+-----------------------------------+-----------------------------------+
| [`+`](#special-plus){#special-plu | Correspond à l'expression         |
| s}                                | précédente qui est répétée une ou |
|                                   | plusieurs fois. C'est équivalent  |
|                                   | à {1,}.                           |
|                                   |                                   |
|                                   | Ainsi, `/a+/` correspond au 'a'   |
|                                   | dans "maison" et à tous les 'a'   |
|                                   | dans "maaaaaaison" mais ne        |
|                                   | correspond à rien dans "mission". |
+-----------------------------------+-----------------------------------+
| [`?`](#special-questionmark){#spe | Correspond à l'expression         |
| cial-questionmark}                | précédente qui est présente une   |
|                                   | fois ou pas du tout. C'est        |
|                                   | équivalent à `{0,1}`.\            |
|                                   | \                                 |
|                                   | Ainsi, `/e?le?/` correspond au    |
|                                   | 'el' dans "gel" et au 'le' dans   |
|                                   | "angle" mais aussi au 'l' dans    |
|                                   | "Oslo".\                          |
|                                   | \                                 |
|                                   | S'il est utilisé immédiatement    |
|                                   | après l'un des quantificateurs :  |
|                                   | \*, +, ?, ou {}, il rend le       |
|                                   | quantificateur moins « gourmand » |
|                                   | auquel cas le moins de caractères |
|                                   | correspond (le comportement par   |
|                                   | défaut, « gourmand », permettant  |
|                                   | de faire correspondre le plus de  |
|                                   | caractères possible). Par exemple |
|                                   | `/\d+/` utilisée avec "123abc"    |
|                                   | fait correspondre "123". Utiliser |
|                                   | `/\d+?/` à la même chaîne de      |
|                                   | caractères fait correspondre      |
|                                   | "1".\                             |
|                                   | \                                 |
|                                   | Ce symbole est également utilisé  |
|                                   | dans les tests de présence autour |
|                                   | de l'expression, décrits par les  |
|                                   | lignes `x(?=y)` et `x(?!y)` de ce |
|                                   | tableau.\                         |
|                                   |                                   |
+-----------------------------------+-----------------------------------+
| [`.`](#special-dot){#special-dot} | (Le point) correspond à n'importe |
|                                   | quel caractère excepté un         |
|                                   | caractère de saut de ligne.       |
|                                   |                                   |
|                                   | Ainsi, `/.n/` correspond à  'un'  |
|                                   | et 'en' dans "Un baobab nain en   |
|                                   | cours de  croissance" mais pas à  |
|                                   | 'nain'.                           |
+-----------------------------------+-----------------------------------+
| [`(x)`](#special-capturing-parent | Correspond à 'x' et garde la      |
| heses){#special-capturing-parenth | correspondance en mémoire. Les    |
| eses}                             | parenthèses permettent de         |
|                                   | *capturer* l'expression dans un « |
|                                   | groupe ».\                        |
|                                   | \                                 |
|                                   | Les '`(toto)`' et '`(truc)`',     |
|                                   | dans le motif                     |
|                                   | `/(toto) (truc) \1 \2/`           |
|                                   | correspondent et gardent en       |
|                                   | mémoire les deux premiers mots de |
|                                   | la chaîne de caractère "toto truc |
|                                   | toto truc". Les `\1` et `\2` du   |
|                                   | motif correspondent               |
|                                   | respectivement à la première et à |
|                                   | la deuxième correspondances pour  |
|                                   | les sous-chaînes entre            |
|                                   | parenthèses. Lorsqu'on souhaite   |
|                                   | effectuer un remplacement, on     |
|                                   | utilisera `$1` et `$2` pour faire |
|                                   | référence au premier et second    |
|                                   | groupe et `$``n `pour faire       |
|                                   | référence au n-ième groupe        |
|                                   | capturé (ex.                      |
|                                   | `('toto truc'.replace(/(...) (... |
|                                   | )/, '$2 $1').`                    |
|                                   | `$&` fera référence à la chaîne   |
|                                   | entière).                         |
+-----------------------------------+-----------------------------------+
| [`(?:x)`](#special-non-capturing- | Correspond à 'x' mais ne garde    |
| parentheses){#special-non-capturi | pas la correspondance en mémoire. |
| ng-parentheses}                   | Les parenthèses ne *capturent*    |
|                                   | pas l'expression et permettent    |
|                                   | d'utiliser des sous-expressions   |
|                                   | d'une expression régulière pour   |
|                                   | travailler plus finement.         |
|                                   | L'expression `/(?:zoo){1,2}/`     |
|                                   | sans parenthèes non-capturantes   |
|                                   | `les caractères {1,2}` ne         |
|                                   | s'appliqueraient qu'au dernier    |
|                                   | 'o' de 'zoo'. Avec les            |
|                                   | parenthèses capturantes, `{1,2}`  |
|                                   | s'applique au mot entier 'zoo'.   |
|                                   | Pour plus d'informations, voir    |
|                                   | [Utiliser les                     |
|                                   | parenthèses](#parentheses)        |
|                                   | ci-après.                         |
+-----------------------------------+-----------------------------------+
| [`x(?=y)`](#special-lookahead){#s | Correspond à 'x' seulement s'il   |
| pecial-lookahead}                 | est suivi de 'y'. On appelle cela |
|                                   | un test de succession             |
|                                   | (*lookahead*).                    |
|                                   |                                   |
|                                   | Ainsi, `/Jack(?=Sparrow)/`        |
|                                   | correspond à 'Jack' seulement     |
|                                   | s'il est suivi de 'Sparrow'.      |
|                                   | `/Jack(?=Sparrow|Bauer)/`         |
|                                   | correspond à 'Jack' seulement     |
|                                   | s'il est suivi de 'Sparrow' ou de |
|                                   | 'Bauer'. Cependant, ni 'Sparrow'  |
|                                   | ni 'Bauer' ne feront partie de la |
|                                   | correspondance.                   |
+-----------------------------------+-----------------------------------+
| [`x(?!y)`](#special-negated-look- | Correspond à 'x' seulement si 'x' |
| ahead){#special-negated-look-ahea | n'est pas suivi de 'y'.           |
| d}                                |                                   |
|                                   | Ainsi, `/\d+(?!\.)/` correspond à |
|                                   | un nombre qui n'est pas suivi par |
|                                   | un point, cette expression        |
|                                   | utilisée avec `la chaîne 3.141`   |
|                                   | correspondra pour '141' mais pas  |
|                                   | pour '3.141'.                     |
+-----------------------------------+-----------------------------------+
| [`x|y`](#special-or){#special-or} | Correspond à 'x' ou 'y'.          |
|                                   |                                   |
|                                   | Ainsi, `/vert|rouge/` correspond  |
|                                   | à 'vert' dans "feu vert" et à     |
|                                   | 'rouge' dans "feu rouge".         |
+-----------------------------------+-----------------------------------+
| [`{n}`](#special-quantifier){#spe | Correspond pour exactement n      |
| cial-quantifier}                  | occurences de l'expression        |
|                                   | précédente. N doit être un entier |
|                                   | positif.\                         |
|                                   | \                                 |
|                                   | Ainsi, `/a{2}/` ne correspond pas |
|                                   | au 'a' de "Mozilla" mais          |
|                                   | correspond à tous les 'a' de      |
|                                   | "Mozilaa" et aux deux premiers    |
|                                   | 'a' de "Mozillaaa".               |
+-----------------------------------+-----------------------------------+
| `{n,}`                            | Correspond lorsqu'il y a au moins |
|                                   | `n` occurences de l'expression    |
|                                   | précédente. `n` doit être un      |
|                                   | entier positif.                   |
|                                   |                                   |
|                                   | Par exemple `/a{2,}/`             |
|                                   | correspondra à `"aa"` ou à        |
|                                   | `"aaa"` ou encore à `"aaaa"` mais |
|                                   | pas à `"a"`.                      |
+-----------------------------------+-----------------------------------+
| [`{n,m}`](#special-quantifier-ran | Lorsque `n` et `m` sont des       |
| ge){#special-quantifier-range}    | entiers positifs, cela correspond |
|                                   | à au moins `n` occurences de      |
|                                   | l'expression précédente et à au   |
|                                   | plus `m` occurrences. Lorsque `m` |
|                                   | n'est pas utilisé, la valeur par  |
|                                   | défaut correspondante sera        |
|                                   | l'infini.                         |
|                                   |                                   |
|                                   | Ainsi, `/a{1,3}/` ne correspond à |
|                                   | rien dans "Mozill", au 'a' de     |
|                                   | "Mozilla", au deux premiers 'a'   |
|                                   | de "Mozillaa" et au trois         |
|                                   | premiers 'a' de "Mozillaaaaa".    |
|                                   | Pour ce dernier exemple, on doit  |
|                                   | noter que le correspondance ne se |
|                                   | fait que sur "aaa" bien qu'il y   |
|                                   | ait plus de 'a' dans la chaîne de |
|                                   | caractères.                       |
+-----------------------------------+-----------------------------------+
| [`[xyz]`](#special-character-set) | Un ensemble de caractère. Ce type |
| {#special-character-set}          | de motif correspond pour          |
|                                   | n'importe quel caractètre présent |
|                                   | entre les crochets, y compris les |
|                                   | [séquences                        |
|                                   | d'échappement](/fr/docs/Web/JavaS |
|                                   | cript/Guide/Valeurs,_variables,_e |
|                                   | t_littéraux#S.C3.A9quences_d'.C3. |
|                                   | A9chappement_Unicode).            |
|                                   | Les caractères spéciaux comme le  |
|                                   | point (.) et l'astérisque ne sont |
|                                   | pas considérés comme spéciaux au  |
|                                   | sein d'un ensemble et n'ont donc  |
|                                   | pas besoin d'être échappés. Il    |
|                                   | est possible de donner un         |
|                                   | ensemble sur un intervalle de     |
|                                   | caractères en utilisant un tiret  |
|                                   | (-), comme le montre l'exemple    |
|                                   | qui suit.\                        |
|                                   | \                                 |
|                                   | Le motif `[a-d]`,  aura les mêmes |
|                                   | correspondances que `[abcd]`,     |
|                                   | correspondant au 'b' de "bulle"   |
|                                   | et au 'c' de "ciel". Les motifis  |
|                                   | `/[a-z.]+/ `et `/[\w.]+/`         |
|                                   | correspondront pour la chaîne     |
|                                   | entirère : "Adre.ss.e".           |
+-----------------------------------+-----------------------------------+
| [`[^xyz]`](#special-negated-chara | Exclusion d'un ensemble de        |
| cter-set){#special-negated-charac | caractères. Cela correspond à     |
| ter-set}                          | tout ce qui n'est pas compris     |
|                                   | entre crochets. Il est possible   |
|                                   | de fournir un intervalle de       |
|                                   | caractères en utilisant un tiret  |
|                                   | (-). Les autres règles qui        |
|                                   | s'appliquent pour l'ensemble de   |
|                                   | caractères (ci-avant)             |
|                                   | s'appliquent également ici.       |
|                                   |                                   |
|                                   | Par exemple, `[^abc]` est         |
|                                   | équivalent à `[^a-c]`. Ils        |
|                                   | correspondent à 'u' dans "bulle"  |
|                                   | et à 'i' dans "ciel".             |
+-----------------------------------+-----------------------------------+
| [`[\b]`](#special-backspace){#spe | Correspond pour un retour arrière |
| cial-backspace}                   | (U+0008). (À ne pas confondre     |
|                                   | avec `\b`.)                       |
+-----------------------------------+-----------------------------------+
| [`\b`](#special-word-boundary){#s | Correspond à la position          |
| pecial-word-boundary}             | d'uneAfter the  *limite de mot*.  |
|                                   | Une limite de mot correspond à la |
|                                   | position où un caractère d'un mot |
|                                   | n'est pas suivi ou précédé d'un   |
|                                   | autre caractère de mot. Il faut   |
|                                   | savoir que la limite              |
|                                   | correspondante n'est pas incluse  |
|                                   | dans le résultat. Autrement dit,  |
|                                   | la longueur d'une telle           |
|                                   | correspondance est nulle. (À ne   |
|                                   | pas confondre avec `[\b]`.)       |
|                                   |                                   |
|                                   | Exemples :\                       |
|                                   | `/\bm/` correspond au 'm' dans    |
|                                   | "mignon" ;\                       |
|                                   | `/no\b/` ne correspond pas au     |
|                                   | 'no' de "mignon" car 'no' est     |
|                                   | suivi de 'n' qui est un caractère |
|                                   | de limite de mot;\                |
|                                   | `/non\b/` correspond au 'non' de  |
|                                   | "mignon" car 'non' représente la  |
|                                   | fin de la chaîne de caractère et  |
|                                   | n'est donc pas suivi par un       |
|                                   | caractère de mot.\                |
|                                   | `/\w\b\w/` ne correspondra jamais |
|                                   | à quoi que ce soit car un         |
|                                   | caractère de mot ne peut pas être |
|                                   | suivi à la fois par un caractère  |
|                                   | de mot et un caractère n'étant    |
|                                   | pas un caractère de mot.          |
|                                   |                                   |
|                                   | <div class="note">                |
|                                   |                                   |
|                                   | **Note :** Le moteur              |
|                                   | d'expressions rationnelles        |
|                                   | JavaScript définit [un ensemble   |
|                                   | de caractères                     |
|                                   | spécifiques](http://www.ecma-inte |
|                                   | rnational.org/ecma-262/5.1/#sec-1 |
|                                   | 5.10.2.6){.external}              |
|                                   | qui doivent être considérés comme |
|                                   | des caractères de mot. Tout       |
|                                   | caractère qui n'est pas dans cet  |
|                                   | ensemble est considéré comme une  |
|                                   | limite de mot. Cet ensemble de    |
|                                   | caractères est relativement       |
|                                   | limité car constitué uniquement   |
|                                   | des caractères de l'alphabet      |
|                                   | romain en minuscules et en        |
|                                   | majuscules, des chiffres décimaux |
|                                   | et du tiret-bas (*underscore*).   |
|                                   | Les autres caractères, comme les  |
|                                   | caractères accentués (é ou ü par  |
|                                   | exemple), sont donc considérés    |
|                                   | comme des limites de mots.        |
|                                   |                                   |
|                                   | </div>                            |
+-----------------------------------+-----------------------------------+
| [`\B`](#special-non-word-boundary | Correspond à une "non-*limite de  |
| ){#special-non-word-boundary}     | mot*". Cela correspond pour les   |
|                                   | cas suivants :                    |
|                                   |                                   |
|                                   | -   Avant le premier caractère    |
|                                   |     d'une chaîne de caractères    |
|                                   | -   Après le dernier caractère    |
|                                   |     d'une chaîne de caractères    |
|                                   | -   Entre deux caractères de mot  |
|                                   | -   Entre deux caractères qui ne  |
|                                   |     sont pas des caractères de    |
|                                   |     mot                           |
|                                   | -   Avec la chaîne vide.          |
|                                   |                                   |
|                                   | Ainsi, `/\B../` correspond au     |
|                                   | 'oo' de "football" (et `/e\B./`   |
|                                   | correspond au 'er' dans "une mer  |
|                                   | "                                 |
+-----------------------------------+-----------------------------------+
| [`\cX`](#special-control){#specia | Étant donné un caractère *X*      |
| l-control}                        | compris entre A et Z, cela        |
|                                   | correspond au caractère de        |
|                                   | contrôle dans une chaîne de       |
|                                   | caractères.                       |
|                                   |                                   |
|                                   | Ainsi, `/\cM/` correspond au      |
|                                   | caractère de contrôle M (U+000D)  |
|                                   | d'une chaîne de caractère.        |
+-----------------------------------+-----------------------------------+
| [`\d`](#special-digit){#special-d | Correspond à un chiffre et est    |
| igit}                             | équivalent à `[0-9]`.             |
|                                   |                                   |
|                                   | Ainsi, `/\d/` ou `/[0-9]/`        |
|                                   | correspond à '2' dans "H2O est la |
|                                   | molécule de l'eau".               |
+-----------------------------------+-----------------------------------+
| [`\D`](#special-non-digit){#speci | Correspond à tout caractère qui   |
| al-non-digit}                     | n'est pas un chiffre et est       |
|                                   | équivalent à` [^0-9]`.            |
|                                   |                                   |
|                                   | Ainsi, `/\D/` ou `/[^0-9]/`       |
|                                   | correspond à 'H' dans "H2O est la |
|                                   | molécule de l'eau".               |
+-----------------------------------+-----------------------------------+
| [`\f`](#special-form-feed){#speci | Correspond à un saut de page      |
| al-form-feed}                     | (U+000C).                         |
+-----------------------------------+-----------------------------------+
| [`\n`](#special-line-feed){#speci | Correspond à un saut de ligne     |
| al-line-feed}                     | (U+000A).                         |
+-----------------------------------+-----------------------------------+
| [`\r`](#special-carriage-return){ | Correspond à un retour chariot    |
| #special-carriage-return}         | (U+000D).                         |
+-----------------------------------+-----------------------------------+
| [`\s`](#special-white-space){#spe | Correspond à un blanc (cela       |
| cial-white-space}                 | comprend les espace, tabulation,  |
|                                   | saut de ligne ou saut de page).   |
|                                   | C'est équivalent à                |
|                                   | `[ \f\n\r\t\v\u00a0\u1680\u2000-\ |
|                                   | u200a\u2028\u2029\u202f\u205f\u30 |
|                                   | 00\ufeff]`.                       |
|                                   |                                   |
|                                   | Ainsi, `/\s\w*/` correspond à '   |
|                                   | toto' dans "truc toto".           |
+-----------------------------------+-----------------------------------+
| [`\S`](#special-non-white-space){ | Correspond à un caractère qui     |
| #special-non-white-space}         | n'est pas un blanc. C'est         |
|                                   | équivalent à                      |
|                                   | `[^ \f\n\r\t\v\u00a0\u1680\u2000- |
|                                   | \u200a\u2028\u2029\u202f\u205f\u3 |
|                                   | 000\ufeff]`.                      |
|                                   |                                   |
|                                   | Ainsi, `/\S\w*/` correspond à     |
|                                   | 'truc' dans "truc toto".          |
+-----------------------------------+-----------------------------------+
| [`\t`](#special-tab){#special-tab | Correspond à une tabulation       |
| }                                 | (U+0009).                         |
+-----------------------------------+-----------------------------------+
| [`\v`](#special-vertical-tab){#sp | Correspond à une tabulation       |
| ecial-vertical-tab}               | verticale (U+000B).               |
+-----------------------------------+-----------------------------------+
| [`\w`](#special-word){#special-wo | Correspond à n'importe quel       |
| rd}                               | caractère alphanumérique, y       |
|                                   | compris le tiret bas. C'est       |
|                                   | équivalent à `[A-Za-z0-9_]`.      |
|                                   |                                   |
|                                   | Ainsi, `/\w/` correspond à 'l'    |
|                                   | dans "licorne", à '5' dans        |
|                                   | "5,28€", et à '3' dans "3D."      |
+-----------------------------------+-----------------------------------+
| [`\W`](#special-non-word){#specia | Correspond à n'importe quel       |
| l-non-word}                       | caractère n'étant pas un          |
|                                   | caractère de mot. Cela est        |
|                                   | équivalent à `[^A-Za-z0-9_]`.     |
|                                   |                                   |
|                                   | Ainsi, `/\W/` ou                  |
|                                   | `/[^A-Za-z0-9_]/` correspond à    |
|                                   | '%' dans "50%."                   |
+-----------------------------------+-----------------------------------+
| [`\n`](#special-backreference){#s | Soit *n* un entier strictement    |
| pecial-backreference}             | positif, cela fait référence au   |
|                                   | groupe de la n-ième expression    |
|                                   | entre parenthèses (en comptant    |
|                                   | les parenthèses ouvrantes).       |
|                                   |                                   |
|                                   | Ainsi, `/pomme(,)\spoire\1/`      |
|                                   | correspond à 'pomme, poire,' dans |
|                                   | "pomme, poire, cerise, pêche".    |
+-----------------------------------+-----------------------------------+
| [`\0`](#special-null){#special-nu | Correspond au caractère NULL      |
| ll}                               | (U+0000). Il ne doit pas être     |
|                                   | suivi d'un autre chiffre car      |
|                                   | `\0<chiffres>` est une [séquence  |
|                                   | d'échappement](/fr/docs/Web/JavaS |
|                                   | cript/Guide/Valeurs,_variables,_e |
|                                   | t_littéraux#S.C3.A9quences_d'.C3. |
|                                   | A9chappement_Unicode)             |
|                                   | pour les nombres en notation      |
|                                   | octale (si besoin d'utiliser un   |
|                                   | chiffre ensuite, on pourra        |
|                                   | utiliser la forme `\x00`, cf.     |
|                                   | ci-après).                        |
+-----------------------------------+-----------------------------------+
| [`\xhh`](#special-hex-escape){#sp | Correspond au caractère dont le   |
| ecial-hex-escape}                 | code hexadécimal est hh (deux     |
|                                   | chiffres hexadécimaux).           |
+-----------------------------------+-----------------------------------+
| [`\uhhhh`](#special-unicode-escap | Correspond au caractère dont le   |
| e){#special-unicode-escape}       | code est hhhh (quatre chiffres    |
|                                   | hexadécimaux).                    |
+-----------------------------------+-----------------------------------+
| `\u{hhhh}`                        | (Uniquement actif quand le        |
|                                   | marqueur `u` est activé)          |
|                                   | Correspond au caractère dont la   |
|                                   | valeur Unicode est `hhhh` (en     |
|                                   | chiffre hexadécimaux).            |
+-----------------------------------+-----------------------------------+

: Caractères spéciaux utilisables pour les expressions rationnelles.

Afin d'échapper les informations saisies par l'utilisateur et de traîter
les chaînes de caractères pour les utiliser au sein d'un expression
régulière correspondante, il est possible d'utiliser le remplacement
suivant :

``` {.brush: .js}
function escapeRegExp(string){
  // $& correspond à la chaîne correspondante
  // dans son intégralité
  return string.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
}
```

Le marqueur `g` situé en fin d'expression permet d'effectuer une
recherche globale, qui parcoure toute la chaîne et renvoie l'ensemble
des correspondances trouvées (voir [Utiliser les
marqueurs](#recherches_flag) ci-après).


**Note :** Voir la page sur la méthode `String.replace` pour plus
d'informations.


### [Utiliser les parenthèses]{#parentheses} {#Utiliser_les_parenthèses}

Les parenthèses encadrant une partie du motif de l'expression régulière
peuvent être utilisées pour garder en mémoire les correspondances. Cela
pourra être utile pour réutiliser la correspondance trouvée.

Ainsi, le motif `/Chapitre (\d+)\.\d*/` utilise des caractères échappés
et spéciaux et indique une partie du motif à garder en mémoire. Ce motif
correspond aux caractères 'Chapitre ' suivi par un ou plusieurs
caractères numériques (`\d` correspond à un chiffre et `+` indiquant que
une série de 1 ou plusieurs chiffres), suivis par un point (qu'il est
nécessaire d'échapper car c'est un caractère spécial, on utilise donc
'\\' pour indiquer qu'on souhaite reconnaître le caractère '.'), suivi
par 0 ou plusieurs chiffres (`\d` correspondant à un chiffre et
l'astérisque indiquant que le caractère est présent 0 ou plusieurs
fois). Les parenthèses sont utilisées pour garder en mémoire les
premiers chiffres correspondant.

Ce motif est trouvé dans "Ouvrir le Chapitre 4.3 au paragraphe 6" et le
chiffre '4' est gardé en mémoire. Le motif n'est pas trouvé dans 
"Chapitre 3 et 4", car la chaîne de caractères ne comporte pas de point
après le '3'.

Pour qu'une partie de la chaîne de caractère corresponde mais que la
correspondance ne soit pas gardée en mémoire, on pourra utiliser `?:`.
Ainsi, `(?:\d+)` correspondra pour une séquence de chiffres (1 ou
plusieurs chiffres) mais on ne gardera pas en mémoire les caractères
correspondants.

Utiliser les expressions rationnelles {#Utiliser_les_expressions_rationnelles}
-------------------------------------

Les expresssions régulières sont utilisées avec les méthodes
`test`` `et` exec` de l'objet` RegExp` et avec les méthodes `match`,
`replace`, `search`, et `split` de l'objet `String`. Ces méthodes sont
expliquées en détail dans la [Référence
JavaScript](/fr/docs/Web/JavaScript/Reference).

  Méthode                                                                                                                                                                                                                                                                                                                                                                                Description
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  [`exec`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp/exec "La méthode exec() exécute la recherche d'une correspondance sur une chaîne de caractères donnée. Elle renvoie un tableau contenant les résultats ou null.")                                                                                                                                                     Une méthode de l'objet `RegExp` qui exécute une recherche de correspondance dans une chaîne de caractères. Elle renvoie un tableau d'informations ou `null` lorsqu'il n'y a pas de correspondance.
  [`test`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp/test "La méthode test() vérifie s'il y a une correspondance entre un texte et une expression rationnelle. Elle retourne true en cas de succès et false dans le cas contraire.")                                                                                                                                       Une méthode de l'objet `RegExp` testant la présence d'une correspondance dans une chaîne de caractères. Elle renvoie true ou false.
  [`match`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/match "La méthode match() permet d'obtenir le tableau des correspondances entre la chaîne courante et une expression rationnelle.")                                                                                                                                                                                  Une méthode de l'objet `String` qui exécute une recherche de correspondance dans une chaîne de caractères. Elle renvoie un tableau d'informations ou null lorsqu'il n'y a pas de correspondance.
  [`search`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/search "La méthode search() éxecute une recherche dans une chaine de caractères grâce à une expression rationnelle appliquée sur la chaîne courante.")                                                                                                                                                              Une méthode de l'objet `String` qui teste la présence d'une correspondance dans une chaîne de correspondance. Elle renvoie la position de la correspondance ou -1 s'il n'y en a pas.
  [`replace`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/replace "La méthode replace() renvoie une nouvelle chaîne de caractères dans laquelle tout ou partie des correspondances à un modèle sont remplacées par un remplacement. Le modèle utilisé peut être une RegExp et le remplacement peut être une chaîne ou une fonction à appeler pour chaque correspondance.")   Une méthode de l'objet `String` qui recherche une correspondance dans une chaîne de caractères et qui remplace la correspondance par une chaîne de substitution.
  [`split`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/split "La méthode split() permet de diviser une chaîne de caractères à partir d'un séparateur pour fournir un tableau de sous-chaînes.")                                                                                                                                                                             Une méthode de l'objet `String` qui utilise une expression régulière ou une chaîne de caractères pour découper une chaîne de caractères en un tableau comprenant les fragments résultants.

  : Méthodes utilisant les expressions régulières

Pour savoir si un motif est présent au sein d'une chaîne de caractères,
utiliser les méthodes` test` ou `search`. Pour obtenir plus
d'informations (moins rapidement) on utilisera les méthodes `exec` ou
`match`. Si on utilise `exec` ou `match` et qu'une correspondance est
trouvée, ces méthodes renverront un tableau et mettront à jour des
propriétés de l'objet global `RegExp` et aussi de l'instance de `RegExp`
associée à l'expression rationnelle ( De ces propriétés mises à jour, la
seule qui ne soit pas non-standard ou dépréciée est `lastIndex` .
D'ailleurs, il peut être nécessaire de s'assurer de la valeur de
`lastIndex` avant d'utiliser `exec` avec les drapeaux `g` ( `global` )
ou `y` ( `sticky` ), ou d'utiliser `match` avec le drapeau `y` ). Si
aucune correspondance n'est trouvée, la méthode `exec` renverra `null`
(qui est automatiquement converti à `false` lors d'un test
conditionnel).

Dans l'exemple qui suit, le script utilise la méthode `exec` pour
trouver une correspondance dans une chaîne de caractères.

``` {.brush: .js}
var monExpressionReguliere = /d(b+)d/g;
var monTableau = monExpressionReguliere.exec("cdbbdbsbz");
```

S'il n'est pas nécessaire d'accéder aux propriétés de l'expression
régulière, une autre façon de récupérer `monTableau` peut être :

``` {.brush: .js}
var monTableau = /d(b+)d/g.exec("cdbbdbsbz");
// équivalent à "cdbbdbsbz".match(/d(b+)d/g);
```

Si on souhaite construire une expression régulière à partir d'une chaîne
de caractères, on peut utiliser le script suivant :

``` {.brush: .js}
var monExpressionReguliere = new RegExp("d(b+)d", "g");
var monTableau = monExpressionReguliere.exec("cdbbdbsbz");
```

Avec ces scripts, on obtient bien une correspondance, la méthode renvoie
un tableau et met à jour les propriétés listées dans le tableau qui
suit.

Résultats dûs à l'exécution d'une expression rationnelle.
Objet
Propriété ou indice
Description
Pour cet exemple
`monTableau`
 
La chaîne de caractères correspondante et les fragments de chaînes
gardés en mémoire.
`["dbbd", "bb"]`
`index`
L'indice (débute à partir de 0) de la correspondance, compté dans la
chaîne de caractère initiale.
`1`
`input`
La chaîne de caractères initiale.
`"cdbbdbsbz"`
`[0]`
Les derniers caractères qui correspondent.
`"dbbd"`
`monExpressionRégulière`
`lastIndex`
L'indice auquel débuter la prochaine correspondance. (Cette propriété
n'est utilisée que si l'expression régulière utilise l'option g, décrite
dans « [Effectuer des recherches avancées avec les
marqueurs](#recherches_flag) ».
`5`
`source`
Le texte du motif, mis à jour à la création de l'expression régulière
mais pas lors de son exécution.
`"d(b+)d"`
Comme le montre la seconde formulation de cet exemple, il est possible
d'utiliser une expression rationnelle, créée avec un objet initialisé
sans l'affecter à une variable. Cela implique qu'à chaque utilisation,
on aura une nouvelle expression régulière distincte et qu'on ne pourra
pas, pour cette raison, accéder aux propriétés de l'expression
régulière. Avec le script suivant :

``` {.brush: .js}
var monExpressionReguliere = /d(b+)d/g;
var monTableau = monExpressionReguliere.exec("cdbbdbsbz");
console.log("La valeur de lastIndex est " + monExpressionReguliere.lastIndex);

// "La valeur de lastIndex est 5"
```

Si le script utilisé est :

``` {.brush: .js}
var monTableau = /d(b+)d/g.exec("cdbbdbsbz");
console.log("La valeur de lastIndex est " + /d(b+)d/g.lastIndex);

// "La valeur de lastIndex est 0"
```

Les occurences de `/d(b+)d/g` dans les deux instructions sont des objets
différents. Leurs propriétés `lastIndex` respectives ont donc des
valeurs différentes. Quand il est nécessaire d'accéder aux propriétés
d'un objet décrivant une expression rationnelle, il faudra d'abord
l'affecter à une variable.

### Utiliser les correspondances de groupes avec les parenthèses {#Utiliser_les_correspondances_de_groupes_avec_les_parenthèses}

Les parenthèses, utilisées dans un motif d'expression régulière,
permettent de garder en mémoire un groupe (ou fragment) d'une
correspondance. Ainsi, `/a(b)c/` correspond aux caractères 'abc' et
garde 'b' en mémoire. Pour récupérer ces fragments mémorisés, on peut
utiliser les éléments du tableau `array` `[1]`, ..., `[n]`.

Le nombre de fragments qu'il est possible de garder entre parenthèses
n'est pas limité. Le tableau renvoyé contiendra tout ce qui aura été
trouvé. Les exemples qui suivent montrent comment utiliser cette
syntaxe.

Le script qui suit utilise la méthode
[`replace()`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/replace "La méthode replace() renvoie une nouvelle chaîne de caractères dans laquelle tout ou partie des correspondances à un modèle sont remplacées par un remplacement. Le modèle utilisé peut être une RegExp et le remplacement peut être une chaîne ou une fonction à appeler pour chaque correspondance.")
pour échanger les mots d'une chaîne de caractères. Pour remplacer le
texte, le script utilise `$1` et `$2` qui correspondent au premier et
deuxième groupe correspondant.

``` {.brush: .js}
var re = /(\w+)\s(\w+)/;
var str = "Titi toto";
var newstr = str.replace(re, "$2, $1");
console.log(newstr);
```

Cela affichera "toto, Titi".

### [Effectuer des recherches avancées en utilisant les marqueurs (*flags*)]{#recherches_flag} {#Effectuer_des_recherches_avancées_en_utilisant_les_marqueurs_(flags)}

Les expressions rationnelles peuvent être utilisées avec cinq marqueurs
optionnels permettant des recherches globales et/ou ne respectant pas la
casse. Ces marqueurs peuvent être utilisés séparement ou ensemble, quel
que soit l'ordre. Ils font partie de l'expression régulière.

  Drapeau (*Flag*)   Description
  ------------------ ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  `g`                Recherche globale
  i                  Recherche ne respectant pas la casse
  m                  Recherche sur plusieurs lignes
  u                  Unicode. Le motif de recherche est interprété comme une séquence de codets Unicode.
  y                  Effectue une recherche qui « adhère », en partant de la position courante de la chaîne de caractères sur laquelle la recherche est effectuée. Voir la page sur [`sticky`](/fr/docs/Web/JavaScript/Reference/Objets_globaux/RegExp/sticky "La propriété sticky (adhérante) permet de déterminer si la recherche s'effectue uniquement à partir de l'indice lastIndex lié à l'expression rationnelle ou non). sticky est une propriété accessible en lecture seule, rattachée à l'instance.").

  : Drapeaux utilisés avec les expressions régulières.


[Note concernant Firefox
3](https://developer.mozilla.org/fr/docs/Mozilla/Firefox/Releases/3){.new}

Le support du marqueur `y` a été ajouté dans Firefox 3. Le marqueur `y`
échoue s'il n'y a pas de correspondance, à la position courante, pour la
chaîne de caractère donnée.


Pour utiliser un marqueur avec une expression régulière, on utilisera la
syntaxe suivante :

``` {.brush: .js}
var re = /motif/marqueurs;
```

ou

``` {.brush: .js}
var re = new RegExp("motif", "marqueurs");
```

Les marqueurs font partie intégrante d'une expression régulière, ils ne
peuvent pas être ajoutés ou supprimés ensuite.

Ainsi, `re = /\w+\s/g` permet de créer une expression régulière pour
trouver un ou plusieurs caractères suivis d'un espace, la recherche est
effectuée globalement, sur toute la chaîne de caractères.

``` {.brush: .js}
var re = /\w+\s/g;
var str = "un deux trois quatre";
var monTableau = str.match(re);
console.log(monTableau);
```

Cela affichera \["un ", "deux ", "trois "\]. On pourrait remplacer la
ligne :

``` {.brush: .js}
var re = /\w+\s/g;
```

avec la ligne :

``` {.brush: .js}
var re = new RegExp("\\w+\\s", "g");
```

pour obtenir le même résultat.

Le comportement du marqueur `'g'` est différent selon qu'il est utilisé
avec `exec()` ou avec `match()`. Pour `match()`, c'est la chaîne de
caractères qui invoque la méthode et l'expression rationnelle est alors
un argument. Pour `exec()`, c'est l'expression rationnelle qui invoque
la méthode et c'est la chaîne de caractères qui est passée en argument.
Dans l'appel à `exec()`, le marqueur `'g'` permet d'avoir une
progression itérative.

Le marqueur `m` pourra être utilisé pour traiter une chaîne de
caractères de plusieurs lignes comme plusieurs lignes distinctes. Si ce
marqueur est utilisé, les caractères spéciaux `^` et `$` correspondront
au début ou à la fin de n'importe quelle ligne appartenant à la chaîne
de caractères au lieu de correspondre simplement au début ou à la fin de
la chaîne.

Exemples {#Exemples}
--------

Les exemples qui suivent utilisent les expressions régulières dans
différents cas.

### Changer l'ordre d'une saisie {#Changer_l'ordre_d'une_saisie}

L'exemple qui suit utilise les expressions régulières et
`string.split()` et `string.replace()`. Le script nettoie la chaîne de
caractères saisie qui contient des noms (prénom puis nom) séparés par
des blancs, tabulations et points-virgules. Enfin il inverse les noms et
prénoms puis trie la liste.

``` {.brush: .js}
// La chaîne des noms contient plusieurs blancs et tabulations,
// il peut y avoir plusieurs espaces entre le nom et le prénom.
var noms = "Harry Trump ;Fred Barney; Helen Rigby ; Bill Abel ; Chris Hand ";

var output = ["---------- Chaîne originale\n", noms + "\n"];

// Préparer deux expressions régulières pour stocker un tableau.
// et découper les chaînes dans ce tableau.

// motif: on peut avoir des blancs, un point virgule puis d'autres blancs
var motifs = /\s*;\s*/;

// Découper la chaîne de caractères en morceaux séparés par le précédent motif
// Stocker ces morceaux dans un tableau listeNoms
var listeNoms = noms.split(motif);

// nouveau motif : un ou plusieurs caractères, des blancs puis des caractères.
// On utilise des parenthèses pour garder en mémoire les groupes du motif.
// On utilisera ces groupes par la suite.
motif = /(\w+)\s+(\w+)/;

// Nouveau tableau pour enregistrer les noms traités.
var listeParNomFamille = [];

// Afficher le tableau des noms et remplir le nouveau tableau
// avec les noms et prénoms séparés par des virgules, le nom 
// de famille étant écrit en premier 
//
// La méthode replace supprime tout ce qui correspond au motif 
// et le remplace par le nom (mémorisé), une virgule, un espace
// et le prénom (mémorisé).
//
// Les variables $1 et $2 font références aux fragments gardés
// en mémoire lors de l'utilisation du motif.

output.push("---------- Après découpage avec l'expression régulière");

var i, len;
for (i = 0, len = listeNoms.length; i < len; i++){
  output.push(listeNoms[i]);
  listeParNomFamille[i] = listeNoms[i].replace(motif, "$2, $1");
}

// Afficher le nouveau tableau
output.push("---------- Noms et prénoms inversés");
for (i = 0, len = listeParNomFamille.length; i < len; i++){
  output.push(listeParNomFamille[i]);
}

// Trier par le nom de famille puis afficher le tableau trié
listeParNomFamille.sort();
output.push("---------- Triée");
for (i = 0, len = listeParNomFamille.length; i < len; i++){
  output.push(listeParNomFamille[i]);
}

output.push("---------- Fin");

console.log(output.join("\n"));
```

### Utiliser les caractères spéciaux pour vérifier la saisie {#Utiliser_les_caractères_spéciaux_pour_vérifier_la_saisie}

Dans l'exemple suivant, on s'attend à ce que l'utilisateur saisissent un
numéro de téléphone. Quand l'utilisateur appuie sur le bouton
"Vérifier", le script vérifie la validité du numéro. Si le numéro est
valide (il correspond à la séquence de caractères fournie par
l'expression régulière), le script affiche un message remerciant
l'utilisateur et confirmant le numéro. S'il est invalide, le script
informe l'utilisateur et lui signifie que les informations saisies ne
sont pas valides.

Dans les parenthèses sans mémoire `(?:` , l'expression régulière cherche
les deux premiers chiffres ou l'indicatif du pays suivi d'un blanc et du
premier chiffre, ce qui correspond à

``` {.brush: .html}
\d{2}|\+\d{2}[ ]\d
```

Cette partie signifie : deux chiffres OU un signe '+' suivi de deux
chiffres, un blanc et un autre chiffre.

Ensuite, on a un groupe qui est mémorisé (entre parenthèses) :

``` {.brush: .html}
([- ])
```

Ce groupe correspond à ce qui va être utilisé pour séparer les
différentes composantes du numéro de téléphone.

Ensuite,

``` {.brush: .html}
\d{2}\1
```

signifie qu'on a deux chiffres suivi du premier groupe qui est celui qui
définit le séparateur. Le reste est composé de la même façon. Ainsi les
numéros de téléphone +33 1 23 45 67 89 et 01 23 45 67 89 seront tous les
deux valides.

L'événement `Change`, provoqué quand l'utilisateur appuie sur Entrée,
renseigne la valeur `RegExp.input`.

``` {.brush: .html}
<!DOCTYPE html>
<html>  
  <head>  
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
    <meta http-equiv="Content-Script-Type" content="text/javascript">  
    <script type="text/javascript">  
      var re = /(?:\d{2}|\+\d{2}[ ]\d)([- ])\d{2}\1\d{2}\1\d{2}\1\d{2}/;  
      function testInfo(phoneInput){  
        var OK = re.exec(phoneInput.value);  
        if (!OK)  
          window.alert(phone.input + " n'est pas un numéro de téléphone valide!");  
        else
          window.alert("Merci, votre numéro est : " + OK[0]);  
      }  
    </script>  
  </head>  
  <body>  
    <p>Saisissez votre numéro de téléphone (avec indicatif) puis cliquez sur "Vérifier".
        <br>Le format attendu est ## ## ## ## ## ou +## # ## ## ## ##.</p>
    <form action="#">  
      <input id="phone"><button onclick="testInfo(document.getElementById('phone'));">Vérifier</button>
    </form>  
  </body>  
</html>
```
