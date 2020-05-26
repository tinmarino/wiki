
[Crypto](Crypto)


# Calculo

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


## Bola

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

* E y ∅ son abiertos Y cerrados


## Cauchy, Banach, Hilbert

* __Cauchy (Sucesion):__ (ak) `∀ε>0; ∃k∈ℕ tq |ai-aj|<ε; ∀(i,j)>k`

* __Ḇanach (Espacio):__ un espacio vectorial normado donde cada sucesion de Cauchy converge
  * Un EVN de dimension finita es de Banach

* __Hibert (Espacio):__ Espacio de Banach cuya norma esta definida por un producto interno

# Histogram cross entropy

The distance between H1 and H2 is: $D(H1, H2) = -\sum_i H1_i \log(H2_i)$
