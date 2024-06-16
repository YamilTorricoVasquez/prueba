import sys
import time
import psycopg2

def connect_to_postgres(host, user, password, port):
    while True:
        try:
            conn = psycopg2.connect(
                dbname='postgres',
                user=user,
                password=password,
                host=host,
                port=port
            )
            conn.close()
            return
        except psycopg2.OperationalError:
            print('Postgres is unavailable - sleeping')
            time.sleep(1)

if __name__ == '__main__':
    if len(sys.argv) != 5:
        print("Usage: wait-for-psql.py <host> <user> <password> <port>")
        sys.exit(1)

    _, host, user, password, port = sys.argv
    connect_to_postgres(host, user, password, port)
