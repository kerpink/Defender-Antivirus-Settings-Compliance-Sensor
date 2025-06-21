# Defender Antivirus Compliance Sensor

A lightweight PowerShell sensor script that evaluates core Microsoft Defender Antivirus settings for compliance against enterprise baselines. Outputs result in a pipe-delimited format suitable endpoint management tools like Tanium, SCCM, etc.

---

## Purpose

Defender Antivirus settings are critical for endpoint protection, yet visibility is often limited in large or decentralized environments. This sensor helps security teams and IT administrators:

- Continuously validate Defender Antivirus configurations
- Detect drift from expected security baselines
- Feed results into custom dashboards and compliance reports
- Integrate compliance telemetry with Tanium, Intune, SCCM, or custom platforms

---

## Key Features

- Evaluates essential Defender Antivirus protection settings:
  - Tamper Protection
  - Real-Time Protection
  - Cloud Protection Level
  - Cloud Block Timeout
  - Antivirus Engine Status
  - Network Protection
- Compares actual values against expected configurations
- Outputs structured compliance status for each setting
- Functions as a **custom compliance sensor** for:
  - Microsoft Intune
  - Tanium Interact / Trends
  - GRC dashboards
  - Enterprise audit automation

---

## Example Output
Tamper Protection|True|True|True|Compliant|Prevents unauthorized changes to Defender|PowerShell
Cloud Protection|2|1|False|Non-Compliant|Advanced cloud protection|PowerShell
Realtime Protection|True|False|False|Non-Compliant|Real-time protection against threats|PowerShell


---

## Output Format
Setting Name|Expected Value|Actual Value|Compliant|Compliance Status|Description|Source
pgsql

| Field             | Description                                              |
|------------------|----------------------------------------------------------|
| Setting Name      | Defender AV configuration item                          |
| Expected Value    | Baseline-compliant value                                |
| Actual Value      | Current system value                                    |
| Compliant         | Boolean (True/False)                                    |
| Compliance Status | "Compliant" or "Non-Compliant"                          |
| Description       | What the setting protects or controls                   |
| Source            | Data source (PowerShell, WMI, registry, etc.)           |

---

## Sensor Deployment Options

- **Tanium Sensor:**  
  Integrate as a scheduled or real-time sensor. Return the full output string per endpoint and aggregate in dashboards.

- **Microsoft Intune Custom Compliance:**  
  Package as part of a compliance policy. Use pipe-delimited parsing to evaluate compliance centrally.

- **Standalone Script Execution:**  
  Run interactively, via remote PowerShell, or embedded in other scripts.

---


## License
This project is licensed under the MIT License.

## Author
Kerpink Williams
Cybersecurity Engineer 
LinkedIn: https://www.linkedin.com/in/kerpink-williams/
Medium: https://medium.com/@kerpinkwilliams

