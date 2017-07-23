#!/bin/bash
set -eo pipefail

# enable rsyslog daemon so that SSHD log file is created
rsyslogd

USER=ec2-user
VOLUME=/home/ec2-user/
chown -R $USER: $VOLUME

# regenerate the /etc/ssh/*keys
/usr/bin/ssh-keygen -A

# start SSH daemon
/usr/sbin/sshd -D
