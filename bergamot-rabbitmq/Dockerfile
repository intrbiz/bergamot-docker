FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# For now use a custom RabbitMQ
# Install RabbitMQ Server
RUN zypper -q -n ar http://download.opensuse.org/repositories/home:/intrbiz:/branches:/openSUSE:/Leap:/42.2:/Update/standard/home:intrbiz:branches:openSUSE:Leap:42.2:Update.repo && zypper -q -n --gpg-auto-import-keys ref
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

