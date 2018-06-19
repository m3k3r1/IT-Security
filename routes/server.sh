#!/bin/bash
USERNAME=root
HOSTS="10.100.157.2 10.100.157.3 10.100.157.4 10.100.157.5 10.100.157.6 10.100.157.7"
SCRIPT="ip route add 10.100.158.0/25 via 10.100.157.9;
ip route add 10.100.159.0/25 via 10.100.157.9;
ip route add 10.100.156.0/25 via 10.100.157.8"
for HOSTNAME in ${HOSTS} ; do
    ssh -l ${USERNAME} ${HOSTNAME} "${SCRIPT}"
done