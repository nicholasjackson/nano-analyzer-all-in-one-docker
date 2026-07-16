# Nano Analyzer All In One

Docker environment for running [nano-analyzer](https://github.com/nicholasjackson/nano-analyzer/tree/f-bob)
against [OWASP Juice Shop](https://github.com/juice-shop/juice-shop) using Bob Shell as the
analysis model.

## Building and running the container

```bash
make docker-build
```

Run the container, providing your Bob API key as `BOB_API_KEY`:

```bash
BOB_API_KEY=<your-bob-api-key> make docker-run
```

This starts Juice Shop on [http://localhost:3000](http://localhost:3000) and sets
`BOBSHELL_API_KEY` inside the container so `bob` can authenticate.

Get a shell in the running container:

```bash
make docker-shell
```

Remove the container when you're done:

```bash
make docker-rm
```

## Running nano-analyzer

From inside the container shell, `nano-analyzer` is checked out at `/tools/nano-analyzer`.
Run it against the Juice Shop source at `/juice-shop`. The `--bob-no-sandbox` flag is
required since the container does not have Docker or Podman installed, so bob's sandbox
mode is not available here.

Scan every file:

```bash
cd /tools/nano-analyzer
python3 scan.py /juice-shop --model bob --verbose --output-dir ./scan-results --bob-no-sandbox
```

Scan a single file:

```bash
cd /tools/nano-analyzer
python3 scan.py /juice-shop/server.ts --model bob --verbose --output-dir ./scan-results --bob-no-sandbox
```

Results are written to `./scan-results`.

## Requirements

- A valid Bob API key, passed as `BOB_API_KEY` when running `make docker-run`.
