FROM odoo:17.0

# Instalar locales y psycopg2-binary
USER root
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install -y python3-pip && \ 
    pip install psycopg2-binary && \
    apt-get clean

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Copiar los archivos de configuración y scripts
COPY ./entrypoint.sh /entrypoint.sh
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf
COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py

# Asignar permisos y montar los volúmenes
RUN chmod +x /entrypoint.sh \
    && chmod +x /usr/local/bin/wait-for-psql.py \
    && chown odoo:odoo /etc/odoo/odoo.conf \
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
