FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/worker
RUN mkdir -p /opt/bergamot/worker/agent

# Set our workdir
WORKDIR /opt/bergamot/worker/agent

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-worker-agent-${bergamot_version}.app /opt/bergamot/worker/agent/bergamot-worker-agent.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-worker-agent.app

# Inject the default configuration
COPY default.xml /etc/bergamot/worker/agent/default.xml
COPY log4j.properties /etc/bergamot/worker/agent/log4j.properties

# Expose our ports
EXPOSE 8090
EXPOSE 8081

# The default config file
ENV bergamot_config=/etc/bergamot/worker/agent/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-worker-agent.app"]
