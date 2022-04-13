FROM ubuntu:18.04

LABEL version "0.1"
LABEL description "Play RuneScape in a docker container!"
LABEL homepage "https://github.com/ekapilik/runescape-docker"
LABEL repository "https://github.com/ekapilik/runescape-docker.git"

RUN apt update && apt install -y -qq --no-install-recommends \
    libglvnd0 \
    libgl1 \
    libglx0 \
    libegl1 \
    libxext6 \
    libx11-6

RUN apt update -y && apt install -y \
  gnupg2 \
  wget

RUN wget -O - https://content.runescape.com/downloads/ubuntu/runescape.gpg.key | apt-key add -
RUN mkdir -p /etc/apt/sources.list.d && echo "deb https://content.runescape.com/downloads/ubuntu trusty non-free" > /etc/apt/sources.list.d/runescape.list
RUN apt update -y && apt install -y \
  runescape-launcher
