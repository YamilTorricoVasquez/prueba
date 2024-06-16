#!/usr/bin/env python3
import sys
import psycopg2
from time import sleep

def wait_for_postgres():
    dbname = 'postgres'
    user = 'odoo'
    password = 'myodoo'
    host = 'db'
    port = '5432'

    while True:
        try:
            conn = psycopg2.connect(dbname=dbname, user=user, password=password, host=host, port=port)
            conn.close()
            print("PostgreSQL is ready")
            return
        except psycopg2.OperationalError:
            print("Waiting for PostgreSQL...")
            sleep(2)

if __name__ == '__main__':
    wait_for_postgres()
