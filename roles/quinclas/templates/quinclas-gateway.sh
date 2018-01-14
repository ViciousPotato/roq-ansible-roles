#!/usr/bin/env bash

set -e

# Configuration
CONDA_DIR="/trading/infra/miniconda2"
LOG_DIR="/trading/logs"
CONFIG="/trading/config/{{ item }}.conf"
SOCKET="/var/tmp/{{ item }}.sock"
PIDFILE="/trading/run/.{{ item }}.pid"
CHDIR="/trading/run/{{ item }}"

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
  source "$CONDA_DIR/bin/activate" quinclas
  export GLOG_log_dir="$LOG_DIR"
  export GLOG_minloglevel=0
  /usr/bin/daemon --respawn --pidfile "$PIDFILE" --chdir "$CHDIR" --unsafe \
      -- "$CONDA_PREFIX/bin/quinclas-{{ item }}" --config "$CONFIG" --local-address "$SOCKET" --monitor-port "{{ gateway_ports[item] }}"
  ;;
  stop)
  /usr/bin/pkill -F "$PIDFILE" >/dev/null 2>&1
  ;;
esac
