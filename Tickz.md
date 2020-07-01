
# Sinuzoidal
```latex
\draw[blue] plot[domain=0:16*pi, samples=320] (0.5*\x,{2*sin(\x r)});
```

# Code
\foreach \x in {1,...,5}
{ \node[circle,draw] (\x 1) at (0,\x) {\x};
    \node[circle,draw] (\x 2)at (2,\x) {\x};
    \ifthenelse{\NOT 4 = \x \AND \NOT 7 = \x}{\draw (\x 1) -- (\x 2);}{} % (*)
}

# Arithmetic

# Animation

Warning: First shift then scale
\begin{scope}
    :xshift={ 0s = "\xcm"}
    :line width={ 0s = "10pt"}
    :yshift={ 0s = "0.25cm", 5s= "-0.25cm", 10s = "0.25cm", repeats }
    % First shift then scale
    :xscale={ 0s = "0.05"}
    :yscale={ 0s = "0.05"}
    \drawfishingfloatd
\end{scope}
}

## Draw axes
