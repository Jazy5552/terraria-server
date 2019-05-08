FROM frolvlad/alpine-mono
MAINTAINER Jazy <jazy@jazyserver.com>

RUN set -x \
  && mkdir /terraria \
  && cd /terraria \
  && wget -q "https://github.com/Pryaxis/TShock/releases/download/v4.3.26/tshock_4.3.26.zip" \
  && unzip ./* \
  && rm tshock*.zip \
  && mkdir -p /terraria/tshock

COPY config.json /terraria/tshock
COPY sscconfig.json /terraria/tshock

# The start script only works when workdir is terraria for some reason...
WORKDIR /terraria
# Following nonsense is because of the way TerrariaServer.exe starts up...
RUN echo " \
  { sleep 10; echo '1'; \
  sleep 3; echo -e '\n'; \
  sleep 3; echo -e '\n'; \
  sleep 3; echo -e '\n'; \
  sleep 3; echo -e '\n'; \
  } \
  | mono /terraria/TerrariaServer.exe -worldpath /terraria/worlds" \
  > /start-terraria-server.sh

VOLUME /terraria
EXPOSE 7777

# Assumes that a world was previously made
# Otherwise you must create one manually in this volume
CMD ["/bin/sh", "/start-terraria-server.sh"]

