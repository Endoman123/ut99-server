FROM debian:buster-slim

LABEL author="Jared Tulayan" maintainer="jared@jaredtulayan.xyz"

# Prepare the system
RUN dpkg --add-architecture i386 \
    && apt update \
    && apt upgrade -y \
    && apt install -y curl wget file tar bzip2 gzip unzip bsdmainutils python3 util-linux ca-certificates locales binutils bc jq tmux netcat lib32gcc1 lib32stdc++6 \
    && update-locale lang=en_US.UTF-8 \
    && dpkg-reconfigure --frontend noninteractive locales \
    && useradd -m -d /home/container -s /bin/bash container

# Create a link of this file to the missing file
RUN ln -s /ut-server/System/libSDL-1.1.so.0 /ut-server/System/libSDL-1.2.so.0

USER        container
ENV         USER=container HOME=/home/container
ENV         DEBIAN_FRONTEND noninteractive

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         [ "/bin/bash", "/entrypoint.sh" ]
