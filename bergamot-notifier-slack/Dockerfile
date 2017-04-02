FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/notifier/slack
RUN mkdir -p /opt/bergamot/notifier/slack

# Set our workdir
WORKDIR /opt/bergamot/notifier/slack

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-notifier-slack-${bergamot_version}.app /opt/bergamot/notifier/slack/bergamot-notifier-slack.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-notifier-slack.app

# Inject the default configuration
COPY default.xml /etc/bergamot/notifier/slack/default.xml
COPY log4j.properties /etc/bergamot/notifier/slack/log4j.properties

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/notifier/slack/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-notifier-slack.app"]
