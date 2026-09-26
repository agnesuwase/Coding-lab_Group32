#!/bin/bash

process_vitals() {
    echo "Scanning for critical readings..."
    > reports/critical_alerts.txt
    echo "Timestamp | Device_ID | Value" >> reports/critical_alerts.txt
    echo "-----------------------------------" >> reports/critical_alerts.txt

    for logfile in active_logs/heart_rate_log.log active_logs/temperature_log.log; do
        [ -e "$logfile" ] || continue
        # Fields are separated by " | " (space-pipe-space) as written by hospital_system.py
        # $1=Timestamp $2=Device_ID $3=Value (Status is $4, already filtered by grep above)
        grep "CRITICAL" "$logfile" | awk -F' \\| ' '{print $1, "|", $2, "|", $3}' >> reports/critical_alerts.txt
    done

    if [ "$(wc -l < reports/critical_alerts.txt)" -le 2 ]; then
        echo "No CRITICAL readings found during this scan." >> reports/critical_alerts.txt
    fi

    echo "Critical alerts saved to reports/critical_alerts.txt"
}

water_audit() {
    # Fields: $1=Timestamp $2=Device_ID $3=Usage (Liters/min) $4=Status
    avg=$(awk -F' \\| ' '$2 == "ICU_WATER_RESERVE" { sum += $3; count++ }
        END { if (count > 0) printf "%.2f", sum / count }' active_logs/water_usage_log.log)
    echo "Average ICU_WATER_RESERVE usage: $avg L/min"
}

process_vitals
