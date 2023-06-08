
# Quickstart

```bash
sudo apt install cabal-install

mkdir Test && ce Test

cabal init # Start Hello project
cabal run  # Print Hello Haskell

cabal v2-repl  # Get REPL
```

# Syntax

```haskell
-- Single line comment
{- Multiple line comment -}
```

### Function

```haskell
addInt (a,b) = a + b
addInt a b = a + b
incr = addInt 1
incr 10
(incr . incr) 10

-- List
[1] ++ [2]  -- Concatenate
take 10 [1..]
map (+1) [1..10]
filter even [1..10]

-- Type
type Id = Int
type Dob = (Int, Int, Int)



```

LHS: Literal Haskell

Add > for code line

# Notes

Functions have only one input but this can be a tupple
There is no state, no variable, so think about linked list when speaking about array
It is a lazy language, all list are generators

Haskell stole its language from Mathematic. Ths good point is that Math is an old science so syntax is developed

Haskell has type infrence so the type declaration on functions is just for documentation


