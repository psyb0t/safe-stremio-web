#!/bin/bash

set -euo pipefail

# Function to log messages
log() {
    local message="$1"
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S")

    echo "$timestamp $message"
}

# Function to cleanly stop processes
cleanup() {
    log "Caught signal or error, stopping Nginx..."

    if [[ -n "${nginx_pid-}" ]]; then
        kill -SIGTERM "$nginx_pid" 2>/dev/null || true
        wait "$nginx_pid" 2>/dev/null || true
    fi

    log "All processes have been stopped. Exiting."
    exit 1
}

# Function to check the status of a process
check_process() {
    local pid=$1
    local name=$2
    if ! kill -0 "$pid" 2>/dev/null; then
        log "$name has terminated unexpectedly."
        cleanup
    fi
}

# Trap termination signals and errors
trap cleanup SIGINT SIGTERM ERR

AUTH_CONF_FILE="/etc/nginx/conf.d/auth.conf"
HTPASSWD_FILE="/etc/nginx/.htpasswd"

echo "" >$AUTH_CONF_FILE

# Setup authentication if environment variables are set
if [[ -n "${USERNAME-}" && -n "${PASSWORD-}" ]]; then
    log "Setting up HTTP basic authentication..."
    htpasswd -bc "$HTPASSWD_FILE" "$USERNAME" "$PASSWORD"
    echo 'auth_basic "Restricted Content";' >$AUTH_CONF_FILE
    echo 'auth_basic_user_file '"$HTPASSWD_FILE"';' >>$AUTH_CONF_FILE
else
    log "No HTTP basic authentication will be used."
fi

log "Starting Nginx..."
nginx -g 'daemon off;' &
nginx_pid=$!
if ! kill -0 $nginx_pid 2>/dev/null; then
    log "Failed to start Nginx."
    cleanup
fi

# Background loop to monitor the processes
while true; do
    check_process $nginx_pid "Nginx"

    sleep 1
done &

# Wait for all processes to finish
wait $nginx_pid
nginx_status=$?

# Check the exit statuses
if [[ $nginx_status -ne 0 ]]; then
    cleanup
else
    log "All processes completed successfully. Exiting."
    exit 0
fi
