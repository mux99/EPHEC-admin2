# Dockerfile for lighttpd

FROM alpine

ENV LIGHTTPD_VERSION=1.4.70-r0

RUN apk add --update --no-cache \
	lighttpd=${LIGHTTPD_VERSION} \
	lighttpd-mod_auth \
	openssl \
  && rm -rf /var/cache/apk/*
#&& openssl req -x509 -nodes -days 365 \
#    -subj  "/C=CA/ST=QC/O=Company Inc/CN=www.m2-7.ephec-ti.be" \
#     -newkey rsa:2048 -keyout /etc/ssl/private/lighttpd-selfsigned.key \
#     -out /etc/ssl/certs/lighttpd-selfsigned.crt;

COPY conf/* /etc/lighttpd/
COPY start.sh /usr/local/bin/
COPY test.html /var/www/localhost/htdocs/

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd

CMD ["start.sh"]
