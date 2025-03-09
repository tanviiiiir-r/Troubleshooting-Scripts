#!/bin/bash

LOG_FILE="/app/logs/permissions_fix.log"
mkdir -p /app/logs
echo "$(date) - Running permission fixer" | tee -a $LOG_FILE

# ✅ Get file path from argument
PATH_TO_FIX=$1

if [ -z "$PATH_TO_FIX" ]; then
    echo "❌ Error: No path provided!" | tee -a $LOG_FILE
    exit 1
fi

if [ -e "$PATH_TO_FIX" ]; then
    echo "🔄 Analyzing file type..." | tee -a $LOG_FILE
    
    if [ -d "$PATH_TO_FIX" ]; then
        echo "📂 Detected a directory. Applying directory permissions..." | tee -a $LOG_FILE
        chmod -R 755 "$PATH_TO_FIX"
    else
        echo "📄 Detected a file. Applying file permissions..." | tee -a $LOG_FILE
        chmod 644 "$PATH_TO_FIX"
    fi

    chown -R $USER:$USER "$PATH_TO_FIX"
    echo "✅ Permissions fixed for $PATH_TO_FIX" | tee -a $LOG_FILE
else
    echo "❌ Error: Path $PATH_TO_FIX does not exist!" | tee -a $LOG_FILE
    exit 1
fi

