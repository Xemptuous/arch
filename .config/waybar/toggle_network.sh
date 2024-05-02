# network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
network="enp14s0"
status=$(ip -br link show $network | awk {'print $2'})
if [[ $status == "UP" ]]; then
    ip link set $network down
else
    ip link set $network up
fi
