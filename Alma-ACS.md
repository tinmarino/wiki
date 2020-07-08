# Questions

- ? What is the process responsible for NotifyService, for ORB transactions, is Corba a delocalised service ?
  - . The NotifyService is called via library in the ACS
  - . The message format is defined in IDL and then included
  - . The transaction (alias comunication) protocole seems to be in ACS ThirdParty headers, lib (TAO)
  - ? What process is actually communicating:
    - ? myself: the process I compile (ex: car_control)
    - ? A TAO, JavaORB__ service running in background, one or many.
  - ? Is the notify/subscribe protocol architecturaly diferent: I guess so because actor (process) relations are different.
  - ? Is the name of the channel enought to get subscription or do the subscriber need to PID, hostname coordinates
  - ? Can a notifier check who is subscribing to it ? (retrocontrol may not be overkill: like if no-one is listening why should I speak)
  - ? Is the Archive team responsible to also keep the logs
- ? How much can I test locally (meaning NOT ONLINE machine, so testing, failure is bening)
  - . I imagine no problem for unit-test, API test but for system testing it may be hard.
- ? What is the name of ONLINE, real-time maintenance: "validation", "verification", "test". I mean the process to control everything works fine during acquisition.
  - Is this harder, are there some specific machine supervising the others
- ? Is someone from ICT needed on site OSF, what cannot we do from Santiago

# Releease at ALma

Phase A: tests performed by the developer - 4 weeks
Phase B: tests performed by IRM - 3 weeks
Phase C: validation from the subsystems scientists - 1 week

Proposal submission
Data Acquisition
Data Processing
Data Delivery


# Overview
    
* Model driven with code generation (IDL)
* Manager > Container > Component && Channels


# Links
* Hands on: https://confluence.alma.cl/display/ICTACS/Configuring+ACS
* Excercices: http://www.eso.org/~almamgr/AlmaAcs/OtherDocs/ACSPapersAndSlides/ACS-Course/Exercises/
* IDL: https://github.com/ACS-Community/ACS-Workshop
* Online Doc @ ESO: http://www.eso.org/projects/alma/develop/acs/OnlineDocs/index.html

# Hands on

* source /alma/ACS-<version>/ACSSW/config/.acs/.bash_profile.acs

# Tests

* __Class level:__ alias unit test
* __Component level:__ IDL interface access (API)
* __Systel level:__ alias end-to-end

# Services

## Logging
* Base on Notification Service  
* Client: jlog: ENGINEER, OPERATOR, SCILOG
* Level: Trace (1), Delouse (2), Debug (3), Info (4), Notice (5), Warning (6), Error (8), Critical (9), Alert (10), Emergency (11), Off (99)
* Archive: RDB
* Performance: Transparent caching, transfert async in batch
* Env: `$ACS_LOG_[STDOUT|CENTRAL|FILE]`
* Files:
  * ACSErrTypeCommon.xml
  * ACS_LOG_FILE (or default $ACS_TMP/<hostname>/acs_local_log_<processname>
* Links:
  * http://almasw.hq.eso.org/almasw/bin/view/HLA/LoggingErrorAlarmsGuidelines
  * http://www.eso.org/projects/alma/develop/acs/OnlineDocs/Logging_and_Archiving.pdf


## Messaging
* request/response: Corba messaging
* publish/subscribe: Notify Service

## Error management 
* Trace: Linked-List
* Links:
  * http://www.eso.org/projects/alma/develop/acs/OnlineDocs/ACS_Error_System.p
df


## Alarms

## Configuration data


# Install

ksh \
gcc \
libx11-dev \
libffi-dev \
perl \
libreadline-dev \
bzip2 \
openssl-dev
openldap-dev
libxml2-dev
freetype-dev
libxslt-dev
sqlite-dev
expat-dev
bison \
flex \
autoconf \
unzip \
dos2unix \
tcl-dev \
tk-dev \

## Third party

gcc: 4.8.5 RHEL 7.6
java: openjdk-11.0.4
python: 2.7.16 and 3.6.9
ACE: 6.4.3
TAO: 2.4.3
mico: 2.3.13
JacORB: 3.9
omniorb: 4.2.3
