# Overview
    
ksh
gcc
libx11-dev
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


* Model driven with code generation (IDL)
* Manager > Container > Component && Channels

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
