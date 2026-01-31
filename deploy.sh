#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: $0 <path>"
    exit 1
fi 

LOG_FILE=$1

if [ ! -f "$1" ]; then
    echo "File does not exist"
    exit 1
fi 

echo "--- Top 5 IP Addresses by Request Count ---"

awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

echo
echo "----- Top 5 most requested path ---------"

awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 "  requests"}'

echo
echo "----- Top 5 most response status codes ---------"

awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5 | awk '{print $2 " - " $1 " requests"}'

