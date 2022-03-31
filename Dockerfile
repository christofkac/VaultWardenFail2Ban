#according tutorial from https://www.schreiner.pro/?p=627
FROM vaultwarden/server:1.24.0
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends \
 fail2ban \
 && rm -rf /var/lib/apt/lists/*

#WORKDIR /etc/fail2ban
COPY jail.d /etc/fail2ban/jail.d/
COPY filter.d /etc/fail2ban/filter.d/
COPY action.d /etc/fail2ban/action.d/
RUN cat /etc/fail2ban/action.d/iptables-allports_extension.conf >> /etc/fail2ban/action.d/iptables-allports.conf
RUN rm /etc/fail2ban/action.d/iptables-allports_extension.conf
RUN rm /etc/fail2ban/jail.d/defaults-debian.conf
CMD service fail2ban start
#
# Run startup-script
#ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#CMD ["/start.sh"]

