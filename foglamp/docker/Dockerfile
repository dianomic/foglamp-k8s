FROM ubuntu:18.04

# NOTE: WE are now using the NIGHTLY development build

ARG ARCHITECTURE="x86_64"
ARG FOGLAMPVERSION="1.9.2"
ARG OPERATINGSYSTEM="ubuntu1804"
ARG FOGLAMPLINK="http://archives.dianomic.com/foglamp/latest/${OPERATINGSYSTEM}/${ARCHITECTURE}/"
# ARG FOGLAMPNIGHTLY="http://archives.dianomic.com/foglamp/nightly/${OPERATINGSYSTEM}/${ARCHITECTURE}/"
# ARG FOGLAMPLINK="${FOGLAMPNIGHTLY}"
# RUN echo nightly_2021_09_20

#Install pre-requisites
RUN apt update && \
    apt-get install -y rsyslog curl wget jq procps python3-pip nginx-light software-properties-common grep

#Fake service control as docker container doesnt use it
RUN printf '#!/bin/bash \nexit 0' > /usr/bin/systemctl
RUN chmod 755 /usr/bin/systemctl

#Install foglamp repo within container
RUN wget -q -O - http://archives.dianomic.com/KEY.gpg | apt-key add - && \
add-apt-repository "deb ${FOGLAMPLINK} / "

#Install foglamp
RUN apt update && DEBIAN_FRONTEND=noninteractive apt install -y foglamp \
foglamp-dev \
foglamp-mqtt \
foglamp-filter-asset \
foglamp-filter-asset-split \
foglamp-filter-delta \
foglamp-filter-flirvalidity \
foglamp-filter-omfhint \
foglamp-filter-metadata \
foglamp-filter-expression \
foglamp-filter-python35 \
foglamp-north-httpc \
foglamp-notify-asset \
foglamp-notify-jsonconfig \
foglamp-notify-mqtt \
foglamp-rule-simple-expression \
foglamp-service-notification \
foglamp-south-piwebapi \
foglamp-south-beckhoff \
foglamp-south-flirax8 \
foglamp-south-http-south \
foglamp-south-modbus \
foglamp-south-opcua \
foglamp-south-s7 \
foglamp-south-sinusoid \
foglamp-south-mqtt-scripted \
foglamp-south-suezwater \
foglamp-south-simple-rest \
foglamp-filter-rename

RUN pip3 install pandas


##Install missing Packages
#RUN wget "http://archives.dianomic.com/foglamp/1.9.1/ubuntu1804/x86_64/foglamp-south-mqtt-scripted-1.9.1-x86_64.deb" && dpkg -i "foglamp-south-mqtt-scripted-1.9.1-x86_64.deb"
#RUN wget "http://archives.dianomic.com/foglamp/nightly/ubuntu1804/x86_64/foglamp-south-SuezWater-1.9.1-x86_64.deb" && dpkg -i "foglamp-south-SuezWater-1.9.1-x86_64.deb"

#Fix and install foglamp-gui
# RUN wget http://archives.dianomic.com/foglamp/nightly/ubuntu1804/x86_64/foglamp-gui-1.9.1next.deb && \
RUN wget http://archives.dianomic.com/foglamp/latest/ubuntu1804/x86_64/foglamp-gui-1.9.2.deb && \
dpkg --unpack foglamp-gui*.deb && \
sed -i 's/grep/echo/g' /var/lib/dpkg/info/foglamp-gui.postinst && \
dpkg --configure foglamp-gui

#Build the Start Script
RUN echo "service rsyslog start" > start.sh && \
    echo "service nginx start" >> start.sh && \
    echo "/usr/local/foglamp/bin/foglamp start" >> start.sh && \
    echo "tail -f /var/log/syslog" >> start.sh && \
    chmod +x start.sh

RUN usermod -aG adm root && usermod -aG www-data root

ENV FOGLAMP_ROOT=/usr/local/foglamp

VOLUME /usr/local/foglamp/data

# FogLAMP API and FogLAMP GUI ports
EXPOSE 8081 1995 80 6683
#Rerunning the image
CMD ["bash", "./start.sh"]

