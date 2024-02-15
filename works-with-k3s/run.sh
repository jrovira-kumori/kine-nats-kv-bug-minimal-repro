#!/usr/bin/env bash

set -e 

cd $(dirname "$0")
source get_deps.sh

$GUM style --border normal --width 80 --margin "1" --padding "1 2" "$(cat <<-EOF
$($GUM style --bold --underline "K3S + NATS") - Using NATS as a Datastore alternative to ETCD

In this showcase, we deploy a K3s cluster utilizing NATS as a datastore alternative to etcd, configured with:

    $($GUM style --italic ' --datastore-enpoint=nats://nats:4222')

We will show the K3S cluster works as normal using NATS JetStream as its datastore.

EOF
)"

$GUM input --placeholder "Press Enter⏎ to begin (^C to abort)"

docker compose up -d

NATS="docker compose exec nats-healthcheck nats -s nats"
KUBECTL="docker compose exec -T control-plane-seed kubectl"

cat config/echo-server.yaml | $KUBECTL apply -f -
$GUM spin --spinner jump --title "Waiting for deployment... This may take ~1m." -- $KUBECTL wait -n echoserver --for=condition=Available deployment/echoserver --timeout=-1s
$KUBECTL get nodes -o wide
$KUBECTL get pods -n echoserver


$GUM style --border normal --width 80 --margin "1" --padding "1 2" "$(cat <<-EOF
K3S works as expected - but where is the control plane storing its data? 

K3S uses KINE, a shim of ETCD. This allows Kuberentes to interacting with $($GUM style --italic '"etcd"') all the while translating the operations to alternative datastores. These include SQLite, PostgreSQL, ETCD, NATS and more. 

When KINE is configured to use NATS it will use a KV bucket (and abstraction over a Stream) named 'kine' by default. 

We can see this in the following output.
EOF
)"

$NATS kv info kine

$GUM spin --spinner jump --title "Cleaning up..." -- docker compose down
