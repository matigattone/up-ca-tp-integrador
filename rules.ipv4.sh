#!/bin/bash

#Limpiamos tablas
iptables -F
iptables -X

# Limpiamos NAT
iptables -t nat -F
iptables -t nat -X

#Intranet LAN - IP 20.X
intranet20=eth2

#Intranet LAN - IP 10.X
intranet10=eth1

#Extranet WAN
extranet=eth0

# salientes, input y forward descartamos todo.
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP

# Reglas para loopback
# Loop device.
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Acceso de Administracion SSH desde CLIENTE-02
iptables -A INPUT -p tcp --dport 22 -i $intranet20 -s 192.168.20.2 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -o $intranet20 -d 192.168.20.2 -j ACCEPT

# Acceso a Intenet de CLIENTE-03
iptables -A FORWARD -s 192.168.20.3 -i $intranet20 -o $extranet -j ACCEPT
iptables -A FORWARD -i $extranet -o $intranet20 -d 192.168.20.3 -j ACCEPT
iptables -t nat -A POSTROUTING -s 192.168.20.3 -o $extranet -j MASQUERADE

# Acceso a WEBServer desde CLIENTE-04
iptables -A FORWARD -s 192.168.20.4 -d 192.168.10.3 -p tcp --dport 8080 -i $intranet20 -o $intranet10 -j ACCEPT
iptables -A FORWARD -d 192.168.20.4 -s 192.168.10.3 -p tcp --sport 8080 -i $intranet10 -o $intranet20 -j ACCEPT


