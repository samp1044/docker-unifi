FROM ubuntu:latest

ENV UNIFI_GID=999 \
    UNIFI_UID=999

RUN \
  echo "**** install packages ****" && \
  apt-get update && \
  apt-get install -y \
    binutils \
    jsvc \
    libcap2 \
    logrotate \
    openjdk-17-jre-headless \
    gnupg \
    wget \
    ca-certificates \
    apt-transport-https

# https://www.mongodb.com/docs/v4.4/tutorial/install-mongodb-on-ubuntu/
# unifi seems to allow < 5.0.0 so the oldest still supported version of mongo gets installed (4.4)
# also mongodb 4.4 needs libgen1.1 wich of course does not exist in 22.04 -> https://gist.github.com/joulgs/c8a85bb462f48ffc2044dd878ecaa786
RUN echo "**** install mongodb 4.4 ****" && \
  wget http://ports.ubuntu.com/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_arm64.deb && \
  dpkg -i libssl1.1_1.1.1f-1ubuntu2_arm64.deb && \
  wget -qO - https://pgp.mongodb.com/server-4.4.asc | apt-key add - && \
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
  apt-get update && apt-get install mongodb-org -y

# From https://help.ui.com/hc/en-us/articles/360012282453-Self-Hosting-a-UniFi-Network-Server -> https://help.ui.com/hc/en-us/articles/220066768
RUN  echo "**** install unifi ****" && \
  echo "deb [ arch=amd64 ] https://www.ui.com/downloads/unifi/debian stable ubiquiti" | tee /etc/apt/sources.list.d/100-ubnt-unifi.list && \
  wget -O /etc/apt/trusted.gpg.d/unifi-repo.gpg https://dl.ui.com/unifi/unifi-repo.gpg && \
  apt-get update && apt-get install unifi -y

RUN mkdir -p /app

EXPOSE 8080 8443 8843 8880
EXPOSE 3478/udp 10001/udp

ADD ./start.sh ./start.sh
RUN chmod a+x start.sh
