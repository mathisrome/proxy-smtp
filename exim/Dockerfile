FROM debian:trixie

ARG AUTH_CLIENT_ALLOW_NOTLS_PASSWORDS=true

RUN apt-get update \
    && apt-get install -y exim4 msmtp procps swaks lsof net-tools telnet \
    && rm -rf /var/lib/apt/lists

RUN rm /etc/exim4/update-exim4.conf.conf
COPY config/update-exim4.conf.conf /etc/exim4

RUN rm /etc/exim4/exim4.conf.template
COPY config/exim4.conf.template /etc/exim4

RUN rm /etc/exim4/conf.d/acl/30_exim4-config_check_rcpt
COPY config/conf.d/acl/30_exim4-config_check_rcpt /etc/exim4/conf.d/acl

COPY config/exim4.conf.localmacros /etc/exim4

COPY config/passwd /etc/exim4

COPY config/conf.d/transport/30_exim4-config_remote_smtp_smarthost /ect/exim4/conf.d/transport

RUN update-exim4.conf
EXPOSE 25

ENTRYPOINT ["exim", "-bdf", "-q15m"]