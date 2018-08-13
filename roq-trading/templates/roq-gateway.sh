#!/usr/bin/env bash

set -e

# Configuration
CONDA_DIR="/trading/infra/miniconda3"
LOG_DIR="/trading/logs"
VARIABLES="/trading/config/{{ item }}/variables.conf"
CONFIG="/trading/config/{{ item }}/master.conf"
LICENSE="/trading/config/{{ item }}/license.conf"
SOCKET="/var/tmp/{{ item }}.sock"
PIDFILE="/trading/run/.{{ item }}.pid"
CHDIR="/trading/run/{{ item }}"

# Parse options
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
  start)
  TYPE="start"
  shift
  ;;
  stop)
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
  source "$CONDA_DIR/bin/activate" roq
  export ROQ_log_dir="$LOG_DIR"
  export ROQ_v=0
  export LD_PRELOAD="$CONDA_PREFIX/lib/libtcmalloc.so" 
  /usr/bin/daemon --respawn --umask 0002 --pidfile "$PIDFILE" --chdir "$CHDIR" --unsafe -- \
      "$CONDA_PREFIX/bin/roq-{{ item }}" \
      --socket-buffer-size 10485760 \
      --spin-usecs 1000 \
      --timer-refresh-usecs 100 \
      --license-file "$LICENSE" \
      --config-variables "$VARIABLES" \
      --config-file "$CONFIG" \
      --local-address "$SOCKET" \
      --monitor-port "{{ gateway_ports[item] }}" \
      --name "roq_{{ item }}"
  ;;
  stop)
  /usr/bin/pkill -F "$PIDFILE" >/dev/null 2>&1
  ;;
esac
