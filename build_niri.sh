#!/usr/bin/env bash
set -euo pipefail

# Directory locale dove vuoi mettere il binario
OUT_DIR="$(pwd)/out"

# Creala se non esiste
mkdir -p "$OUT_DIR"

# Costruisci il container e monta la cartella host
podman build -t niri-autobuild .

# Lancia il container solo per eseguire la build e far uscire il binario
podman run --rm -v "$OUT_DIR":/out niri-autobuild

echo "Binario niri pronto in: $OUT_DIR/niri"
