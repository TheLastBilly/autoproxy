#!/usr/bin/python3

from json import loads
import os

CONFIG_FILE_PATH="/config.json"
NGINX_FILE_PATH="/etc/nginx/conf.d/default.conf"
LOG_ROOT="/logs/"

raw_json = []
with open(CONFIG_FILE_PATH, "r") as fp:
    raw_json = loads(fp.read())

with open(NGINX_FILE_PATH, "w") as fp:
    domain = raw_json["domain"]

    fp.write("""server {{
    listen 80;
    listen [::]:80;
    server_name {};
    
    return 301 https://$server_name:443$request_uri;
}}
""".format(domain))

    for entry in raw_json["servers"]:
        subdomain = entry["subdomain"]
        url = entry["url"]

        server_name = subdomain+"."+domain

        log_dir = LOG_ROOT + server_name + "/"
        if not os.path.isdir(log_dir):
            os.mkdir(log_dir)

        fp.write("""
server {{
    listen 443 ssl;
    server_name {0};

    ssl_certificate             /certs/cert.crt;
    ssl_certificate_key         /certs/cert.key;

    access_log                  {2};

    location / {{
        proxy_set_header        Host $host;
        
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Forwarded-Proto $scheme;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;

        proxy_pass          {1};
        proxy_read_timeout  90;
    }}
}}
        """.format(server_name, url, log_dir + "access.log"))