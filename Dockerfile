# Utilizamos la imagen oficial de Fedora
FROM fedora:latest

# Instalamos Odoo desde el repositorio oficial de Odoo
RUN dnf install -y odoo

# Instalamos PostgreSQL
RUN dnf install -y postgresql postgresql-server

# Copiamos el archivo de configuración de Odoo
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf

# Exponemos el puerto de Odoo
EXPOSE 8069

# Inicializamos la base de datos de PostgreSQL
RUN /usr/bin/postgresql-setup --initdb

# Habilitamos y arrancamos el servicio de PostgreSQL
RUN systemctl enable postgresql
RUN systemctl start postgresql

# Cambiamos al usuario odoo
USER odoo
