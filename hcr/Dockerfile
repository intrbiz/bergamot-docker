FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG hcr_version=0.0.3

# Setup our directories
RUN mkdir -p /etc/bergamot/hcr
RUN mkdir -p /opt/bergamot/hcr

WORKDIR /opt/bergamot/hcr

# Add our application
ADD https://files.bergamot-monitoring.org/app/dev/hcr-${hcr_version}.app /opt/bergamot/hcr/hcr.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar hcr.app

# Inject the default configuration
COPY hazelcast.xml /etc/bergamot/hcr/hazelcast.xml

# Default environment vars
ENV hcr_hazelcast_config=/etc/bergamot/hcr/hazelcast.xml
ENV hcr_port=6379
ENV hcr_stats_port=6380
ENV hcr_socket_timeout=900
ENV hcr_key_timeout=3600

# Ports
EXPOSE 6580
EXPOSE 6379
EXPOSE 6380

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "hcr.app"]
