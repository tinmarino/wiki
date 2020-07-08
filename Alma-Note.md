
* SystemErr.xml -> SYSTEMErr.xml (https://confluence.alma.cl/display/ICTACS/ACS+Workshop+-+Interfaces)

# Jenkins

jobs 840Gb
/var/lib/jenkins/jobs/2019SEP-TelCalSA-Build/config.xml

# Docker

docker build -t acs-centos7 .
docker run -it -v {path-to-almasw-repo}:/home/jenkins/almasw -u jenkins -w /home/jenkins acs-centos7

# Security

At this point, full defensive cyber-security is too late: architecture, software is already built even if some mitigations can be stacked easily and some services can be refactored.
A pragmatic apporach, used in this case, is called [Penetration testing](https://en.wikipedia.org/wiki/Penetration_test). This approach is based on the fact that it is 10-100 times easyer to attack a system than to defend it. The Wikipedia page have a roadmap. Here is an draft one

Cyber-security roadmap:

1. Identify the [attack surface](https://en.wikipedia.org/wiki/Attack_surface) (alias exposition surface from white hat hackers) = documentation. Time: 10-40h
2. Continuous watch of the [Common Vulnerability and Exposures](https://en.wikipedia.org/wiki/Common_Vulnerabilities_and_Exposures()) entering in the attack surface. Time: 8h/month
3. Evaluate the impact of vulnerabilities, the system resilience = are there mitigations. Time: 2h/vulnerability
4. Evaluate the price of changes. Time: 1-10h/potential change
5. Create a ticket for next release. Time: 3h/month in the tiket votation.



