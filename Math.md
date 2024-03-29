[Crypto](Crypto)

# Vectorial
div . rot = 0
rot . grad = 0


### Vectorial Compleja (C3)

* $e^x = lim_{h->0} (1 + x/h)^h$
* $e^z = \Sigma _{k=0}^\infty \frac{z^k}{k!}$
* $\frac{1}{1-z} = \Sigma _{k=0}^\infty z^k; |z| < 1$
* Holomorpha: continua y derivable -> $C^\infty$
* Simplemente connexo = sin hoyo

### Vectorial

* Strokes: ∫ F Dl (sobre dS linea 1dim orientada) :  ∫ rot(F) dS (con: dS = \vec{n}dS; sobre: S [2dim])
* Normal to a plan: Ax + By + Cz = D
  * Normal: $n = \pm (Ai + Bj + Ck) / \sqrt{A^2 + B^2 + C^2}$
* Curl (= rotational o rotor)
  ```
                  | i    | j    | k |
                  | d/dx | d/dy | d/dz |
  Nabla X F = det | Fx  | Fy  | Fz  |    = rot(F)
  ```
* Campo conservativo: Deriva de un potencial nabla V
  * Definicion:  $∫ F dl (sobre: \phi cerado dim1)$
  * Theorema: $∫ F dl (sobre: \phi _{1} dim1) = ∫ F dl (sobre \phi _{2} dim1)$
    * Para cualquier lineas phi1 y phi2 empezando y  acabando en lso mismos 2 puntos
  * Theorema: $rot(F) = rot(\nabla V) = 0$: y reciproca solo si F es C1 en el connexo

* Green para calculo de area

* Fourier, camino a la transformada
  * Derivada Compleja
  * Integrada compleja
  * Funciones compleja
  * Fourier

* Exponencial
  * $e^z = e^x (\cos{y} + i \sin{y})$ (con z = x +i y)

### Calculo

* Jacobiana

```text
Jf(x,y) = | df1  |  df1 |
          | ---  |  --- |
          | dx   |  dy  | 
          |------|------|
          | df2  |  df2 |
          | ---  |  --- |
          | dx   |  dy  |
```

* Norma
  1. Definida, positiva: `|x|>0 & |x| = 0 => x = 0`
  2. Homogeneidad: `|αx| = α|x|`
  3. Inegalidad triangular

* Producto Interno
  1. Definido positivo
  2. Symetrico
  3. Bilineal


#### Bola

* __Adherencia:__ `Adr(A) := {x∈E: B(x,ε) ∩ A ≠ ∅; ∀ε>0`
  * La Adherencia es el conjunto A unido con lo que tiene adherido y que no está necesariamente en A

* __Interior:__ `int A:= {x∈A: existe B(x,d) ∈ A}`
  * ex: No es posible meter una bola dentro del conjunto, por lo tanto Int(A) = ∅)
  * A es abierto <=> A = int A

* __Frontera:__ Además `Fr(A) = Adh(A) \ Int(A) = Adh(A)`  (en este caso de interior nulo)

* __Cerrado:__ (A) toda sucesion convergente de A converge en A
  * Adh(A) ⊂ A

* __Compacto:__ (A) toda sucesion de A tiene una subsecion convergente en A

* __Bola abierta:__ (B) de centro c y de radio r, (c,r)∈(E,ℝ); r>0; `B(c, r) := {x∈E; ||c-x||<r}`

* __Parte abierta:__ (A) `∀x ∈ A; ∃d>0 tq B(x,d) ⊂ A`

* __Convexo:__ Una parte C de un espacio vectorial real es convexa si para cada par de puntos de C, el segmento que los une está totalmente incluido en C; es decir, un conjunto es convexo si se puede ir de cualquier punto a cualquier otro en línea recta, sin salir del mismo (wiki)

* E y ∅ son abiertos Y cerrados


#### Cauchy, Banach, Hilbert

* __Cauchy (Sucesion):__ (ak) $∀ε>0; ∃k∈ℕ tq |ai-aj|<ε; ∀(i,j)>k$
* __Cauchy (Serie):__ (ak) $∀ε>0; ∃n∈ℕ tq \forall m>n \in \N \Sigma_{i=n}^m a_i (z-zbar)^i<ε; ∀(i,j)>k$

* __Ḇanach (Espacio):__ un espacio vectorial normado donde cada sucesion de Cauchy converge
  * Un EVN de dimension finita es de Banach

* __Hibert (Espacio):__ Espacio de Banach cuya norma esta definida por un producto interno

### Histogram cross entropy

The distance between H1 and H2 is: $D(H1, H2) = -\sum_i H1_i \log(H2_i)$
