FROM ubuntu:14.04
MAINTAINER Timo Wendt

RUN apt-get -y update && apt-get dist-upgrade -y && apt-get -y install openjdk-7-jre unzip

ENV OPENHAB_VERSION 1.7.0
ENV _JAVA_OPTIONS -Djava.net.preferIPv4Stack=true
# Add openhab distribution zip files
#ADD files/distro/ /tmp/
ADD files/distro/distribution-${OPENHAB_VERSION}-runtime.zip /tmp/
ADD files/distro/distribution-${OPENHAB_VERSION}-addons.zip /tmp/

RUN mkdir -p /opt/openhab/addons-avail
RUN mkdir /opt/openhab/lib
RUN unzip -d /opt/openhab /tmp/distribution-${OPENHAB_VERSION}-runtime.zip
RUN unzip -d /opt/openhab/addons-avail /tmp/distribution-${OPENHAB_VERSION}-addons.zip
RUN chmod +x /opt/openhab/start.sh

ADD files/bindings/ /opt/openhab/addons-avail/
ADD files/addons.cfg /opt/openhab/addons.cfg
ADD files/secret /opt/openhab/webapps/static/secret
ADD files/uuid /opt/openhab/webapps/static/uuid
ADD files/icons/ /opt/openhab/webapps/images/
ADD files/lib/ /opt/openhab/lib/

# Add boot script
ADD files/boot.sh /usr/local/bin/boot.sh

EXPOSE 8080 8443 5441

CMD /usr/local/bin/boot.sh
