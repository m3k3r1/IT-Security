#!/bin/bash
USERNAME=root
HOSTS="10.100.158.2 10.100.158.3 10.100.158.4 10.100.158.6 10.100.158.7"
SCRIPT="ip route add 10.100.159.0/25 via 10.100.158.5;
ip route add 10.100.157.0/25 via 10.100.158.5;
ip route add 10.100.156.0/25 via 10.100.158.5"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done