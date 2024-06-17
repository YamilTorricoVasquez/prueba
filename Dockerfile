# Utilizamos la imagen oficial de Odoo 17.0 como base
FROM odoo:17.0

# Copiamos los archivos de configuración de Odoo
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf

# Exponemos el puerto de Odoo
EXPOSE 8069

# Instalamos PostgreSQL y sus herramientas
RUN apt-get update && \
    apt-get install -y gnupg2 && \
    apt-get install -y wget && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list' && \
    apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# Configuramos la base de datos PostgreSQL
USER postgres
RUN /etc/init.d/postgresql start && \
    psql --command "CREATE USER odoo WITH SUPERUSER PASSWORD 'myodoo';" && \
    createdb -O odoo postgres && \
    /etc/init.d/postgresql stop

# Cambiamos nuevamente al usuario odoo
USER odoo
