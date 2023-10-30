# import socket
# from time import ctime


# HOST = '127.0.0.1'
# PORT = 1379

# with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
#     s.bind((HOST, PORT))
    
#     while True:
#         bytes_address_pair = s.recvfrom(1024)
#         data = bytes_address_pair[0]
#         address = bytes_address_pair[1]
        
#         if not data:
#             break
        
#         print(data.decode('utf-8'))
#         data_timestamp = str.encode(ctime() + ': ' + str(data), 'utf-8')
#         s.sendto(data_timestamp, address)


import socket

# localIP     = "127.0.0.1"
# localPort   = 20001
host_port = ('127.0.0.1', 20001)
buffer_size  = 1024

# msgFromServer       = "Hello UDP Client"
# bytesToSend         = str.encode(msgFromServer)

with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
    s.bind(host_port)
    print("UDP server up and listening")

 

# Listen for incoming datagrams

while(True):

    bytesAddressPair = UDPServerSocket.recvfrom(bufferSize)

    message = bytesAddressPair[0]

    address = bytesAddressPair[1]

    clientMsg = "Message from Client:{}".format(message)
    clientIP  = "Client IP Address:{}".format(address)
    
    print(clientMsg)
    print(clientIP)

   

    # Sending a reply to client

    UDPServerSocket.sendto(bytesToSend, address)