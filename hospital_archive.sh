#!/bin/bash
 
archive_logs() {
    mkdir -p archived_logs
    timestamp=$(date +"%Y%m%d_%H%M")
 
    for file in active_logs/*.log; do
        name=$(basename "$file" .log)
        mv "$file" "archived_logs/${name}_${timestamp}.log"
        touch "$file"
    done
}

