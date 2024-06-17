#!/usr/bin/env python3
import sys
import time
import socket

def wait_for_postgres(host, port, timeout):
    start_time = time.time()
    while time.time() - start_time < timeout:
        try:
            sock = socket.create_connection((host, port))
            sock.close()
            return True
        except socket.error:
            time.sleep(1)
    return False

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Usage: wait-for-psql.py <host> <port> <timeout>")
        sys.exit(1)
    host = sys.argv[1]
    port = int(sys.argv[2])
    timeout = int(sys.argv[3])
    if wait_for_postgres(host, port, timeout):
        sys.exit(0)
    else:
        print(f"Failed to connect to {host}:{port} within {timeout} seconds")
        sys.exit(1)
