FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Build arguments
ARG bergamot_version=2.0.0

# Setup our directories
RUN mkdir -p /etc/bergamot/worker
RUN mkdir -p /opt/bergamot/worker/nagios

# Install some default nagios plugins
RUN zypper -q -n ref && zypper -q -n in --no-recommends monitoring-plugins-bind monitoring-plugins-bonding monitoring-plugins-breeze monitoring-plugins-by_ssh monitoring-plugins-cluster monitoring-plugins-common monitoring-plugins-contentage monitoring-plugins-cups monitoring-plugins-dbi monitoring-plugins-dbi-mysql monitoring-plugins-dbi-pgsql monitoring-plugins-dbi-sqlite3 monitoring-plugins-dhcp monitoring-plugins-dig monitoring-plugins-disk monitoring-plugins-disk_smb monitoring-plugins-dns monitoring-plugins-extras monitoring-plugins-file_age monitoring-plugins-flexlm monitoring-plugins-fping monitoring-plugins-haproxy monitoring-plugins-hpjd monitoring-plugins-http monitoring-plugins-icmp monitoring-plugins-ide_smart monitoring-plugins-ifoperstatus monitoring-plugins-ifstatus monitoring-plugins-ipmi-sensor1 monitoring-plugins-ircd monitoring-plugins-ldap monitoring-plugins-load monitoring-plugins-log monitoring-plugins-mailq monitoring-plugins-mailstat monitoring-plugins-mem monitoring-plugins-metadata monitoring-plugins-mrtg monitoring-plugins-mrtgtraf monitoring-plugins-mysql monitoring-plugins-mysql_health monitoring-plugins-nagios monitoring-plugins-nis monitoring-plugins-nt monitoring-plugins-ntp_peer monitoring-plugins-ntp_time monitoring-plugins-nwstat monitoring-plugins-openvpn monitoring-plugins-oracle monitoring-plugins-overcr monitoring-plugins-pgsql monitoring-plugins-ping monitoring-plugins-procs monitoring-plugins-qlogic_sanbox monitoring-plugins-radius monitoring-plugins-real monitoring-plugins-repomd monitoring-plugins-rpc monitoring-plugins-rsync monitoring-plugins-sar-perf monitoring-plugins-sensors monitoring-plugins-sentry3 monitoring-plugins-sip monitoring-plugins-smart monitoring-plugins-smtp monitoring-plugins-snmp monitoring-plugins-ssh monitoring-plugins-swap monitoring-plugins-tcp monitoring-plugins-tftp monitoring-plugins-time monitoring-plugins-traffic_limit monitoring-plugins-ups monitoring-plugins-users monitoring-plugins-wave monitoring-plugins-zypper monitoring-plugins-dummy -icinga

# Set our workdir
WORKDIR /opt/bergamot/worker/nagios

# Add our application
ADD https://files.bergamot-monitoring.org/app/${bergamot_version}/bergamot-worker-nagios-${bergamot_version}.app /opt/bergamot/worker/nagios/bergamot-worker-nagios.app

# Extract the application
RUN java -Dbootstrap.extract.only=true -jar bergamot-worker-nagios.app

# Inject the default configuration
COPY default.xml /etc/bergamot/worker/nagios/default.xml
COPY log4j.properties /etc/bergamot/worker/nagios/log4j.properties

ENV bergamot_config=/etc/bergamot/worker/nagios/default.xml

# The run command
CMD ["java", "-Dbootstrap.extract=false", "-jar", "bergamot-worker-nagios.app"]
