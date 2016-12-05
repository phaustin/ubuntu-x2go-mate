FROM ubuntu:16.04
MAINTAINER Phil Austin "paustin@eos.ubc.ca"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install software-properties-common -y

RUN apt-add-repository ppa:ubuntu-mate-dev/xenial-mate
RUN apt dist-upgrade

RUN apt-get update

RUN apt-get install openssh-server -y
RUN apt-get install ubuntu-mate-core -y
#RUN apt-get install ubuntu-mate-desktop-environment -y
#RUN apt-get install x2goserver x2goserver-xsession pwgen -y
#RUN apt-get install x2gomatebindings -y

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

RUN mkdir /var/run/dbus

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22

CMD ["/run.sh"]
