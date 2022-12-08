FROM postgres:10.0-alpine

LABEL maintainer="Ashish Jabble <ashish@dianomic.com>"

ARG PKG_VERSION
ARG ARCHIVE_REPO_USERNAME
ARG ARCHIVE_REPO_PASSWORD

ENV ARCHITECTURE="x86_64"
ENV DISTRIBUTION="ubuntu1804"
ENV BASE_URI="http://archives.dianomic.com/fogman"
ENV ARCHIVE_LINK="${BASE_URI}/${PKG_VERSION}/${DISTRIBUTION}/${ARCHITECTURE}/"
ENV DEBIAN_PACKAGE="foglamp-manage_${PKG_VERSION}_${ARCHITECTURE}.deb"
ENV DEBIAN_PACKAGE_LINK="${ARCHIVE_LINK}${DEBIAN_PACKAGE}"

RUN apk add --update git \
    && apk add --no-cache bash curl wget dpkg tar \ 
    && apk --no-cache --update add build-base \
    && adduser fogman -D -H \
    && mkdir -p sql \
    && wget --user ${ARCHIVE_REPO_USERNAME} --password ${ARCHIVE_REPO_PASSWORD} ${DEBIAN_PACKAGE_LINK} \
    && dpkg-deb -xv ${DEBIAN_PACKAGE} foglamp_manage \
    && cp foglamp_manage/usr/local/fogman/storage/init.sql sql/storage.sql \
    && cp foglamp_manage/usr/local/fogman/cmd/configuration/storage/init.sql sql/configuration.sql \
    && cp foglamp_manage/usr/local/fogman/cmd/monitor/storage/init.sql sql/monitor.sql \
    && cp foglamp_manage/usr/local/fogman/cmd/tenant/storage/init.sql sql/tenant.sql \
    && cp foglamp_manage/usr/local/fogman/notification/init.sql sql/notification.sql \
    && cp foglamp_manage/usr/local/fogman/users/users_db_init.sql sql/users.sql \
    && cp sql/*.sql /docker-entrypoint-initdb.d/ \
    && rm -rf foglamp_manage*
