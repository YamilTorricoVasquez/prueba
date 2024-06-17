FROM odoo:17.0

# Copiar los archivos de configuración y scripts
COPY config/odoo.conf /etc/odoo/odoo.conf
COPY entrypoint.sh /entrypoint.sh
COPY wait-for-psql.py /wait-for-psql.py

# Asignar permisos y montar los volúmenes
USER root
RUN chmod +x /entrypoint.sh \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/extra-addons \
    && mkdir -p /var/log/odoo \
    && chown -R odoo:odoo /var/log/odoo

# Exponer Odoo services
EXPOSE 8069 8071 8072

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Establecer el usuario predeterminado al ejecutar el contenedor
USER odoo

ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
