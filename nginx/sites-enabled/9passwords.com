server {
	root /srv/http/9passwords;
	index index.html index.php;
    autoindex  on;
	server_name 9passwords.liruqi.info 9passwords.com;

    error_log  /var/log/nginx/9passwords.error.log;
    access_log  /var/log/nginx/9passwords.access.log;

    location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}
}
