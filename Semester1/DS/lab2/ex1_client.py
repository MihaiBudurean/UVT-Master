import socket

host_port   = ('127.0.0.1', 20001)
buffer_size          = 1024

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    while True:
        message = str.encode(input('>>> '))
        s.sendto(message, host_port)
        response = s.recvfrom(buffer_size)
        response_message = f'Message from Server {response[0]}'

print(msg)