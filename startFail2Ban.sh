#!/bin/bash
FILE=/var/log/vaultwarden.log
end=$((SECONDS+60))

while [ $SECONDS -lt $end ]; do
	echo "$SECONDS: Waiting for vaultwarden logfile to appear"
	if test -f "$FILE"; then
		sleep 5
		echo "logfile found, start service fail2ban"
		service fail2ban start
	fi
done