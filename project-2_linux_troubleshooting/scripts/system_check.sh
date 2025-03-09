#!/bin/bash

LOG_FILE="../logs/system_check.log"
mkdir -p ../logs
echo "$(date) - Running system diagnostics" | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "🖥 System Uptime:" | tee -a $LOG_FILE
uptime | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "💾 Memory Usage:" | tee -a $LOG_FILE
free -m | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "💽 Disk Usage:" | tee -a $LOG_FILE
df -h | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "🔍 Checking CPU Load..." | tee -a $LOG_FILE
top -bn1 | grep "load average" | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "⚡ Top 10 Resource-Consuming Processes:" | tee -a $LOG_FILE
ps aux --sort=-%mem | head -10 | tee -a $LOG_FILE
echo "----------------------------------" | tee -a $LOG_FILE

echo "✅ System diagnostics complete!" | tee -a $LOG_FILE
