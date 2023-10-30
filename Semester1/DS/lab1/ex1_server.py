import socket
from time import ctime


HOST = '127.0.0.1'
PORT = 13179

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen()
    
    conn, addr = s.accept()
    
    with conn:
        print(f'Connected by {addr}')
        
        while True:
            data = conn.recv(1024)
            if not data:
                break
            print(data.decode('utf-8'))
            data_timestamp = bytes(ctime() + ': ' + str(data), 'utf-8')
            conn.send(data_timestamp)