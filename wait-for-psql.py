#!/usr/bin/env python3
import sys
import time
import psycopg2
from psycopg2 import OperationalError

if len(sys.argv) != 6:
    print("Uso: wait-for-psql.py <host> <port> <user> <password> <db>")
    sys.exit(1)

host, port, user, password, db = sys.argv[1:]

while True:
    try:
        conn = psycopg2.connect(
            host=host,
            port=port,
            user=user,
            password=password,
            dbname=db
        )
        conn.close()
        print("PostgreSQL está disponible.")
        break
    except OperationalError:
        print("PostgreSQL no está disponible. Reintentando en 1 segundo...")
        time.sleep(1)
