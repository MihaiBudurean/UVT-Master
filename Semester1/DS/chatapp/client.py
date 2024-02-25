import socket

SERVER_ADDRESS = '127.0.0.1'
SERVER_PORT = 12345

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

client_socket.connect((SERVER_ADDRESS, SERVER_PORT))

# client_socket.sendall(b'Hello, server!')

# data = client_socket.recv(1024)
# print("Received:", data.decode())

client_socket.close()
