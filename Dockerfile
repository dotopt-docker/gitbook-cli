FROM centos:7.5.1804
LABEL maintainer="wuxingzhong <wuxingzhong@sunniwell.net>"

ARG VERSION=3.2.3

LABEL version=$VERSION

ADD simsun.ttc /usr/share/fonts/truetype/simsun.ttc

RUN set -x \
	&& yum install -y epel-release \
	&& BUILD_DEPS=" \
		wget \
		git \
		npm \
		python \
		xdg-utils \
		libX11-devel \
		libGL-devel \
		libqtxdg-devel \
		libXrender-devel \
		libXcomposite-devel \
	" \
	&& yum install -y $BUILD_DEPS \
	&& npm install -g mermaid.cli  \
	&& npm install -g gitbook-cli \
	&& gitbook fetch ${VERSION} \
	&& wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh |  sh /dev/stdin \
	&& npm cache clear  --force \
	&& rm -rf /tmp/* \
	&& yum clean all \
	&& rm -rf /var/cache/yum

WORKDIR /srv/gitbook

VOLUME /srv/gitbook /srv/html

EXPOSE 4000 35729

CMD /usr/local/bin/gitbook serve
