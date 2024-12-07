#!/bin/bash

# Define the log directory and file
LOG_DIR="/var/log/sessions"
LOG_FILE="${LOG_DIR}/session_$(date +%Y%m%d%H%M%S).log"

# Create the log directory
mkdir -p $LOG_DIR

# Start session recording
script -q -f $LOG_FILE &

# Run the Node.js application
exec node app.js
