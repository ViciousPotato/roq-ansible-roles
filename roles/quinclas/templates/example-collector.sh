#!/usr/bin/env bash

set -e

# Configuration
CONDA_DIR="/trading/infra/miniconda2"
LOG_DIR="/trading/logs"
SOCKET="/var/tmp/femas.sock"
PIDFILE="/trading/run/.collector.pid"
CHDIR="/trading/run/collector"
STDOUT="/trading/data/collector.tick"

# Parse options
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
  --start)
  TYPE="start"
  shift
  ;;
  --stop)
  TYPE="stop"
  shift
  ;;
  *)
  >&2 echo "unknown argument" && exit 1
  ;;
esac
done

# Daemonize
case $TYPE in
  start)
  source "$CONDA_DIR/bin/activate"
  export GLOG_log_dir="$LOG_DIR"
  export GLOG_minloglevel=0
  /usr/bin/daemon --respawn --pidfile "$PIDFILE" --chdir "$CHDIR" --stdout "$STDOUT" --unsafe \
      -- "$CONDA_PREFIX/bin/example-collector" --local-address "$SOCKET"
  ;;
  stop)
  /usr/bin/pkill -F "$PIDFILE" >/dev/null 2>&1
  ;;
esac
