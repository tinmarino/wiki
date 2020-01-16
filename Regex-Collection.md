Don't forget to escape \ in java

### Notes
#### Include newline (linebreak) in dot (.) 

1. Pattern.DOTALL
2. (?s)   # "single-line" mode
3. [\s\S]
4. (.|\n) or (.|\n|\r)  # Bad: expensive

Note: (?m) multiline

### Cool

```text
__Ip address:__ ((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.|$)){4}
__C comment:__ r"(?s)(?m)(//.*?$|/\*.*?\*/)"



```
