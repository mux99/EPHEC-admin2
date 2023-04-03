# Dockerfile for lighttpd

FROM alpine

ENV LIGHTTPD_VERSION=1.4.67-r0

RUN apk add --update --no-cache \
	lighttpd=${LIGHTTPD_VERSION} \
	lighttpd-mod_auth \
	php81 \
	php81-cgi \
  && rm -rf /var/cache/apk/*

RUN mkdir -p /var/www/localhost/htdocs/b2b \
	&& mkdir -p /var/www/localhost/htdocs/intranet \
	&& mkdir -p /etc/lighttpd/vhosts.d \
	&& mkdir /var/run/lighttpd \
	&& touch /var/run/lighttpd/lighttpd-fastcgi-php.socket \
	&& chown -R lighttpd:lighttpd /var/run/lighttpd
COPY conf/* /etc/lighttpd/
COPY vhosts.d/* /etc/lighttpd/vhosts.d/
COPY start.sh /usr/local/bin/
COPY test.html /var/www/localhost/htdocs/b2b/
COPY test.php /var/www/localhost/htdocs/intranet/

EXPOSE 80

VOLUME /var/www/localhost/htdocs
VOLUME /etc/lighttpd

CMD ["start.sh"]
