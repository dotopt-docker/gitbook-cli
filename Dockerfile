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
		libXtst-devel.x86_64 \
		\
		pango.x86_64 \
		libXcomposite.x86_64 \
		libXcursor.x86_64 \
		libXdamage.x86_64 \
		libXext.x86_64 \
		libXi.x86_64 \
		libXtst.x86_64 \
		cups-libs.x86_64 \
		libXScrnSaver.x86_64 \
		libXrandr.x86_64 \
		GConf2.x86_64 \
		alsa-lib.x86_64 \
		atk.x86_64 \
		gtk3.x86_64 \
		\
		ipa-gothic-fonts \
		xorg-x11-fonts-100dpi \
		xorg-x11-fonts-75dpi \
		xorg-x11-utils \
		xorg-x11-fonts-cyrillic \
		xorg-x11-fonts-Type1 \
		xorg-x11-fonts-misc \
	"\
	&& yum install -y $BUILD_DEPS \
	&& npm install -g cnpm --registry=https://registry.npm.taobao.org \
	&& cnpm install -g mermaid.cli  \
	&& cnpm install -g gitbook-cli \
	&& gitbook fetch ${VERSION} \
	&& wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh |  sh /dev/stdin \
	&& npm cache clear  --force \
	&& rm -rf /tmp/* \
	&& yum clean all \
	&& rm -rf /var/cache/yum

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 

WORKDIR /srv/gitbook

VOLUME /srv/gitbook /srv/html

EXPOSE 4000 35729

CMD /usr/local/bin/gitbook serve
