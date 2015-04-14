#!/bin/sh
exec /sbin/setuser znc-user /usr/local/bin/znc -d /znc -f >> /var/log/znc.log 2>&1

