#!/bin/bash

sudo -i

# Remove IPs
ip netns exec red ip address del dev eth0-r 192.168.2.1/24
ip netns exec green ip address del dev eth0-g 192.168.2.2/24

# Disable adapters
ip netns exec red ip link set dev eth0-r down
ip netns exec green ip link set dev eth0-g down

# Move adapters from namespaces back to root
ip netns exec red ip link set eth0-r netns 1
ip netns exec green ip link set eth0-g netns 1

# Delete veth pairs
ip link del eth0-r type veth peer name veth-r
ip link del eth0-g type veth peer name veth-g

# Delete the bridge
ip link del name br0 type bridge

# Delete network namespaces
ip netns del red
ip netns del green
