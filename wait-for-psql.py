#!/usr/bin/env python3
import sys
import psycopg2
from psycopg2 import OperationalError
import time

def wait_for_postgres(host, port, user, password, dbname, retries=10, delay=1):
    attempt = 0
    while attempt < retries:
        try:
            psycopg2.connect(host=host, port=port, user=user, password=password, dbname=dbname)
            print("PostgreSQL is available.")
            return
        except OperationalError as e:
            print(e)
            print(f"PostgreSQL not available. Retrying in {delay} seconds...")
            attempt += 1
            time.sleep(delay)
    print("Max retries reached. PostgreSQL is not available.")
    sys.exit(1)

if __name__ == "__main__":
    if len(sys.argv) != 6:
        print("Usage: wait_for_psql.py <host> <port> <user> <password> <dbname>")
        sys.exit(1)
    wait_for_postgres(*sys.argv[1:])
