FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/agent-manager
RUN mkdir -p /opt/bergamot/agent-manager
RUN mkdir -p /var/opt/bergamot/agent-manager/certificates

# Set our workdir
WORKDIR /opt/bergamot/agent-manager

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-agent-manager-${bergamot_version}.app /opt/bergamot/agent-manager/bergamot-agent-manager.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-agent-manager.app

# Inject the default configuration
COPY default.xml /etc/bergamot/agent-manager/default.xml
COPY log4j.properties /etc/bergamot/agent-manager/log4j.properties

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/agent-manager/default.xml

# Volume for generated certificates
VOLUME /var/opt/bergamot/agent-manager/certificates

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-agent-manager.app"]
