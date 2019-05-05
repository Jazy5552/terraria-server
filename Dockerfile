FROM frolvlad/alpine-mono
MAINTAINER Jazy <jazy@jazyserver.com>

RUN set -x \
  && mkdir /terraria \
  && cd /terraria \
  && wget -q "https://github.com/Pryaxis/TShock/releases/download/v4.3.26/tshock_4.3.26.zip" \
  && unzip ./* \
  && rm tshock*.zip

VOLUME /terraria
EXPOSE 7777

# Assumes that a world was previously made
# Otherwise you must create one manually in this volume
CMD ["mono", "/terraria/TerrariaServer.exe", "-worldpath", "/terraria/worlds", "-world", "/terraria/worlds/*.wld"]
