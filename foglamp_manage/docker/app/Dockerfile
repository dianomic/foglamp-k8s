FROM ubuntu:18.04

LABEL maintainer="Ashish Jabble <ashish@dianomic.com>"

ARG PKG_VERSION
ARG ARCHIVE_REPO_USERNAME
ARG ARCHIVE_REPO_PASSWORD
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_HOST

ENV ARCHITECTURE="x86_64"
ENV DISTRIBUTION="ubuntu1804"
ENV BASE_URI="http://archives.dianomic.com/fogman"
ENV ARCHIVE_LINK="${BASE_URI}/${PKG_VERSION}/${DISTRIBUTION}/${ARCHITECTURE}/"

# Install pre-requisites
RUN apt -y update \
    && apt -y upgrade \
    && apt install -y curl gnupg2 iputils-ping jq nginx-light rsyslog sudo wget

# TODO: As there is no standard way to verify when a specific service is really ready
# Alternatively, write your own wrapper script to perform a more application-specific health check
COPY wait-for-postgres.sh ./

# Archive repo setup
RUN wget --user ${ARCHIVE_REPO_USERNAME} --password ${ARCHIVE_REPO_PASSWORD} -q -O - "${BASE_URI}/KEY.gpg" | apt-key add - \
    && echo "machine archives.dianomic.com login ${ARCHIVE_REPO_USERNAME} password ${ARCHIVE_REPO_PASSWORD}" > /etc/apt/auth.conf.d/foglamp-manage.conf \
    && echo "deb ${ARCHIVE_LINK} / " > /etc/apt/sources.list.d/foglamp-manage.list \
    && apt -y update

# Fake service control as docker container doesn't use it
RUN printf '#!/bin/bash \nexit 0' > /usr/bin/systemctl
RUN chmod 755 /usr/bin/systemctl

# Install foglamp-manage and foglamp-manage-gui APT package
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d\
    && apt install -y foglamp-manage foglamp-manage-gui \
    && ln -s /usr/local/fogman/bin/fogman /usr/local/bin/fogman \
    && sed -i '/imklog/s/^/#/' /etc/rsyslog.conf

# Build the Start Script
RUN echo "service rsyslog start" > start.sh \
    && echo "service nginx start" >> start.sh \
    && echo "bash wait-for-postgres.sh" >> start.sh \
    && echo "export FOGMAN_DB_HOST=\$POSTGRES_HOST && export FOGMAN_ROOT=/usr/local/fogman && fogman start" >> start.sh \
    && echo "tail -F /var/log/syslog" >> start.sh \
    && chmod +x start.sh

CMD ["bash", "./start.sh"]
