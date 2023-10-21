import socket

HOST = '127.0.0.1'
PORT = 123

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.connect((HOST, PORT))
    
    while True:
        message = input('>>> ')
        encoded_message = bytes(message, 'utf-8')
        
        s.sendall(encoded_message)
        data = s.recv(1024)
        if data:
            print('Received: ' + data.decode('utf-8'))