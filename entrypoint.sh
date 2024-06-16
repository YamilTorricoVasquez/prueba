#!/bin/bash

set -e

# Esperar a que esté disponible PostgreSQL
python3 /usr/local/bin/wait-for-psql.py

# Iniciar Odoo
exec odoo -c $ODOO_RC
