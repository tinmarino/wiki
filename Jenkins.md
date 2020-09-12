From: https://wiki.jenkins.io/display/JENKINS/Administering+Jenkins

# Restrict agent

* pipeline
  ```
  agent {
      node {
          label 'v-devel01.sco.alma.cl'
      }
  }
  ```
  * For no restiction:
  ```
  agent any
  ```
  

* Single job:
  1. Restrict where this project can be run
  2. Label expr: v-bfnode703.sco.alma.cl


# FileSystem


```
JENKINS_HOME
 +- config.xml     (jenkins root configuration)
 +- *.xml          (other site-wide configuration files)
 +- userContent    (files in this directory will be served under your http://server/userContent/)
 +- fingerprints   (stores fingerprint records)
 +- nodes          (slave configurations)
 +- plugins        (stores plugins)
 +- secrets        (secretes needed when migrating credentials to other servers)
 +- workspace (working directory for the version control system)
     +- [JOBNAME] (sub directory for each job)
 +- jobs
     +- [JOBNAME]      (sub directory for each job)
         +- config.xml     (job configuration file)
         +- latest         (symbolic link to the last successful build)
         +- builds
             +- [BUILD_ID]     (for each build)
                 +- build.xml      (build result summary)
                 +- log            (log file)
                 +- changelog.xml  (change log)
```
