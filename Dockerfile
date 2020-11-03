FROM nginx:alpine

LABEL maintainer="Jose Ricardo jtmonegro@gmail.com /etc/nginx/conf.d/default.conf"

RUN apk add python3 openssl gettext

COPY ./entrypoint.sh /entrypoint.sh
COPY ./format_nginx_conf.py /format_nginx_conf.py
COPY ./default.conf.template /default.conf.template
COPY ./settings.csr /settings.csr
COPY ./gen_certs.sh /gen_certs.sh

CMD ./entrypoint.sh