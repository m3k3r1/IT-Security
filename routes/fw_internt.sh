#!/bin/bash
USERNAME=root
HOSTS="10.100.158.5 10.100.159.8"
SCRIPT="ip route add 10.100.156.0/25 via 10.100.157.9"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done