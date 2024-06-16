#!/bin/bash

/wait-for-psql.py db --timeout=30 -- echo "PostgreSQL is ready."
exec "$@"
