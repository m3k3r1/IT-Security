#!/bin/bash
USERNAME=root
HOSTS="10.100.156.2 10.100.156.3 10.100.156.4 10.100.156.5"
SCRIPT="ip route add 10.100.159.0/25 via 10.100.156.6;
ip route add 10.100.158.0/25 via 10.100.156.6;
ip route add 10.100.157.0/25 via 10.100.156.6"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done