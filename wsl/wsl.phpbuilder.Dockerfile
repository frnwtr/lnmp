ARG OS_TYPE=debian:stretch-slim

FROM ${OS_TYPE} as builder

ENV TZ Asia/Shanghai

ARG PHP_VERSION=7.2.11

COPY lnmp-wsl-builder-php.sh /lnmp-wsl-builder-php.sh

COPY wsl-php-ext-enable.sh /usr/local/bin/wsl-php-ext-enable.sh

RUN sed -i "s#sudo##g" /lnmp-wsl-builder-php.sh \
      && chmod +x /usr/local/bin/wsl-php-ext-enable.sh \
      && sh /lnmp-wsl-builder-php.sh ${PHP_VERSION} tar deb travis

# scratch

FROM hello-world:latest@sha256:97ce6fa4b6cdc0790cda65fe7290b74cfebd9fa0c9b8c38e979330d547d22ce1

LABEL maintainer="khs1994-docker/lnmp <khs1994@khs1994.com>"

COPY --from=builder /*.tar.gz /

################################################################################

# FROM hello-world:latest@sha256:97ce6fa4b6cdc0790cda65fe7290b74cfebd9fa0c9b8c38e979330d547d22ce1 as deb
#
# LABEL maintainer="khs1994-docker/lnmp <khs1994@khs1994.com>"

COPY --from=builder /*.deb /
