FROM ubuntu:14.04

MAINTAINER Roger Lam <mrlamroger@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN apt-get update &&\
    apt-get install -y curl lib32gcc1

RUN useradd -ms /bin/bash steamuser
RUN passwd -d steamuser
ENV HOME /home/steamuser
USER steamuser
WORKDIR /home/steamuser

# Download and extract SteamCMD
RUN mkdir -p /home/steamuser/steamcmd && \
    curl -s http://media.steampowered.com/installer/steamcmd_linux.tar.gz | tar -v -C /home/steamuser/steamcmd -zx

WORKDIR /home/steamuser/steamcmd

RUN printf "login anonymous\nforce_install_dir ../csgo\napp_update 740 validate\nquit" > /home/steamuser/steamcmd/install.txt
RUN ./steamcmd.sh +runscript install.txt
