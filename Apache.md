Below is an .htaccess sample configuration which sets the X-Frame-Options header in Apache. Note that without the always option, the header will only be sent for certain status codes, as described in the Apache documentation.

https://httpd.apache.org/docs/2.4/mod/mod_headers.html#header

<IfModule mod_headers.c>
Header always set X-Frame-Options "DENY"
</IfModule>
