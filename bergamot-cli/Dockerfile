FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /opt/bergamot/cli

# Set our workdir
WORKDIR /opt/bergamot/cli

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-cli-${bergamot_version}.app /opt/bergamot/cli/bergamot-cli.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-cli.app

# The run command
ENTRYPOINT ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-cli.app"]
