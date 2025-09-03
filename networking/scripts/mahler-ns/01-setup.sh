#!/bin/bash

sudo -i

# Creating network namespaces
ip netns add red
ip netns add green

# Listing network namespaces
ip netns
ls /var/run/netns

# Running commands inside namesapce context
ip netns exec red ip link
ip netns exec green ip link

# Create a linux bridge to connect the namespaces
ip link add name br0 type bridge
ip link set dev br0 up
ip link

# Create a veth pair to connect red NS to bridge
ip link add eth0-r type veth peer name veth-r
ip link

# Move one end of the veth pair into the red namespace
ip link set eth0-r netns red
ip link
ip netns exec red ip link

# Attach the other end to the bridge
ip link set veth-r master br0
ip link

# Activate both ends
ip netns exec red ip link set dev eth0-r up
ip link set dev veth-r up

# Repeat for green
ip link add eth0-g type veth peer name veth-g
ip link set eth0-g netns green
ip link set veth-g master br0
ip netns exec green ip link set dev eth0-g up
ip link set dev veth-g up

# Set up ip addresses for each
ip netns exec red ip address add dev eth0-r 192.168.2.1/24
ip netns exec green ip address add dev eth0-g 192.168.2.2/24
