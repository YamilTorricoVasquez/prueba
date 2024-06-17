#!/bin/bash

# Esperar a que PostgreSQL esté disponible
echo "Esperando a que PostgreSQL esté disponible..."

# Asignar valores predeterminados si no se han pasado como variables de entorno
DB_HOST=${DB_HOST:-db}
DB_PORT=${DB_PORT:-5432}
DB_USER=${DB_USER:-odoo}
DB_PASSWORD=${DB_PASSWORD:-myodoo}
DB_NAME=${DB_NAME:-postgres}

# Esperar hasta que PostgreSQL esté disponible
until PGPASSWORD=$DB_PASSWORD psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c '\q'; do
    echo "PostgreSQL no está disponible. Reintentando en 1 segundo..."
    sleep 1
done

echo "PostgreSQL está disponible. Iniciando Odoo..."

# Ejecutar Odoo
exec "$@"
