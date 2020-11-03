#!/bin/bash

openssl req -config settings.csr -new -newkey rsa:2048 -nodes -keyout cert.key -out cert.csr
openssl x509 -req -days 365 -in cert.csr -signkey cert.key -out cert.crt