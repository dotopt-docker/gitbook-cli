FROM node:11
LABEL maintainer="wuxingzhong <wuxingzhong@sunniwell.net>"

ARG VERSION=3.2.3
LABEL version=$VERSION

ADD simsun.ttc /usr/share/fonts/truetype/simsun.ttc
 
RUN set -x  \
    && sed  -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
	&& apt-get update \
	&& BUILD_DEPS=" \
		chromium  \
		chromium-l10n \
		wget \
		git \
		python \
	" \
	&& apt-get install --no-install-recommends --no-install-suggests -y $BUILD_DEPS \
	&& npm install -g cnpm --registry=https://registry.npm.taobao.org \
	&& cnpm install -g mermaid.cli  \
	&& cnpm install -g gitbook-cli \
	&& gitbook fetch ${VERSION} \
	&& wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh |  sh /dev/stdin \
	&& npm cache clear  --force \
	&& rm -rf /tmp/* 

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 

WORKDIR /srv/gitbook

VOLUME /srv/gitbook /srv/html

EXPOSE 4000 35729

CMD /usr/local/bin/gitbook serve
