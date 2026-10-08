FROM ubuntu:24.04
ARG ASTERISK_VERSION=22.11.0
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates curl git build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "${ASTERISK_VERSION}" https://github.com/asterisk/asterisk.git /usr/src/asterisk
WORKDIR /usr/src/asterisk
RUN contrib/scripts/install_prereq install \
    && ./configure --with-pjproject-bundled \
    && make menuselect.makeopts \
    && menuselect/menuselect --enable chan_pjsip menuselect.makeopts \
    && make -j2 \
    && make install \
    && ldconfig

RUN groupadd --system --gid 10001 asterisk \
    && useradd --system --uid 10001 --gid 10001 --home-dir /var/lib/asterisk --no-create-home --shell /usr/sbin/nologin asterisk \
    && mkdir -p /etc/asterisk /var/lib/asterisk /var/spool/asterisk /var/log/asterisk /run/asterisk \
    && chown -R asterisk:asterisk /var/lib/asterisk /var/spool/asterisk /var/log/asterisk /run/asterisk

COPY config/ /etc/asterisk/
USER 10001:10001

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD-SHELL /usr/sbin/asterisk -rx 'core show uptime' >/dev/null 2>&1 || exit 1

ENTRYPOINT ["/usr/sbin/asterisk", "-f", "-C", "/etc/asterisk/asterisk.conf", "-U", "asterisk", "-G", "asterisk", "-vvv"]
