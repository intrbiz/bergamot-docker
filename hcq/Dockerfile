FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG hcq_version=0.0.1-SNAPSHOT

# Setup our directories
RUN mkdir -p /etc/bergamot/hcq
RUN mkdir -p /opt/bergamot/hcq

WORKDIR /opt/bergamot/hcq

# Add our application
ADD https://files.bergamot-monitoring.org/app/dev/hcq-${hcq_version}.app /opt/bergamot/hcq/hcq.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar hcq.app

# Inject the default configuration
COPY hazelcast.xml /etc/bergamot/hcq/hazelcast.xml

# Default environment vars
ENV hcq_hazelcast_config=/etc/bergamot/hcq/hazelcast.xml
ENV hcq_port=6643

# Ports
EXPOSE 6680
EXPOSE 6643

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "hcq.app"]
