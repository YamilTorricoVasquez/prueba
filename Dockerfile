# Utilizamos la imagen oficial de Odoo 17.0 como base
FROM odoo:17.0

# Instalamos gnupg2 y wget para descargar claves y paquetes
RUN apt-get update && \
    apt-get install -y gnupg2 wget

# Descargamos la clave de PostgreSQL y la agregamos
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Agregamos el repositorio de PostgreSQL al sistema de paquetes
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ focal-pgdg main" >> /etc/apt/sources.list.d/pgdg.list

# Actualizamos el índice de paquetes y luego instalamos PostgreSQL y sus contribuciones
RUN apt-get update && \
    apt-get install -y postgresql postgresql-contrib

# Copiamos los archivos de configuración de Odoo
COPY ./config_odoo/odoo.conf /etc/odoo/odoo.conf

# Exponemos el puerto de Odoo
EXPOSE 8069

# Cambiamos nuevamente al usuario odoo
USER odoo
