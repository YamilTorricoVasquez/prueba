#!/bin/bash

# Esperar a que PostgreSQL esté listo
/wait-for-psql.py db --timeout=30 -- echo "PostgreSQL is ready."

# Ejecutar Odoo
exec "$@"
