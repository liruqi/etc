server {
	root /srv/http/tenfar.com;
	index index.html index.php;

	server_name tenfar.com;
	server_name www.tenfar.com;

	# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
	#
	location / {
		try_files $uri $uri/ /index.php?filename=$uri;
	}

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
	#	# NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
	#	# With php5-cgi alone:
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}

}
