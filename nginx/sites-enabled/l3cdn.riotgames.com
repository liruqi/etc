server {
	server_name  l3cdn.riotgames.com;

	location / {
		proxy_set_header  X-Real-IP  $remote_addr;
		proxy_pass  http://l3cdn.riotgames.com;
	}
    
    	access_log  /tmp/l3cdn.riotgames.com_access.log;
    	error_log  /tmp/l3cdn.riotgames.com_error.log;
}

