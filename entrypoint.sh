#/bin/sh

cd /

if [ ! -f /certs/cert.* ]; then
    sh /genSslCertificates.sh
    cat cert.crt > /certs/cert.crt
    cat cert.key > /certs/cert.key
fi

python3 autoproxy.py
cat /etc/nginx/conf.d/default.conf

nginx -g "daemon off;"