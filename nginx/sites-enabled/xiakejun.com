
server {
	server_name xiakejun.com www.xiakejun.com kj.liruqi.info;
	root /srv/http/xiakejun.com;

	index index.php;

	# Additional rules go here.

	location / {
		try_files $uri $uri/ /index.php?$args;
	}


# Directives to send expires headers and turn off 404 error logging.
	location ~* ^.+\.(ogg|ogv|svg|svgz|eot|otf|woff|mp4|ttf|rss|atom|jpg|jpeg|gif|png|ico|zip|tgz|gz|rar|bz2|doc|xls|exe|ppt|tar|mid|midi|wav|bmp|rtf)$ {
		access_log off; log_not_found off; expires max;
	}

# Pass all .php files onto a php-fpm/php-fcgi server.
	location ~ [^/]\.php(/|$) {
		fastcgi_split_path_info ^(.+?\.php)(/.*)$;
		if (!-f $document_root$fastcgi_script_name) {
			return 404;
		}
# This is a robust solution for path info security issue and works with "cgi.fix_pathinfo = 1" in /etc/php.ini (default)

		fastcgi_pass 127.0.0.1:9000;
		include fastcgi_params;

		fastcgi_index index.php;
#	fastcgi_intercept_errors on;
	}	
}
