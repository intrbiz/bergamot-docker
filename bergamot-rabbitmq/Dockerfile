FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Install RabbitMQ Server
RUN zypper -q -n ref && zypper -q -n in rabbitmq-server rabbitmq-server-plugins

# Copy the configuration files in
COPY enabled_plugins /etc/rabbitmq/enabled_plugins
COPY rabbitmq.config /etc/rabbitmq/rabbitmq.config

# Expose the ports
EXPOSE 5672
EXPOSE 15672

# Volumes for data
VOLUME /var/lib/rabbitmq

# Volumes for logs
VOLUME /var/log/rabbitmq

CMD [ "/usr/sbin/rabbitmq-server" ]

