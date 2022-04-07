FROM python:3-bullseye
LABEL maintainer="tskulbru"

WORKDIR /tmp/workdir

RUN apt-get update -yqq && \
  apt-get install -yq ffmpeg x264 x265 bc jq mediainfo && \
  apt-get autoremove -y && \
  apt-get clean -y
RUN wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/libmp4v2-2_2.0.0~dfsg0-6_amd64.deb && \
  wget http://archive.ubuntu.com/ubuntu/pool/universe/m/mp4v2/mp4v2-utils_2.0.0~dfsg0-6_amd64.deb && \
  dpkg -i libmp4v2-2_2.0.0~dfsg0-6_amd64.deb && \
  dpkg -i mp4v2-utils_2.0.0~dfsg0-6_amd64.deb
RUN pip install --no-cache-dir --upgrade audible-cli

RUN \
  DIR=/tmp/aax && \
  mkdir -p ${DIR} && \
  cd ${DIR} && \
  git clone https://github.com/KrumpetPirate/AAXtoMP3.git && \
  cd AAXtoMP3 && \
  chmod +x AAXtoMP3 && \
  cp AAXtoMP3 /usr/local/bin && \
  rm -rf ${DIR}
RUN \
  mkdir /app && \
  mkdir /config && \
  mkdir /storage && \
  mkdir /backup && \
  mkdir /data

COPY ./entrypoint.sh /app

ENV AUDIBLE_CONFIG_DIR="/config"
ENV BOOK_TITLES=
ENV AUTHCODE=

VOLUME ["/config"]
VOLUME ["/storage"]
VOLUME ["/backup"]

WORKDIR /app
CMD [ "/app/entrypoint.sh" ]
