#!/bin/bash

set -e

if [ "$1" = 'odoo' ]; then
    # Ensure the script waits for PostgreSQL to be available
    echo "Waiting for PostgreSQL..."
    python3 /usr/local/bin/wait-for-psql.py $HOST $USER $PASSWORD 5432

    echo "Starting Odoo..."
    exec odoo --logfile=/var/log/odoo/odoo.log
else
    exec "$@"
fi
