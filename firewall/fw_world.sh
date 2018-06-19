
export eth_server="eth2"
export eth_client="eth1"
export eth_backend="eth0"

export client="10.100.159.0/25"
export world="10.100.156.0/25"
export backend="10.100.158.0/25"
export server="10.100.157.0/25"

export server1="10.100.157.6"
export server2="10.100.157.7"
export server3="10.100.157.5"

iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# fextern
# http server der firma
# MASQUERADE aktiviert das NATing. Das interne interface muss angegeben werden.
iptables -t nat -A POSTROUTING -o $eth_server -j MASQUERADE

iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 80 -j DNAT --to "$server1:80"
iptables -A FORWARD -i $eth_world -p tcp --dport 80 -d "$server1" -j ACCEPT
iptables -A FORWARD -i $eth_server -p tcp --sport 80 -s "$server1" -j ACCEPT

# imap
iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 143 -j DNAT --to "$server2:143"
iptables -A FORWARD -i  $eth_world -p tcp --dport 143 -d "$server2" -j ACCEPT
iptables -A FORWARD -i  $eth_server -p tcp --sport 143 -s "$server2" -j ACCEPT

# smtp
iptables -t nat -A PREROUTING -i $eth_world -p tcp --dport 25 -j DNAT --to "$server3:25"
iptables -A FORWARD -i $eth_world -p tcp --dport 25 -d "$server3" -j ACCEPT
iptables -A FORWARD -i $eth_server -p tcp --sport 25 -s "$server3" -j ACCEPT

# intern - stateful
iptables -A FORWARD -i $eth_server -s $client -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $client -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend - stateful
iptables -A FORWARD -i $eth_server -s $backend -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $backend -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# server - stateful
iptables -A FORWARD -i $eth_server -s $server -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -o $eth_server -d $server -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP