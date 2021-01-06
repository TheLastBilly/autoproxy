FROM nginx:alpine

LABEL maintainer="Jose Ricardo jtmonegro@gmail.com /etc/nginx/conf.d/default.conf"

RUN apk add python3 openssl gettext

COPY ./entrypoint.sh /entrypoint.sh

COPY ./autoproxy.py /autoproxy.py
COPY ./config.json /config.json

COPY ./settings.csr /settings.csr
COPY ./gen_certs.sh /gen_certs.sh

RUN mkdir /certs
RUN mkdir /logs

CMD ./entrypoint.sh