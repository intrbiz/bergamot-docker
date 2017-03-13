FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/ui
RUN mkdir -p /etc/bergamot/config
RUN mkdir -p /opt/bergamot/ui
RUN mkdir -p /opt/bergamot/cli

# Inject the CLI too
WORKDIR /opt/bergamot/cli

# Add the CLI
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-cli-${bergamot_version}.app /opt/bergamot/cli/bergamot-cli.app

# Extract the CLI
RUN java -Dbootstrap.extract.only=true -jar bergamot-cli.app

# Add the main Bergamot UI
# Set our workdir
WORKDIR /opt/bergamot/ui

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-ui-${bergamot_version}.app /opt/bergamot/ui/bergamot-ui.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-ui.app

# Inject the default configuration
COPY default.xml /etc/bergamot/ui/default.xml
COPY log4j.properties /etc/bergamot/ui/log4j.properties

# Add the default site configuration templates
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-site-config-template.tar.gz /etc/bergamot/config/bergamot-site-config-template.tar.gz
RUN cd /etc/bergamot/config && tar -xzf bergamot-site-config-template.tar.gz && rm -f bergamot-site-config-template.tar.gz

# Allow using env var to set configuration file
ENV bergamot_config=/etc/bergamot/ui/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-Dbalsa.env=prod", "-jar", "bergamot-ui.app"]
