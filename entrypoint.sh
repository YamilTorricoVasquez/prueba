#!/bin/bash

# Esperar a que PostgreSQL esté disponible
echo "Esperando a que PostgreSQL esté disponible..."

# Asigna valores predeterminados si no se han pasado como variables de entorno
DB_HOST=${DB_HOST:-db}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-odoo}
DB_PASSWORD=${DB_PASSWORD:-myodoo}
DB_NAME=${DB_NAME:-postgres}

/usr/local/bin/wait-for-psql.py $DB_HOST $DB_PORT $DB_USER $DB_PASSWORD $DB_NAME

echo "PostgreSQL está disponible. Iniciando Odoo..."

# Ejecutar Odoo
exec "$@"
