## >
On `my name is toto`

* `<?toto>` zero lenght `<?nn> me` -> `｢me｣`
* `<(` and `)>` : start ant end of match
* `<?>` Always match : succesfully math null string
* `<!>` Always fail


```raku
say 'abc' ~~ / a <( b )> c/;            # OUTPUT: «｢b｣␤» 
say 'abc' ~~ / <(a <( b )> c)>/;        # OUTPUT: «｢bc｣␤»
```

### Backtrack

* `a*!` Greedy (default `a*`)
* `a*?` Frugal (alias: minimal or non-greedy)
* `a*:` Ratchet (alias: non-backtracking)
* `a ** 1..10` Numbered quantifier

### | Vs ||

* || is the alteration sequence, try from first to last
* | is Longest Token Matching alteration, goes for the branch with logest matching first
