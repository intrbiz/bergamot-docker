FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/notifier/webhook
RUN mkdir -p /opt/bergamot/notifier/webhook

# Set our workdir
WORKDIR /opt/bergamot/notifier/webhook

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-notifier-webhook-${bergamot_version}.app /opt/bergamot/notifier/webhook/bergamot-notifier-webhook.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-notifier-webhook.app

# Inject the default configuration
COPY default.xml /etc/bergamot/notifier/webhook/default.xml
COPY log4j.properties /etc/bergamot/notifier/webhook/log4j.properties

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/notifier/webhook/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-notifier-webhook.app"]
