FROM python:3.7-stretch
# the args must be onbuild to allow overwriting it in derived images
# https://github.com/moby/moby/issues/26533#issuecomment-246966836
ONBUILD ARG PIP_INDEX_URL
ONBUILD ARG PIP_TRUSTED_HOST
ONBUILD ARG APT_PROXY
ONBUILD ENV PIP_TRUSTED_HOST=$PIP_TRUSTED_HOST PIP_INDEX_URL=$PIP_INDEX_URL
ONBUILD RUN test -n "$APT_PROXY" && echo "Acquire::http::Proxy \"$APT_PROXY\";" \
    >/etc/apt/apt.conf.d/proxy

# TERM needs to be set here for exec environments
# PIP_TIMEOUT so installation doesn't hang forever
ENV TERM=xterm \
    PIP_TIMEOUT=180 \
    SHUB_ENFORCE_PIP_CHECK=1

RUN apt-get update -qq && \
    apt-get install -qy \
        netbase ca-certificates apt-transport-https \
        build-essential locales \
        libxml2-dev \
        libssl-dev \
        libxslt1-dev \
        default-libmysqlclient-dev \
        libpq-dev \
        libevent-dev \
        libffi-dev \
        libpcre3-dev \
        libz-dev \
        unixodbc unixodbc-dev \
        telnet vim htop iputils-ping curl wget lsof git sudo \
        ghostscript && \
    rm -rf /var/lib/apt/lists

# adding custom locales to provide backward support with scrapy cloud 1.0
COPY locales /etc/locale.gen
RUN locale-gen

COPY requirements.txt /stack-requirements.txt
RUN pip install --no-cache-dir -r stack-requirements.txt

RUN mkdir /app
COPY addons_eggs /app/addons_eggs
RUN chown nobody:nogroup -R /app/addons_eggs
