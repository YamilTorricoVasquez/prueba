#!/usr/bin/env python3
import sys
import psycopg2
from urllib.parse import urlparse
from time import sleep

if __name__ == "__main__":
    db_host = sys.argv[1]
    timeout = int(sys.argv[2]) if len(sys.argv) > 2 else 30
    while timeout > 0:
        try:
            conn = psycopg2.connect(
                dbname="postgres",
                user="odoo",
                password="myodoo",
                host=db_host,
                port=5432
            )
            conn.close()
            sys.exit(0)
        except psycopg2.OperationalError:
            timeout -= 1
            sleep(1)
    sys.exit(1)
