#!/bin/sh
exec /sbin/setuser znc-user /usr/local/bin/znc -d /var/znc -f >> /var/log/znc.log 2>&1

