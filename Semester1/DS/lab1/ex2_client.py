import socket

HOST = '85.120.206.130'
print(HOST)

for PORT in range(79, 81):
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    socket.setdefaulttimeout(1)
        
    result = s.connect_ex((HOST, PORT))
    if result == 0:
        print(f'Port {PORT} is open')
    else:
        print(f'Port {PORT} is occupied')
    s.close()