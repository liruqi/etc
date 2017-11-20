server {
	root /srv/http/ohlinux.com;
	index index.html index.php;
	server_name ohlinux.com www.ohlinux.com;


  if (!-e $request_filename) {
            rewrite ^(.*)$ /index.php$1 last;
        }
 
  location ~ .*\.php(\/.*)*$ {
            include fastcgi_params;
            fastcgi_pass  127.0.0.1:9000;
        }

#	location ~ \.php$ {
#		fastcgi_split_path_info ^(.+\.php)(/.+)$;
#		fastcgi_pass 127.0.0.1:9000;
#		fastcgi_index index.php;
#		include fastcgi_params;
#	}
    #if (!-e $request_filename){
    #    rewrite ^/ /index.php?r=$1;
    #}
    access_log  /srv/http/ohlinux.com/ns.access.log;
    error_log  /srv/http/ohlinux.com/ns.error.log;
}
