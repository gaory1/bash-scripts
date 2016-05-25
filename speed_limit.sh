#!/bin/bash
#Limits the speed used by tcp port 9292 to 0.9 of the full speed of device $DEV

DEV=em1

full_speed=$(ethtool $DEV | awk '/Speed:/{print $2}' | sed "s/Mb\/s//")
limited_speed=$(echo "$full_speed*0.9" | bc | sed "s/\..*$//")

tc qdisc del dev $DEV root
tc qdisc add dev $DEV root handle 1: htb default 2
tc class add dev $DEV parent 1:1 classid 1:2 htb rate ${full_speed}mbit ceil ${full_speed}mbit prio 2
tc class add dev $DEV parent 1:1 classid 1:3 htb rate ${limited_speed}mbit ceil ${limited_speed}mbit prio 2
tc qdisc add dev $DEV parent 1:2 handle 2: sfq perturb 10
tc qdisc add dev $DEV parent 1:3 handle 3: sfq perturb 10
tc filter add dev $DEV parent 1:0 protocol ip prio 1 handle 100 fw flowid 1:3

iptables -I OUTPUT 1 -p tcp --sport 9292 -j MARK --set-mark 100
iptables -I OUTPUT 1 -p tcp --dport 9292 -j MARK --set-mark 100

