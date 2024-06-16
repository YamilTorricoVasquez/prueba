import psycopg2
import time
import os

# Connection details
db_host = os.getenv('HOST', 'db')
db_port = os.getenv('PORT', '5432')
db_user = os.getenv('USER', 'odoo')
db_password = os.getenv('PASSWORD', 'myodoo')

# Retry parameters
max_retries = 10
wait_time = 5  # seconds

def connect_to_postgres():
    try:
        conn = psycopg2.connect(
            dbname='postgres',
            user=db_user,
            password=db_password,
            host=db_host,
            port=db_port
        )
        conn.close()
        return True
    except psycopg2.OperationalError:
        return False

for i in range(max_retries):
    if connect_to_postgres():
        print("PostgreSQL is up and running!")
        exit(0)
    else:
        print(f"PostgreSQL is unavailable - sleeping for {wait_time} seconds...")
        time.sleep(wait_time)

print("Failed to connect to PostgreSQL after several attempts.")
exit(1)
