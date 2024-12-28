https://us-east-2.console.aws.amazon.com/console/home?nc2=h_ct&region=us-east-2&src=header-signin#


nohup sh -c 'while true; do { echo -ne "HTTP/1.1 200 OK\r\nContent-Length: $(echo -n "Hello, World!")\r\n\r\nHello, World!"; } | nc -l -p 80; done' > server.log 2>&1 &


nohup bash -c 'set +H; while true; do { echo -ne "HTTP/1.1 200 OK\r\nContent-Length: 21\r\n\r\nHello from LLaitun!\r\n"; } | sudo nc -l -p 80; done'
