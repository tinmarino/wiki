Don't forget to escape \ in java

### Notes
#### Include newline (linebreak) in dot (.) 

1. Pattern.DOTALL
2. (?s)   # "single-line" mode
3. [\s\S]
4. (.|\n) or (.|\n|\r)  # Bad: expensive

Note: (?m) multiline

#### Some unfamous atoms

* `\p{L}` which means "any Unicode letter" good substitution for `[a-zA-Z]` or `[[:alpha:]]`


### Cool

* __Ip address:__ `((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\\.|$)){4}`
* __Ipv6:__ `(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))`
* __C comment:__ `(?s)(?m)(//.*?$|/\*.*?\*/)`
* __Email address:__ `\b\S+@\S+\.\S+\b`



### IPV6

```perl
my $r_ipv6 = qr/
  ([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|          # 1:2:3:4:5:6:7:8
  ([0-9a-fA-F]{1,4}:){1,7}:|                         # 1::                              1:2:3:4:5:6:7::
  ([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|         # 1::8             1:2:3:4:5:6::8  1:2:3:4:5:6::8
  ([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|  # 1::7:8           1:2:3:4:5::7:8  1:2:3:4:5::8
  ([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|  # 1::6:7:8         1:2:3:4::6:7:8  1:2:3:4::8
  ([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|  # 1::5:6:7:8       1:2:3::5:6:7:8  1:2:3::8
  ([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|  # 1::4:5:6:7:8     1:2::4:5:6:7:8  1:2::8
  [0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|       # 1::3:4:5:6:7:8   1::3:4:5:6:7:8  1::8  
  :((:[0-9a-fA-F]{1,4}){1,7}|:)|                     # ::2:3:4:5:6:7:8  ::2:3:4:5:6:7:8 ::8       ::     
  fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|     # fe80::7:8%eth0   fe80::7:8%1     (link-local IPv6 addresses with zone index)
  ::(ffff(:0{1,4}){0,1}:){0,1}
  ((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
  (25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|          # ::255.255.255.255   ::ffff:255.255.255.255  ::ffff:0:255.255.255.255  (IPv4-mapped IPv6 addresses and IPv4-translated addresses)
  ([0-9a-fA-F]{1,4}:){1,4}:
  ((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}
  (25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])           # 2001:db8:3:4::192.0.2.33  64:ff9b::192.0.2.33 (IPv4-Embedded IPv6 Address)
  /x;
```


### Email

From: https://stackoverflow.com/questions/201323/how-to-validate-an-email-address-using-a-regular-expression

```text
/^\S+@\S+\.\S+$/
```

```text
\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*
```

```text
[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*
```

```text
(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])
```

```perl
/(?(DEFINE)
   (?<address>         (?&mailbox) | (?&group))
   (?<mailbox>         (?&name_addr) | (?&addr_spec))
   (?<name_addr>       (?&display_name)? (?&angle_addr))
   (?<angle_addr>      (?&CFWS)? < (?&addr_spec) > (?&CFWS)?)
   (?<group>           (?&display_name) : (?:(?&mailbox_list) | (?&CFWS))? ;
                                          (?&CFWS)?)
   (?<display_name>    (?&phrase))
   (?<mailbox_list>    (?&mailbox) (?: , (?&mailbox))*)

   (?<addr_spec>       (?&local_part) \@ (?&domain))
   (?<local_part>      (?&dot_atom) | (?&quoted_string))
   (?<domain>          (?&dot_atom) | (?&domain_literal))
   (?<domain_literal>  (?&CFWS)? \[ (?: (?&FWS)? (?&dcontent))* (?&FWS)?
                                 \] (?&CFWS)?)
   (?<dcontent>        (?&dtext) | (?&quoted_pair))
   (?<dtext>           (?&NO_WS_CTL) | [\x21-\x5a\x5e-\x7e])

   (?<atext>           (?&ALPHA) | (?&DIGIT) | [!\#\$%&'*+-\/=?^_`{|}~])
   (?<atom>            (?&CFWS)? (?&atext)+ (?&CFWS)?)
   (?<dot_atom>        (?&CFWS)? (?&dot_atom_text) (?&CFWS)?)
   (?<dot_atom_text>   (?&atext)+ (?: \. (?&atext)+)*)

   (?<text>            [\x01-\x09\x0b\x0c\x0e-\x7f])
   (?<quoted_pair>     \\ (?&text))

   (?<qtext>           (?&NO_WS_CTL) | [\x21\x23-\x5b\x5d-\x7e])
   (?<qcontent>        (?&qtext) | (?&quoted_pair))
   (?<quoted_string>   (?&CFWS)? (?&DQUOTE) (?:(?&FWS)? (?&qcontent))*
                        (?&FWS)? (?&DQUOTE) (?&CFWS)?)

   (?<word>            (?&atom) | (?&quoted_string))
   (?<phrase>          (?&word)+)

   # Folding white space
   (?<FWS>             (?: (?&WSP)* (?&CRLF))? (?&WSP)+)
   (?<ctext>           (?&NO_WS_CTL) | [\x21-\x27\x2a-\x5b\x5d-\x7e])
   (?<ccontent>        (?&ctext) | (?&quoted_pair) | (?&comment))
   (?<comment>         \( (?: (?&FWS)? (?&ccontent))* (?&FWS)? \) )
   (?<CFWS>            (?: (?&FWS)? (?&comment))*
                       (?: (?:(?&FWS)? (?&comment)) | (?&FWS)))

   # No whitespace control
   (?<NO_WS_CTL>       [\x01-\x08\x0b\x0c\x0e-\x1f\x7f])

   (?<ALPHA>           [A-Za-z])
   (?<DIGIT>           [0-9])
   (?<CRLF>            \x0d \x0a)
   (?<DQUOTE>          ")
   (?<WSP>             [\x20\x09])
 )

 (?&address)/x
```

### Links



