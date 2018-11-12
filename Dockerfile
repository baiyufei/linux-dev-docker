FROM ubuntu:16.04
LABEL MAINTAINER=baiyufei@outlook.com

## install basic tools
COPY sources.list /etc/apt/sources.list
RUN mkdir -p /var/run/sshd
RUN apt-get update && apt-get install -y openssh-server vim tar git wget curl \
    rsync bzip2 iptables tcpdump less telnet net-tools lsof sysstat cron \
    supervisor inetutils-ping tzdata gcc g++ build-essential autoconf automake libtool

## config ssh service: change port to 2200
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/Port 22/Port 2200/' /etc/ssh/sshd_config
COPY sshd.conf /etc/supervisor/conf.d/sshd.conf

## config timezone
RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

CMD ["/usr/bin/supervisord"]
