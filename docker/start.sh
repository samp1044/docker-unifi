#! /bin/bash

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
chown -R unifi:unifi /var/lib/unifi /var/log/unifi /var/run/unifi
service unifi start

echo "this script just runs forever."
tail -f /dev/null
