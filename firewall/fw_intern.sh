export eth_server="eth2"
export eth_client="eth1"
export eth_backend="eth0"

export client="10.100.159.0/25"
export world="10.100.156.0/25"
export backend="10.100.158.0/25"
export server="10.100.157.0/25"


iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# intern
iptables -A FORWARD -i $eth_client -s $client -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
# jedes antwort-packet soll zu intern gehen koennen.
iptables -A FORWARD -o $eth_client -d $client -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# backend
iptables -A FORWARD -i $eth_backend -s $backend -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i $eth_server -o $eth_backend -s $server -d $backend -j ACCEPT
iptables -A FORWARD -i $eth_client -o $eth_backend -s $client -d $backend -j ACCEPT
iptables -A FORWARD -o $eth_backend -d $backend -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy FORWARD DROP
iptables --policy OUTPUT DROP