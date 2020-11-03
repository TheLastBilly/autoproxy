#!/usr/bin/python3

from json import loads
import os

CONFIG_FILE_PATH="/config.json"
NGINX_FILE_PATH="/default.conf"
TEMPLATE_FILE_PATH="/default.conf.template"

raw_json = []
with open(CONFIG_FILE_PATH, "r") as fp:
    raw_json = loads(fp.read())

template_base = ""
with open(TEMPLATE_FILE_PATH, "r") as fp:
    template_base = fp.read()

with open(NGINX_FILE_PATH, "w") as fp:
    fp.write(template_base)

    for entry in raw_json["servers"]:
        fp.write("""

    location /""" f'{entry["path"]}' """{
        proxy_set_header X-Forwarded-Host $host:$server_port;
        proxy_set_header X-Forwarded-Server $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_pass """ f'{entry["url"]}' """;
    }""")
    
    fp.write("\n}\n")