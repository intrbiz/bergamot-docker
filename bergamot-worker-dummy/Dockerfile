FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/worker
RUN mkdir -p /opt/bergamot/worker/dummy

# Set our workdir
WORKDIR /opt/bergamot/worker/dummy

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-worker-dummy-${bergamot_version}.app /opt/bergamot/worker/dummy/bergamot-worker-dummy.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-worker-dummy.app

# Inject the default configuration
COPY default.xml /etc/bergamot/worker/dummy/default.xml
COPY log4j.properties /etc/bergamot/worker/dummy/log4j.properties

ENV bergamot_config=/etc/bergamot/worker/dummy/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-worker-dummy.app"]
