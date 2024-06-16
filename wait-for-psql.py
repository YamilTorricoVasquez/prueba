import sys
import time
import psycopg2

def wait_for_psql(host, user, password):
    while True:
        try:
            conn = psycopg2.connect(dbname='postgres', user=user, password=password, host=host)
            conn.close()
            break
        except psycopg2.OperationalError:
            print("PostgreSQL is unavailable - sleeping")
            time.sleep(1)
    print("PostgreSQL is up - continuing")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: wait-for-psql.py <host> <user> <password>")
        sys.exit(1)

    host = sys.argv[1]
    user = sys.argv[2]
    password = sys.argv[3]

    wait_for_psql(host, user, password)
