#/bin/sh

cd /

if [ ! -f /certs/cert.* ]; then
    sh /gen_certs.sh
    cat cert.crt > /certs/cert.crt
    cat cert.key > /certs/cert.key
    rm cert.key cert.crt
fi

python3 autoproxy.py
cat /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"