FROM vaultwarden/server:1.24.0
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends \
 fail2ban \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /etc/fail2ban
COPY jail.d jail.d/
COPY filter.d filter.d/
COPY action.d action.d/
RUN cat action.d/iptables-allports_extension.conf >> action.d/iptables-allports.conf
RUN rm action.d/iptables-allports_extension.conf

# Run startup-script
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/start.sh"]

