FROM debian:trixie

RUN apt-get update \
    && apt-get install -y exim4 msmtp procps \
    && rm -rf /var/lib/apt/lists

RUN rm /etc/exim4/exim4.conf.template /etc/exim4/update-exim4.conf.conf
COPY config/exim4.conf.template /etc/exim4/
COPY config/update-exim4.conf.conf /etc/exim4/
COPY config/relay_map /etc/exim4/
COPY config/transport_map /etc/exim4/

ENTRYPOINT ["exim", "-bdf", "-q15m"]