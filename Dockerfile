FROM ubuntu-upstart

ADD ./sleep.conf  /etc/init/sleep.conf
#RUN sudo initctl reload-configuration