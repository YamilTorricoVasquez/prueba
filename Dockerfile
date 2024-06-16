FROM fedora:latest
MAINTAINER Your Name <your-email@example.com>

# Install dependencies
RUN dnf -y update && dnf -y install \
    ca-certificates \
    curl \
    dirmngr \
    fonts-noto-cjk \
    gnupg \
    libssl-dev \
    nodejs-less \
    npm \
    python3 \
    python3-pip \
    postgresql \
    postgresql-devel \
    redhat-rpm-config \
    && dnf clean all

# Create necessary directories and set permissions
RUN mkdir -p /var/log/odoo && \
    chown -R odoo:root /var/log/odoo

# Copy entrypoint script, Odoo configuration file, and wait-for-psql script
COPY ./entrypoint.sh /
COPY ./config_odoo/odoo.conf /etc/odoo/
COPY ./wait-for-psql.py /usr/local/bin/wait-for-psql.py

# Ensure scripts are executable
RUN chmod +x /entrypoint.sh /usr/local/bin/wait-for-psql.py

# Set default user when running the container
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
