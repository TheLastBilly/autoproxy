#/bin/sh

cd /

if [ -f /certs/recreate ]; then
    sh /gen_certs.sh
    cat cert.crt > /certs/cert.crt
    cat cert.key > /certs/cert.key
    rm cert.key cert.crt
    mv /certs/recreate /certs/recreate.done
fi

python3 format_nginx_conf.py
envsubst '${NGINX_HOSTNAME}' < "/default.conf" > /etc/nginx/conf.d/default.conf
cat /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"