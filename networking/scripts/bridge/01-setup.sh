#!/bin/bash

sudo -i

# Remove IP address from network adapter
ip address del ens18 192.168.1.117/24

# Create a linux bridge and activate
ip link add name br0 type bridge
ip link set dev br0 up

# Attach the existing adapter to the bridge
ip link set ens18 master br0

# Allocate an IP to the bridge
ip address add br0 192.168.1.240/24

# Test 1 (works)
ping -c 1 192.168.1.4

# Test 2 (fails)
ping -c 1 1.1.1.1

# Add a default route
ip route add default via 192.168.1.1 dev br0

# Test 3 (works)
ping -c 1 1.1.1.1
