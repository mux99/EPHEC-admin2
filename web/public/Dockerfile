# Dockerfile for lighttpd

FROM alpine

ENV LIGHTTPD_VERSION=1.4.70-r0

RUN apk add --update --no-cache \
	lighttpd=${LIGHTTPD_VERSION} \
	lighttpd-mod_auth \
	openssl \
	php81 \
	php81-cgi \
	php81-mysqli \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/localhost/htdocs/b2b \
	&& mkdir -p /var/www/localhost/htdocs/www \
	&& mkdir -p /etc/lighttpd/vhosts.d \
	&& mkdir /var/run/lighttpd \
	&& touch /var/run/lighttpd/lighttpd-fastcgi-php.socket \
	&& chown -R lighttpd:lighttpd /var/run/lighttpd
#&& openssl req -x509 -nodes -days 365 \
#    -subj  "/C=CA/ST=QC/O=Company Inc/CN=www.m2-7.ephec-ti.be" \
#     -newkey rsa:2048 -keyout /etc/ssl/private/lighttpd-selfsigned.key \
#     -out /etc/ssl/certs/lighttpd-selfsigned.crt;
RUN echo 'cgi.fix_pathinfo=1' >> /etc/php81/php.ini

COPY conf/* /etc/lighttpd/
COPY vhosts.d/* /etc/lighttpd/vhosts.d/
COPY start.sh /usr/local/bin/
COPY index.html /var/www/localhost/htdocs/www/
COPY index.php /var/www/localhost/htdocs/b2b/

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd

CMD ["start.sh"]
