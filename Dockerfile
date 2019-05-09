FROM frolvlad/alpine-mono
MAINTAINER Jazy <jazy@jazyserver.com>

# World to run (Per the order on the server output)
ENV DEFAULT_WORLD="0"

RUN set -x \
  && apk --no-cache add screen \
  && mkdir /terraria \
  && cd /terraria \
  && wget -q "https://github.com/Pryaxis/TShock/releases/download/v4.3.26/tshock_4.3.26.zip" \
  && unzip ./* \
  && rm tshock*.zip \
  && mkdir -p /terraria/tshock

COPY config.json /terraria/tshock
COPY sscconfig.json /terraria/tshock
COPY start-terraria-server.sh /

# The start script only works when workdir is terraria for some reason...
WORKDIR /terraria

VOLUME /terraria
EXPOSE 7777

# Assumes that a world was previously made
# Otherwise you must create one manually in this volume
# More info in ./server-cli.sh
CMD ["/bin/sh", "/start-terraria-server.sh"]

