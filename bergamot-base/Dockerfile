FROM opensuse:42.2
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Install the base JDK
RUN zypper -q -n in java-1_8_0-openjdk
RUN zypper -q -in in tar

# Setup some common directories
RUN mkdir -p /etc/bergamot
RUN mkdir -p /opt/bergamot
RUN mkdir -p /var/log/bergamot

# Volume for logs
VOLUME /var/log/bergamot
