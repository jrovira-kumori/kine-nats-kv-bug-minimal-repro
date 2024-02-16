#!/usr/bin/env bash

clear
cat <<- EOF
----------------------------------------------------------------------------

We will now deploy NATS (v2.10.5), Kine (v0.11.4) and KubeAPI (v1.29.1)
Once Kine is up and running we will se how KubeAPI prints out a stream of:

      illegal resource version from storage: 0

Wait for new instruction to appear.

----------------------------------------------------------------------------
EOF
read -p "Press enter to continue"

# Start NATS, Kine and KubeAPI
docker compose up nats kine kubeapi -d

# Watch how it fails
docker compose logs -f kubeapi &
PID=$!
sleep 10
kill -s SIGKILL $PID

cat <<- EOF
----------------------------------------------------------------------------

We will now start K3s (v1.29.1-k3s2) disabling most components except the 
KubeAPI server.

It is configured to use the previous Kine instance as its datastore. After
it initializes, we will kill it and restart KubeAPI.

We will observe how the previous stream of error no longer appears.

Wait for new instruction to appear.

----------------------------------------------------------------------------
EOF
read -p "Press enter to continue"


docker compose up k3s-kubeapi -d    # Start K3s to simulate a KubeAPI instance
sleep 10                            # Wait for it to do its thing...
docker compose down k3s-kubeapi     # Kill it (not strictly necessary)


# Watch how it now works
docker compose logs -f kubeapi &
PID=$!
sleep 10
kill -s SIGKILL $PID


cat <<- EOF
----------------------------------------------------------------------------

The error should no longer appear in the (Kubernetes) KubeAPI logs.

THE END

----------------------------------------------------------------------------
EOF
read -p "Press enter to clean up"
docker compose down