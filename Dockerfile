FROM nginx:alpine

LABEL maintainer="Jose Ricardo jtmonegro@gmail.com /etc/nginx/conf.d/default.conf"

RUN apk add python3 openssl gettext
RUN rm -rf /tmp/* /var/cache/apk/* /var/tmp/*

COPY ./entrypoint.sh /entrypoint.sh

COPY ./autoproxy.py /autoproxy.py
COPY ./config.json /config.json

COPY ./settings.csr /settings.csr
COPY ./genSslCertificates.sh /genSslCertificates.sh

RUN mkdir /certs
RUN mkdir /logs

CMD ./entrypoint.sh