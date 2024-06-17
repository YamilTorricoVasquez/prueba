FROM odoo:17.0

# Cambiar al usuario root para instalar paquetes
USER root

# Cambiar los servidores de repositorio y agregar un mirror
RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/' /etc/apt/sources.list

# Instalar locales
RUN apt-get update --fix-missing && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    update-locale LANG=en_US.UTF-8

# Instalar Python y pip
RUN apt-get install -y python3-pip && \
    pip install --upgrade pip

# Instalar postgresql-server-dev-all en lugar de libpq-dev
RUN apt-get install -y postgresql-server-dev-all && \
    apt-get clean

# Instalar psycopg2-binary
RUN pip install --no-cache-dir psycopg2-binary

# Cambiar nuevamente al usuario odoo
USER odoo

# Copiar los archivos de configuración y scripts
COPY ./entrypoint.sh /entrypoint.sh
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf
COPY wait-for-psql.py /usr/local/bin/wait-for-psql.py

# Asignar permisos y montar los volúmenes
USER root
RUN chmod +x /entrypoint.sh \
    && chmod +x /usr/local/bin/wait-for-psql.py \
    && chown odoo:odoo /etc/odoo/odoo.conf \
    && mkdir -p /mnt/extra-addons \
    && chown -R odoo:odoo /mnt/extra-addons \
    && mkdir -p /var/log/odoo \
    && chown -R odoo:odoo /var/log/odoo
USER odoo

# Exponer Odoo services
EXPOSE 8069

# Set the default config file
ENV ODOO_RC /etc/odoo/odoo.conf

# Establecer el punto de entrada predeterminado
ENTRYPOINT ["/entrypoint.sh"]
CMD ["odoo"]
