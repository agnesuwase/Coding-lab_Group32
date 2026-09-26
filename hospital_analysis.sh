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
    # Collect reading count, average, min, max and HIGH_USAGE count in one awk pass
    read -r count avg min max high <<< "$(awk -F' \\| ' '
        $2 == "ICU_WATER_RESERVE" {
            count++; sum += $3
            if (count == 1 || $3 < min) min = $3
            if (count == 1 || $3 > max) max = $3
            if ($4 == "HIGH_USAGE") high++
        }
        END { printf "%d %.2f %d %d %d", count, (count ? sum / count : 0), min, max, high }
    ' active_logs/water_usage_log.log)"

    printf "\n========== KNH Water Audit ==========\n"
    printf "%-22s %s\n"          "Device:"         "ICU_WATER_RESERVE"
    printf "%-22s %d\n"          "Readings analysed:" "$count"
    printf "%-22s %.2f L/min\n"  "Average usage:"  "$avg"
    printf "%-22s %d L/min\n"    "Minimum usage:"  "$min"
    printf "%-22s %d L/min\n"    "Maximum usage:"  "$max"
    printf "%-22s %d\n"          "HIGH_USAGE alerts:" "$high"
    printf "=====================================\n"
}

process_vitals
