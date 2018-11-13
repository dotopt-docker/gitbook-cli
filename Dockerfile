FROM node:11.1-alpine
LABEL maintainer="wuxingzhong <wuxingzhong@sunniwell.net>"

ARG VERSION=3.2.3

LABEL version=$VERSION

RUN apk add --no-cache git python \
	&& npm install -g gitbook-cli \
	&& gitbook fetch ${VERSION} \
	&& wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh |  sh /dev/stdin \
	&& npm cache clear  --force \
	&& rm -rf /tmp/* \ 


WORKDIR /srv/gitbook

VOLUME /srv/gitbook /srv/html

EXPOSE 4000 35729

CMD /usr/local/bin/gitbook serve
