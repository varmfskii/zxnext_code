#!/bin/python
ip=input("Server Address: ")
pt=input("Server port: ")
gw=input("Gateway address: ")
mk=input("Network Mask: ")
ss=input("WiFi SSID: ")
pw=input("WiFi password: ")
cfg=open("server.cfg", "w")
cfg.write("ATE0\n")
cfg.write("AT+CWMODE=1\n")
cfg.write("AT+CIPSTA=\""+ip+"\",\""+gw+"\",\""+mk+"\"\n")
cfg.write("AT+CWJAP=\""+ss+"\",\""+pw+"\"\n")
cfg.write("AT+CIPMUX=1\n")
cfg.write("AT+CIPSERVER=1,"+pt+"\n")
cfg.close()


