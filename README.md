# K8s + Kine + NATS KeyValue store Bug

## Dependencies

- `docker`

## How to run

```bash
./run.sh
```

The run script will guide you through the demonstration.

You will eventually see a fast feed of logs from the KubeAPI server complaining about `illegal resource version from storage: 0` indefinitely.

For some reason KubeAPI is unable to initialize the datastore.
