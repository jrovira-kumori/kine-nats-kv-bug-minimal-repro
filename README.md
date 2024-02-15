# K8s + Kine + NATS KeyValue store Bug

## Dependencies

- `docker`
- `kind`

## How to run

```bash
./run.sh; ./run_log.sh
```

You will eventually see a fast feed of logs from the KubeAPI server complaining about `illegal resource version from storage: 0` indefinately.

For some reason it does not work. However under the `works-with-k3s` directory you will find an example of it working as expected.