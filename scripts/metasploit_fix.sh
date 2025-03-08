#!/bin/bash

LOG_FILE="../logs/metasploit_fix.log"
mkdir -p ../logs
echo "$(date) - Running Metasploit database fix" | tee -a $LOG_FILE

echo "🔍 Checking PostgreSQL service..." | tee -a $LOG_FILE
sudo systemctl status postgresql | tee -a $LOG_FILE

echo "🔄 Restarting PostgreSQL..." | tee -a $LOG_FILE
sudo systemctl restart postgresql | tee -a $LOG_FILE

echo "🛠 Reinitializing Metasploit database..." | tee -a $LOG_FILE
sudo msfdb init | tee -a $LOG_FILE

echo "✅ Metasploit database fixed and ready!" | tee -a $LOG_FILE
