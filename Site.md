My Site tinmarino.com



1. GoDaddy to register DNS, 25 dollars for 3 years, redireciona a cloudflare
2. Cloudflare to proxy
    * earl.ns.cloudflare.com
3. AWS to host ctfd, ot github for website and root



sudo iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 4000

tinmarino.github.io
tinmarino.com
