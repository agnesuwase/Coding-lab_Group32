#!/bin/bash
# hospital_admin.sh
# KNH Digital Infrastructure - Permissions & Setup
# Member 1: initialize_system()
# Member 2: secure_data()
# Member 3: orchestration logic

# ---------------------------------------------
# Member 1 (The Architect)
# ---------------------------------------------
initialize_system() {
    echo "Initializing KNH data environment..."

    if [ ! -d "active_logs" ]; then
        echo "Creating active_logs directory..."
        mkdir active_logs
    else
        echo "active_logs directory already exists."
    fi

    if [ ! -d "archived_logs" ]; then
        echo "Creating archived_logs directory..."
        mkdir archived_logs
    else
        echo "archived_logs directory already exists."
    fi

    if [ ! -d "reports" ]; then
        echo "Creating reports directory..."
        mkdir reports
    else
        echo "reports directory already exists."
    fi

    echo "Initialization complete."
}

# ---------------------------------------------
# Member 2 (The Security Lead)
# ---------------------------------------------
secure_data() {
    echo "Securing active_logs directory..."
    chmod 700 active_logs
    echo "Permissions updated. Only the owner can read and write in active_logs."
    echo "Current permissions:"
    ls -l -d active_logs
}

# ---------------------------------------------
# Member 3 (The Orchestrator)
# ---------------------------------------------
main() {
    initialize_system
    secure_data
    echo "System Environment Secured on $(date)"
}

main
