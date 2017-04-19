FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup the Server HTTP Repository
RUN zypper -q -n ar http://download.opensuse.org/repositories/server:/http/openSUSE_Leap_42.2/server:http.repo && zypper -q -n --gpg-auto-import-keys ref

# Pull in the public resources from the UI
RUN mkdir -p /opt/bergamot/ui

# Set our workdir
WORKDIR /opt/bergamot/ui

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-ui-${bergamot_version}.app /opt/bergamot/ui/bergamot-ui.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-ui.app

# Install nginx
RUN zypper -q -n ref && zypper -q -n in nginx

# Pid dir
RUN mkdir -p /run/nginx && chown nginx /run/nginx

# Custom conf dir
RUN mkdir -p /etc/nginx/conf.d && chown nginx /etc/nginx/conf.d

# User
USER nginx

# Copy in our configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY balsa_scgi_params.conf /etc/nginx/balsa_scgi_params.conf
COPY upstream.conf /etc/nginx/conf.d/upstream.conf

# Expose our ports
EXPOSE 8080

# The Postgresql start command
CMD [ "/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf" ]
