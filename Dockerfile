FROM ubuntu:14.04

MAINTAINER Kai Mallea <kmallea@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update &&\
    apt-get install -y curl lib32gcc1

RUN useradd -ms /bin/bash steamuser
ENV HOME /home/steamuser
USER steamuser

# Download and extract SteamCMD
RUN mkdir -p /home/steamuser/steamcmd && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C /home/steamuser/steamcmd -zx 

RUN echo 'login anonymous\nforce_install_dir ../csgo_ds\napp_update 740 validate\nquit' > /home/steamuser/steamcmd/install.txt
ONBUILD RUN ./steamcmd.sh +runscript install.txt
