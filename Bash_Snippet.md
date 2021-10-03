```bash
ssh -t  mtourneb@acse2-gns.sco.alma.cl bash --noprofile --norc
randArrayElement(){ a=("$@"); echo ${a["$[RANDOM % ${#@}]"]}; };
```
