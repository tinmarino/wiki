

```bash
sudo nmap -vvv -T4 -F scanme.nmap.org
sudo nmap -A -T4 -p- --script=vulners,default --min-rate 1000 -Pn -n -v scanme.nmap.org
```

# Options

-sS
-sV
-A
-Pn
-p21,22,23,25,80,443,53,1433,3389,389,8080,8081,10443,22022
-iL list-of-port.txt

# NSE Scripts Highlight

ssl-enum-ciphers  #  Find broken TLS configuration (server may authorise them)
my-sql-enum   # Enumerate user on a mysql database
