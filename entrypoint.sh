#!/bin/sh
set -e

# Esperar a que PostgreSQL esté listo
/wait-for-psql.py "$POSTGRES_HOST" 5432 30

# Ejecutar el comando original
exec "$@"
