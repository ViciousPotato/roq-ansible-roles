#!/usr/bin/env bash

set -e

CONDA_DIR="/trading/infra/miniconda3"
LOG_DIR="/trading/logs"
SOCKET="/var/tmp/femasapi.sock"
CHDIR="/trading/run/collector"
DATE="$(date +%Y-%m-%d)"
STDOUT="/trading/data/femasapi_$DATE.csv"

USER="test"
PASSWORD="1234"

source "$CONDA_DIR/bin/activate" roq

export ROQ_log_dir="$LOG_DIR"
export ROQ_v=0

"$CONDA_PREFIX/bin/roq-samples-collector" --gateways "femasapi=$USER:$PASSWORD@$SOCKET" >> "$STDOUT"
