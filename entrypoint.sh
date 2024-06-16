#!/bin/bash

set -e

# Wait for PostgreSQL to be available
python3 /wait-for-psql.py

# Start Odoo
exec odoo
