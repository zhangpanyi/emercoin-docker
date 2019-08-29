FROM frolvlad/alpine-glibc

RUN apk add --no-cache --virtual build-dependencies --update wget curl bash ca-certificates

RUN wget -P /tmp wget https://github.com/$( \
    curl -L https://github.com/emercoin/emercoin/releases/latest | \
    egrep -o '/emercoin/emercoin/releases/download/v(.+)emc/emercoin-(.+)-x86_64-linux-gnu.tar.gz')
RUN cd /tmp && tar -zxvf $(ls | egrep -o 'emercoin-(.*)-linux-gnu.tar.gz') -C / \
    && cd / && mv $(ls | egrep -o 'emercoin-(.*)') emercoin \
    && chmod +x /emercoin/bin/*
RUN apk del build-dependencies
RUN rm -rf /tmp/*

EXPOSE 6661
EXPOSE 6662
EXPOSE 6664

WORKDIR /emercoin