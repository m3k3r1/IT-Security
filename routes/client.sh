#!/bin/bash
USERNAME=root
HOSTS="10.100.159.2 10.100.159.3 10.100.159.4 10.100.159.5 10.100.159.6 10.100.159.7"
SCRIPT="ip route add 10.100.158.0/25 via 10.100.159.8;
ip route add 10.100.157.0/25 via 10.100.159.8;
ip route add 10.100.156.0/25 via 10.100.159.8"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done