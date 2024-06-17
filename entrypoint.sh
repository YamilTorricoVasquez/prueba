#!/bin/bash

# Esperar a que PostgreSQL esté disponible
/usr/local/bin/wait-for-psql.py db

# Iniciar Odoo
exec odoo
