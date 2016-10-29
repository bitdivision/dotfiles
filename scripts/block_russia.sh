#!/bin/sh
#Block russian csgo servers
#Ruski
iptables -A OUTPUT -d 146.66.156.0/24 -j DROP
iptables -A OUTPUT -d 146.66.157.0/24 -j DROP
iptables -A OUTPUT -d 185.25.181.0/24 -j DROP 
#EU East
iptables -A OUTPUT -d 146.66.155.0/24 -j DROP
iptables -A OUTPUT -d 185.25.182.0/24 -j DROP



