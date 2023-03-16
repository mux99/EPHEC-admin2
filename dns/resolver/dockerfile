FROM ubuntu:latest
    
RUN apt update && \
    apt install -y --no-install-recommends \
        wget \
        bind9 \
        bind9utils \
        bind9-doc \
        dnsutils

RUN wget --user=ftp --password=ftp ftp://ftp.rs.internic.net/domain/db.cache -O /etc/bind/db.root

COPY named.conf /etc/bind/

EXPOSE 53/udp

CMD ["named", "-g"]
