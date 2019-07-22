FROM debian:latest

MAINTAINER Honza Hommer <honza@hommer.cz>

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && \
    apt-get -y install lighttpd apcupsd-cgi

RUN apt-get -y autoremove && \
    apt-get clean all && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -s /etc/lighttpd/conf-available/*-accesslog.conf /etc/lighttpd/conf-enabled/ && \
    ln -s /etc/lighttpd/conf-available/*-cgi.conf /etc/lighttpd/conf-enabled/

RUN sed -i 's|/cgi-bin/|/|g' /etc/lighttpd/conf-enabled/*-cgi.conf && \
    sed -i 's|^\(server.document-root.*=\).*|\1 "/usr/lib/cgi-bin/apcupsd"|g' /etc/lighttpd/lighttpd.conf && \
    sed -i 's|^\(index-file.names.*=\).*|\1 ( "multimon.cgi" )|g' /etc/lighttpd/lighttpd.conf

EXPOSE 80

ENTRYPOINT ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
