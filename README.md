🛡️ Sysmon Deployment Script

Automate the deployment, update, and configuration of Sysmon across Windows machines in an Active Directory (AD) environment. This script can be run manually for testing or automatically via a Group Policy Object (GPO).

✨ Features

📂 Copies the Sysmon configuration file to each machine

⚡ Installs Sysmon if not present

🔄 Updates configuration if Sysmon is already installed

▶️ Ensures the Sysmon service is running

📝 Logs actions (optional debug version)

🔧 Fully configurable network share and local paths

🛠️ Requirements

Windows machines joined to an Active Directory domain

A network share accessible by all target computers containing:

sysmon.exe

config.xml

sysmon.bat (script)

Read permissions for the SYSTEM account on target machines

🚀 Usage

💻 Local Testing

Copy all files to a local folder on a test machine (e.g., C:\SysmonTest)

Update the batch script paths:
SET CONFIG_SRC=C:\SysmonTest\config.xml
SET CONFIG_DEST=C:\Windows\config.xml
SET SYSMON_EXE=C:\SysmonTest\sysmon.exe
Run as Administrator
Check log


🏢 Deployment via GPO

Place all files on a network share, e.g.: \\YourServer\SysmonShare\

Update batch script to point to the share: SET CONFIG_SRC=\\YourServer\SysmonShare\config.xml , SET SYSMON_EXE=\\YourServer\SysmonShare\sysmon.exe

Open Group Policy Management → Create a new GPO (e.g., Sysmon Deploy)

Edit GPO → Computer Configuration → Policies → Windows Settings → Scripts → Startup → Add the batch script

Link the GPO to the OU containing your computers

🔄 On next reboot, each PC will automatically install/update Sysmon and apply the configuration

⚠️ Notes

Test on 1–2 machines before deploying domain-wide

Script can run from a network share; no need to copy to System32

Keep sysmon.exe and config.xml up-to-date for new deployments or updates

🖊️ Author & Date

Author: t8ddyxrd

Date: September 16, 2025

This repository is provided as-is for educational and administrative purposes. Use responsibly within your own network or lab.
