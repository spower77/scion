#!/bin/bash
set -e

term() {
  exit 0
}

trap term TERM

if [ -n "$REMOTE_NETS" ]; then
    for net in $(echo $REMOTE_NETS | tr , ' '); do
        if [[ "$net" == *:* ]]; then
            [ -n "$SIG_IP6" ] && ip route add "$net" via "$SIG_IP6" dev eth0
        else
            [ -n "$SIG_IP" ] && ip route add "$net" via "$SIG_IP" dev eth0
        fi
    done
fi
echo "Tester started"

# Wake up from sleep once in a while so that SIGTERM is handled.
while :
do
    sleep 0.1
done
