#!/bin/bash

# Log Analyzer Script
# Demonstrates grep, awk, and sed for log analysis

# Default log file location for macOS
DEFAULT_LOG="/var/log/system.log"

# Colors for output
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Function to display section headers
section() {
    echo -e "\n${GREEN}===== $1 =====${NC}"
}

# Check if log file exists and is readable
if [ ! -r "$DEFAULT_LOG" ]; then
    echo -e "${YELLOW}Warning: Cannot read default log file: $DEFAULT_LOG${NC}"
    echo "Please run this script with sudo or specify a log file with -f option"
    echo "Usage: $0 [-f /path/to/logfile]"
    exit 1
fi

# Parse command line arguments
while getopts "f:" opt; do
    case $opt in
        f) LOG_FILE="$OPTARG" ;;
        *) echo "Usage: $0 [-f /path/to/logfile]" ; exit 1 ;;
    esac
done

# Use default log file if none specified
LOG_FILE=${LOG_FILE:-$DEFAULT_LOG}

# Check if the specified log file exists and is readable
if [ ! -r "$LOG_FILE" ]; then
    echo -e "${RED}Error: Cannot read log file: $LOG_FILE${NC}"
    exit 1
fi

# Clear the screen
clear

# Display header
echo -e "${GREEN}=============================="
echo "      LOG FILE ANALYZER"
echo "==============================${NC}"
echo "Analyzing: $LOG_FILE"
echo "Current time: $(date)"

# 1. Basic log statistics
section "LOG FILE STATISTICS"
echo "Total lines: $(wc -l < "$LOG_FILE")"
echo "First log entry: $(head -1 "$LOG_FILE" | sed 's/^[^A-Za-z]\+//')"
echo "Last log entry: $(tail -1 "$LOG_FILE" | sed 's/^[^A-Za-z]\+//')"

# 2. Error and warning counts
section "ERRORS AND WARNINGS"
ERROR_COUNT=$(grep -i -c -E 'error|fail|failed|critical' "$LOG_FILE")
WARN_COUNT=$(grep -i -c -E 'warn|notice' "$LOG_FILE")

echo -e "${RED}Total Errors: $ERROR_COUNT${NC}"
echo -e "${YELLOW}Total Warnings: $WARN_COUNT${NC}"

# 3. Recent errors (last 5)
echo -e "${RED}Recent Errors:${NC}"
grep -i -E 'error|fail|failed|critical' "$LOG_FILE" | tail -5 | sed 's/^/  /'

# 4. Recent warnings (last 5)
echo -e "\n${YELLOW}Recent Warnings:${NC}"
grep -i -E 'warn|notice' "$LOG_FILE" | tail -5 | sed 's/^/  /'

# 5. Top processes generating logs
section "TOP PROCESSES IN LOGS"
awk '{print $5}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{printf "  %-8s %s\n", $1, $2}'

# 6. Log entries by hour (last 24 hours)
section "ACTIVITY BY HOUR (LAST 24H)"
if [[ "$LOG_FILE" == "/var/log/system.log" ]]; then
    # For system.log which includes timestamps
    grep "$(date -v-24H +'%Y-%-m-%-d %H')" "$LOG_FILE" | \
    awk '{print $3}' | \
    cut -d: -f1 | \
    sort | uniq -c | \
    awk '{printf "  %2s:00 - %2s:00 : %4s entries\n", $2, $2, $1}'
else
    # For other log files that might have different timestamp formats
    echo "Hourly statistics not available for this log file"
fi

echo -e "\n${GREEN}Analysis complete.${NC}"
echo -e "Use 'grep', 'awk', and 'sed' to further analyze the logs."
echo -e "Example: grep -i error $LOG_FILE | tail -20${NC}"
