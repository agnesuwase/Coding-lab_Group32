#!/bin/bash

process_vitals() {
    echo "Scanning for critical readings..."
    > reports/critical_alerts.txt
    echo "Timestamp | Device_ID | Value" >> reports/critical_alerts.txt
    echo "-----------------------------------" >> reports/critical_alerts.txt

    for logfile in active_logs/heart_rate_log.log active_logs/temperature_log.log; do
        [ -e "$logfile" ] || continue
        grep "CRITICAL" "$logfile" | awk -F' \\| ' '{print $1, "|", $2, "|", $3}' >> reports/critical_alerts.txt
    done

    echo "Critical alerts saved to reports/critical_alerts.txt"
}

process_vitals
