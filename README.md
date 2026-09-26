Coding-lab_Group32
Project Overview: Shell scripting solution for Kenyatta National Hospital's sensor data pipeline.

Scripts
- hospital_system.py: Core simulator engine (Heart Rate, Temperature, Water Usage)
- hospital_admin.sh: Sets up and secures the environment
- hospital_analysis.sh: Analyzes vitals and water usage
- hospital_archive.sh: Rotates and archives logs

Group roles
- Agnes Uwase: GitHub repository, .gitignore, and this README
- Mireille Umutoni: hospital_system.py, the data engine
- Favour Kebei: hospital_admin.sh (initialize_system, secure_data, and script execution)
- Genereuse: process_vitals() in hospital_analysis.sh (critical heart-rate and temperature alerts)
- Regis Ndizihwe: water_audit() in hospital_analysis.sh, and hospital_archive.sh (log rotation)

How to run
1. Create the folders and lock down active_logs:
   bash hospital_admin.sh
2. Start the sensor engine:
   python3 hospital_system.py start
3. Scan heart-rate and temperature logs for CRITICAL rows. Results go to reports/critical_alerts.txt:
   bash hospital_analysis.sh
4. Move the current logs into archived_logs with a timestamp, then leave empty log files so the engine can keep writing:
   bash hospital_archive.sh
5. Stop the engine when you are finished:
   python3 hospital_system.py stop

active_logs/, archived_logs/, and reports/ are listed in .gitignore and must stay off GitHub.
