# Definitions

* SAST: static application security testing
  * scans an application before the code is compiled
* DAST: dynamic application security testing
* MAST: mobile application security testing
* SCA: software composition analysis
  * automated process that identifies the open source software in a codebase
* RAT: Remote Access Trojan
* Pentest
* Fuzzing

* HIDS: host-based intrusion detection system
* NIDS: network-based intrusion detection system
* CRSF: Cross-Site Request Forgery.
* XXS: cross-site scripting
* WAF: Web Application Firewall
* IGPM: Internet Group Management Protocol, a braodcast protocol used in video games

* Shift-Left Testing: Test ASAP


* Intelligence and Obstruction (or Hindrance)

# OWAP top 10

1. __Broken Access Control__
2. __Cryptographic Failures__
3. __Injection__
4. __Insecure Design__
5. __Security Misconfiguration__
6. __Vulnerable and Outdated Components__
7. __Identification and authentication failures__
8. __Software and Data Integrity Failures__
9. __Security Logging and Monitoring Failures__
10. __Server-Side Request Forgery__

---

1. __Broken Access Control__
  * For example, a web application might allow a user to access another user’s account by modifying the provided URL.
  * Bypass access control checks
  * Unauthorized access to accounts
  * Unauthorized creation, reading,
	* Updating and deletion of data
  * Elevation of privilege
  * Privacy and regulatory impacts
  * The biggest breaches and largest costs
2. __Cryptographic Failures__
  * For example, an organization might use an insecure hash algorithm for password storage, fail to salt passwords, or use the same salt for all stored user passwords.
  * Some facets of “Sensitive Data Exposure”
  * Missing or ineffective data at rest controls
  * Missing or ineffective TLS
  * Missing or ineffective configuration
3. __Injection__
  * For example, SQL commonly uses single (‘) or double (“) quotation marks to delineate user data within a query, so user input containing these characters might be capable of changing the command being processed
  * SQL injection
  * XSS
  * JS injection
4. __Insecure Design__
  * For example, if the design for an application that stores and processes sensitive data does not include an authentication system, then a perfect implementation of the software as designed will still be insecure and fail to properly protect this sensitive dat
5. __Security Misconfiguration__
  * Examples of security misconfigurations could include enabling unnecessary applications or ports, leaving default accounts and passwords active and unchanged, or configuring error messages to expose too much information to a user
6. __Vulnerable and Outdated Components__
  * For example, an application may import a third-party library that has its own dependencies that could contain known exploitable vulnerabilities.
7. __Identification and authentication failures__
  * For example, an application that lacks multi-factor authentication (MFA) might be vulnerable to a credential stuffing attack in which an attacker automatically tries username and password combinations from a list of weak, common, default, or compromised credentials
8. __Software and Data Integrity Failures__
9. __Security Logging and Monitoring Failures__
10. __Server-Side Request Forgery__

Ref: https://www.checkpoint.com/cyber-hub/cloud-security/what-is-application-security-appsec/owasp-top-10-vulnerabilities/

* Virus List

| Virus    | Year | Description |
| ---      | ---  | --- |
| Stuxnet  | 2010 | Target SCADA Iran nuclear facilities |
| Hive     | 2020 | 1-day RansomWare RaaS, Hacked ALMA |
| Spectre  | 2017 |   |
| WannaCry | 2017 |   |
| ZeuS     | 2007 |   |


From Net

| Virus        | Year | Description |
| ---          | ---  | --- |
| Mydoom       | 2004 | Phising worm |
| SoBig        | 2003 | Phishing worm trojan |
| Klez         | 2001 | Phishing worm |
| ILoveYou     | 2000 | Phishing worm with LOVE LETTER from Philippines student |
| WannaCry     | 2017 | 1-day Ransomware, Blocked US hospitals |
| Zeus         | 2007 | Web theft, botnet, 100 people arrested in US, Source code released in 2011 |
| Code Red     | 2001 | Worm, "Hacked by Chinese!", RAM only |
| Slammer      | 2003 | SQL worm, targeting banks |
| CryptoLocker | 2013 | Ransomware |
| Sasser       | 2004 | From a 17 years-old German |
| Agent Tesla  | 2021 | RAT, exfiltrate credentials, log keystrokes, and capture screenshots |
| Shlayer      | 2021 | Dropper for MAC |
  

# Most common attacks

1. Software vulnerability exploit
2. Supply chain/third-party breach
3. Web application exploit (SQLi, XSS, RFI)
2. Phishing
2. Social engineering
2. Use of weak or stolen credentials
2. Strategic web compromise
2. Malspam
2. Abuse of administrator tools
2. Exploitation of lost/stolen asset
