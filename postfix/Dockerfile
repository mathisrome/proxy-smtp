FROM debian:trixie

RUN apt-get update \
    && apt-get install -y postfix msmtp procps supervisor \
    && rm -rf /var/lib/apt/lists

WORKDIR /postfix

COPY ./postfix-apps/.msmtprc .msmtprc
COPY postfix-apps /etc/postfix-apps
COPY ./supervisor/supervisord.conf /etc/supervisord.conf

RUN mkdir -p /var/log/postfix \
    && mkdir -p /var/spool/postfix-projets/pid \
    && mkdir -p /var/spool/postfix-saisie-temps/pid \
    && mkdir -p /var/lib/postfix-projets \
    && mkdir -p /var/lib/postfix-saisie-temps \
    && chown -R postfix:postfix /var/spool/postfix-* \
    && chown -R postfix:postfix /var/lib/postfix-*

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]