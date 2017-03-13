FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/notifier/sms
RUN mkdir -p /opt/bergamot/notifier/sms

# Set our workdir
WORKDIR /opt/bergamot/notifier/sms

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-notification-engine-sms-${bergamot_version}.app /opt/bergamot/notifier/sms/bergamot-notifier-sms.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-notifier-sms.app

# Inject the default configuration
COPY default.xml /etc/bergamot/notifier/sms/default.xml
COPY log4j.properties /etc/bergamot/notifier/sms/log4j.properties

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/notifier/sms/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-notifier-sms.app"]
