#!/bin/bash
USERNAME=root
HOSTS="10.100.156.6"
SCRIPT="ip route add 10.100.158.0/25 via 10.100.157.6;
ip route add 10.100.159.0/25 via 10.100.157.6;"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done