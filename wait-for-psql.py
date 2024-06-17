import sys
import psycopg2
from urllib.parse import urlparse
from time import sleep

if __name__ == "__main__":
    url = urlparse(sys.argv[1])
    host = sys.argv[2]
    port = sys.argv[3]
    timeout = int(sys.argv[4]) if len(sys.argv) > 4 else 30
    while timeout > 0:
        try:
            conn = psycopg2.connect(
                dbname=url.path[1:],
                user=url.username,
                password=url.password,
                host=host,
                port=port
            )
            conn.close()
            sys.exit(0)
        except psycopg2.OperationalError:
            timeout -= 1
            sleep(1)
    sys.exit(1)
