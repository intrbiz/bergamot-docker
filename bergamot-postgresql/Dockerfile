FROM bergamot-base:latest
MAINTAINER Chris Ellis <chris@intrbiz.com>

# Setup the PostgreSQL Database Repository
RUN zypper -q -n ar http://download.opensuse.org/repositories/server:/database:/postgresql/openSUSE_Leap_42.2/server:database:postgresql.repo && zypper -q -n --gpg-auto-import-keys ref

# Install PostgreSQL
RUN zypper -q -n ref && zypper -q -n in timezone postgresql96 postgresql96-server postgresql96-contrib

# Setup config dir
RUN mkdir -p /var/run/postgresql && chown postgres /var/run/postgresql && \
    mkdir -p /etc/postgresql && chown postgres /etc/postgresql && \
    mkdir -p /var/lib/postgresql && chown postgres /var/lib/postgresql

# User
USER postgres

# Copy in our configuration
COPY postgresql.conf /etc/postgresql/postgresql.conf
COPY pg_hba.conf /etc/postgresql/pg_hba.conf
COPY pg_ident.conf /etc/postgresql/pg_ident.conf

# Init the database
RUN /usr/lib/postgresql96/bin/initdb -E UTF8 --locale en_GB.UTF-8 -D /var/lib/postgresql
RUN rm /var/lib/postgresql/postgresql.conf && ln -sf /etc/postgresql/postgresql.conf /var/lib/postgresql/postgresql.conf
RUN rm /var/lib/postgresql/pg_hba.conf && ln -sf /etc/postgresql/pg_hba.conf /var/lib/postgresql/pg_hba.conf
RUN rm /var/lib/postgresql/pg_ident.conf && ln -sf /etc/postgresql/pg_ident.conf /var/lib/postgresql/pg_ident.conf

# Setup database and users
RUN /usr/lib/postgresql96/bin/pg_ctl -D /var/lib/postgresql -l /var/lib/postgresql/postgresql.log start && \
    sleep 5 && \
    /usr/lib/postgresql96/bin/psql -c "CREATE ROLE bergamot LOGIN ENCRYPTED PASSWORD 'md5ec93d2a1e89d31637d161721b1f83211' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;" && \
    /usr/lib/postgresql96/bin/psql -c "CREATE DATABASE bergamot WITH OWNER = bergamot ENCODING = 'UTF8' TABLESPACE = pg_default LC_COLLATE = 'en_GB.UTF-8' LC_CTYPE = 'en_GB.UTF-8' CONNECTION LIMIT = -1;" && \
    /usr/lib/postgresql96/bin/pg_ctl -D /var/lib/postgresql stop

# Expose PostgreSQL port
EXPOSE 5432

# Setup volumes
VOLUME /var/lib/postgresql

# The Postgresql start command
CMD [ "/usr/lib/postgresql96/bin/postgres", "-D", "/var/lib/postgresql"]
