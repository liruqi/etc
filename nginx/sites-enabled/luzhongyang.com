server {
	root /srv/http/luzhongyang.com;
	index index.html index.php;

	server_name luzhongyang.com;
	error_log  /var/log/nginx/luzhongyang.com.error.log;

        location / {
            index index.html index.php;
            if (-f $request_filename/index.html){
                rewrite (.*) $1/index.html break;
            }
            if (-f $request_filename/index.php){
                rewrite (.*) $1/index.php;
            }
            if (!-f $request_filename){
                rewrite (.*) /index.php;
            }
        }

	location ~ \.php$ {
		fastcgi_split_path_info ^(.+\.php)(/.+)$;
		fastcgi_pass 127.0.0.1:9000;
		fastcgi_index index.php;
		include fastcgi_params;
	}

}
