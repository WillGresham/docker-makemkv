FROM ubuntu:18.04
ARG makemkv_version

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt install -y build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev zlib1g-dev

WORKDIR /opt/makemkv
RUN apt install -y wget
RUN wget http://www.makemkv.com/download/makemkv-bin-"$makemkv_version".tar.gz
RUN wget http://www.makemkv.com/download/makemkv-oss-"$makemkv_version".tar.gz

RUN tar -xf makemkv-bin-"$makemkv_version".tar.gz
RUN tar -xf makemkv-oss-"$makemkv_version".tar.gz

WORKDIR makemkv-oss-"$makemkv_version"
RUN ./configure
RUN make
RUN make install

WORKDIR ../makemkv-bin-"$makemkv_version"
COPY bin-makefile Makefile
RUN make
RUN make install

WORKDIR /
RUN mkdir iso_in
RUN mkdir iso_out
COPY makemkv.sh makemkv.sh

CMD bash /makemkv.sh
#CMD makemkvcon --minlength=1 mkv file:/iso_in 1 /iso_out
