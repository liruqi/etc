server {
	root /srv/http/bill.mumevpn.com/public;
	index index.html index.php;

	server_name bill.mumevpn.com ss.mumevpn.com ss.beijingxi.net;
	error_log  /var/log/nginx/bill.mumevpn.error.log;
	access_log  /var/log/nginx/bill.mumevpn.access.log;

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}

	location / {
        try_files $uri $uri/ /index.php$is_args$args;
	}
}

# for a site generating pac urls
server {
	root /srv/http/pac.liruqi.info;
	index index.html index.php;

	server_name pac.liruqi.info;
	error_log  /var/log/nginx/nav.liruqi.info.error.log;
	access_log  /var/log/nginx/nav.liruqi.info.access.log;

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}
}

server {
	root /srv/http/mume.red;
    listen 443 ssl;
    autoindex on;
	index index.html index.php;

	server_name mume.red www.mume.red mumevpn.com www.mumevpn.com mume.site www.mume.site;

    ssl_certificate /etc/letsencrypt/live/vpn.liruqi.info/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/vpn.liruqi.info/privkey.pem;

	error_log  /var/log/nginx/vpnssl.liruqi.info.error.log;
	access_log  /var/log/nginx/vpnssl.liruqi.info.access.log;

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}
}

server {
    listen 80;
	server_name mume.red www.mume.red mumevpn.com www.mumevpn.com mume.site www.mume.site;
	error_log  /var/log/nginx/vpn.liruqi.info.error.log;
	access_log  /var/log/nginx/vpn.liruqi.info.access.log;
    return 301 https://$host$request_uri;
}

