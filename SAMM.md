# Notes

* Don't try to be more matrue on the security than its underlying practices
* Practices and Process can be a catalyser or a limit of the overall security
* Don't make it harder for your internal team than for your suppliers
* Socialize, make sure you have embasador of your improvement program


1. Select the scope: Company, Group, System, Application, Project Team
2. Asset
3. Set improvement target
4. Set roadmap to target, it usually takes 2 years
5. Work towards target

Agnotic on:

1. Techno (Python or Java)
2. Process (Waterfall or agile)
3. Organisation (small or big)

# Divide and conquer

* 5 Business Functions: (1) Governance, (2) Desgin, (3) Implemetation, (4) Verification, (5) Operation
* 3 Security practices per function
* 2 Stream per security practices
* 3 activity per stream
* 3 questions per activity



# Design

### Security Requirements


### Secure Architecture: Security principle

Ver OWASP: https://cheatsheetseries.owasp.org/cheatsheets/Secure_Product_Design_Cheat_Sheet.html

As a basic start, establish secure defaults, minimise the attack surface area, and fail securely to those well-defined and understood defaults.

1. **Least Privilege**: Users should have the minimum level of access necessary to perform their tasks.
2. **Defense in Depth**: Implement multiple layers of security controls to protect sensitive data.
3. **Economy of mechanism**: Keep the design as simple and small as possible.
4. **Fail-Safe Defaults**: Systems should default to a secure state, denying access unless explicitly granted.
5. **Least common mechanism**: Minimize subsystems shared between or relied upon by mutually distrusting users.
6. **Separation of Duties**: Critical tasks should be divided among multiple individuals to reduce the risk of fraud or error.
7. **Open Design**: Security mechanisms should be open to scrutiny and not rely on secrecy for protection.
8. **Minimize Attack Surface**: Reduce the number of entry points to the system to limit potential vulnerabilities.
9. **Accountability**: Ensure that actions can be traced back to individuals, promoting responsible behavior.
10. **Data Encryption**: Sensitive data should be encrypted both in transit and at rest to protect against unauthorized access.
11. **Regular Updates and Patching**: Keep software and systems up to date to mitigate known vulnerabilities.
12. **Security by Obscurity**: Avoid relying solely on obscurity; security measures should be robust even if the system's design is known.

# Implementation
### Secure Build: Build Process

* At level 3, ensure that nobody can tamper the security check

### Secure Build: Software dependencies

* Get the version of all dependencies (recursively), and check them for each build



# Ref

* Conf 1: https://www.youtube.com/watch?v=Y7otI-AhOeU&list=PLL2wt4pQkkuJ6FU3Bv3xGEdp1ASCmcEgp
* Assesemtn Excel: https://owaspsamm.org/assessment/
