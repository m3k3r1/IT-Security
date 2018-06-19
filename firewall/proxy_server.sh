iptables -A INPUT  -p tcp --dport 3128 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 3128 -j ACCEPT

iptables -A OUTPUT -p tcp -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

iptables --policy INPUT DROP
iptables --policy OUTPUT DROP
iptables --policy FORWARD DROP