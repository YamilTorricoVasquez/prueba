# Utilizamos la imagen oficial de Odoo 17.0 como base
FROM odoo:17.0

# Copiamos los archivos de configuración de Odoo
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf

# Exponemos el puerto de Odoo
EXPOSE 8069

# Instalamos PostgreSQL y sus herramientas
RUN dnf install -y postgresql-server postgresql-contrib && \
    postgresql-setup --initdb

# Configuramos la base de datos PostgreSQL
USER postgres
RUN /usr/bin/postgres --single -D /var/lib/pgsql/data -c config_file=/var/lib/pgsql/data/postgresql.conf <<< "CREATE USER odoo WITH SUPERUSER PASSWORD 'myodoo';" && \
    /usr/bin/postgres --single -D /var/lib/pgsql/data -c config_file=/var/lib/pgsql/data/postgresql.conf <<< "CREATE DATABASE postgres OWNER odoo;"

# Cambiamos nuevamente al usuario odoo
USER odoo
