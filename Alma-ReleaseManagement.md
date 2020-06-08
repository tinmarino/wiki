
* Online subsystems: CONTROL, ACACORR, BLCORR, SCHEDULING, TELCAL and ARCHIVE-ONLINE (mature)
* Offline subsystems: OBOPS (Observing Operations), ARCHIVE, OBSPREP (Observing Preparation) and SPT-PIPE (Pipeline).



# Lifecycle

1. Requirement Capture
  1. Identify high-level components functionalities by their interfaces
2. Implementation
  1. IDL Interface
  2. Component simultation
  3. Component Interface implementation
  4. System test
  5. Component functionality implementation
3. Integration


# Git
* Any attempted delivery merge which shows a conflict, how ever harmless it may be, will be cancelled and rejected immediately.
  * So merge regularly in a feature branch from master and solve conflict in feature branch
* Bypassing a branch is not permitted: merge master > october > november and not directly master > november if there is an older branch pending
* Bugs:
  1. Non blocking => next release: don't block operations, should normally be fixed as part of the next upcoming regular release
  2. Blocking => stable (master) branch
* no merging into the past!
* Bug fixes are merged directly to master


# Validation
* All the binaries for validation shall be created from master once pull request have been merged: Buildfarm jobs

