# Dockerfile

FROM odoo:17.0

# Copy entrypoint script, Odoo configuration file, and wait-for-psql script
COPY entrypoint.sh /
COPY config_odoo/odoo.conf /etc/odoo/
COPY wait-for-psql.py /wait-for-psql.py

# Ensure scripts are executable
RUN chmod +x /entrypoint.sh /wait-for-psql.py

# Set the default entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Default command
CMD ["odoo"]
