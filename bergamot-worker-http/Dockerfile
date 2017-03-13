FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/worker
RUN mkdir -p /opt/bergamot/worker/http

# Set our workdir
WORKDIR /opt/bergamot/worker/http

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-worker-http-${bergamot_version}.app /opt/bergamot/worker/http/bergamot-worker-http.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-worker-http.app

# Inject the default configuration
COPY default.xml /etc/bergamot/worker/http/default.xml
COPY log4j.properties /etc/bergamot/worker/http/log4j.properties

ENV bergamot_config=/etc/bergamot/worker/http/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-worker-http.app"]
