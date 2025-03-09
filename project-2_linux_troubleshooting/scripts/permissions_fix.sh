#!/bin/bash

LOG_FILE="../logs/permissions_fix.log"
mkdir -p ../logs
echo "$(date) - Running permission fixer" | tee -a $LOG_FILE

read -p "🔍 Enter the file or directory path to fix: " PATH_TO_FIX

if [ -e "$PATH_TO_FIX" ]; then
    echo "🔄 Analyzing file type..." | tee -a $LOG_FILE
    
    if [ -d "$PATH_TO_FIX" ]; then
        echo "📂 Detected a directory. Applying directory permissions..." | tee -a $LOG_FILE
        sudo chmod -R 755 "$PATH_TO_FIX"
    else
        echo "📄 Detected a file. Applying file permissions..." | tee -a $LOG_FILE
        sudo chmod 644 "$PATH_TO_FIX"
    fi

    sudo chown -R $USER:$USER "$PATH_TO_FIX"
    echo "✅ Permissions fixed for $PATH_TO_FIX" | tee -a $LOG_FILE
else
    echo "❌ Error: Path does not exist!" | tee -a $LOG_FILE
fi
