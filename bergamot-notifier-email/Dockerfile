FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/notifier/email
RUN mkdir -p /opt/bergamot/notifier/email

# Set our workdir
WORKDIR /opt/bergamot/notifier/email

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-notification-engine-email-${bergamot_version}.app /opt/bergamot/notifier/email/bergamot-notifier-email.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-notifier-email.app

# Inject the default configuration
COPY default.xml /etc/bergamot/notifier/email/default.xml
COPY log4j.properties /etc/bergamot/notifier/email/log4j.properties

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/notifier/email/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-notifier-email.app"]
