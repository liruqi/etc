server {
	root /srv/http/api.liruqi.info;
	listen       80;
	listen 443 ssl;
	index index.html index.php;
	autoindex on;
	server_name api.liruqi.info api.mume.red;
	error_log  /var/log/nginx/api.error.log;
	access_log  /var/log/nginx/api.access.log;

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:1987;
		fastcgi_index index.php;
		include fastcgi_params;
	}

ssl_certificate /etc/letsencrypt/live/api.liruqi.info/fullchain.pem; # managed by Certbot
ssl_certificate_key /etc/letsencrypt/live/api.liruqi.info/privkey.pem; # managed by Certbot


    if ($scheme != "https") {
        return 301 https://$host$request_uri;
    } # managed by Certbot


    # Redirect non-https traffic to https
    # if ($scheme != "https") {
    #     return 301 https://$host$request_uri;
    # } # managed by Certbot

}
