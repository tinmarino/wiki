% Git Wiki


*   Store credentials

`git config --global credential.helper cache`
Tells Git to keep your password cached in memory for (by default) 15 minutes. You can set a longer timeout with:
`git config credential.helper store`
Stores permanently
Note: While this is convenient, Git will store your credentials in clear text in a local file (.git-credentials) under your project directory (see below for the "home" directory). If you don't like this, delete this file and switch to using the cache option.


# Tips

### Ugly tips from draft
git ls-files
git ls-tree --full-tree -r HEAD
git cherrypick <commit_sha1>
git add -p # add by chunk (remember patch)

* Clone only last commit
  * `git clone --depth=1 http://www.github.com/toto/project.git`

* Disable security check (https)
  * `git -c http.sslVerify=false origin master`

* Unstage all
    * `git reset HEAD`

* Stop tracking
    * `git rm --cached file`

* Ignore Windows newline
    * `git config --global core.autocrlf true`

* Get statistic lines changed stats
    * `git diff --stat`

* Make backup
    *  `git stash && git stash apply`

* Aliasing
  * `git config --global alias.wdiff diff --color-words`
  * Edit `~/.gitconfig`
    ```
      [alias]
          wdiff = diff --color-words
    ```
* Word by word diff
  * `git diff --color-words`

* Checkout all the files
	* `git checkout -- .`

Choose ours ours (master) theirs (current branch) automaticcaly in case of conflict

	git rebase -Xtheirs branch-b
	git merge -Xours origin/master
	git checkout --ours foo/bar.java
	git add foo/bar.java


Merge unrelated history (to merge different project)

	--allow-unrelated-histories 

Ignore file mode (755 in chmod)
	
	git config core.fileMode false

Aliasing

  git config --global alias.wdiff diff --color-words`
  // Edit `~/.gitconfig`
	[alias]
			wdiff = diff --color-words
			
Word by word diff
	git diff --color-words

*	Personal gitignore
  * `git config --local -e`
  * We want to edit the git config of the repository we’re in. The —-local flag specifies that we’re editing the config of just this repository and the —e flag tells git to edit the config. For more info on this, run git config to see all of the options.
  * 
	```
	[core]

		... (existing configurations)
		excludesfile = ~/Documents/my_repo/.local_gitignore

	[remote "origin"]

		... (existing configurations)

	[branch "master"]

		... (existing configurations)
	```
  * Add the line in the core and then edit your .local_gitignore

*   Ignore Windows newline
    *   `git config --global core.autocrlf true`

*	Show word regex in diff
	*	`git diff --word-diff-regex=.`


# Change history

## Analyse

* To see which commit modified the file
    * `git log --all -- <filepath accepting *>`
    * `git log --all --full-history -- **/thefile.*`
    * 

* `git rebase -i <commit>~1`          # Can edit or delete commits  


0. List
1. Start
2. Config
3. Aliases
4. Branches
5. Merge
6. Rebasing
7. Remote
8. Local



# 0. Stack


	git clone --recursive <URL-OF-REPOSITORY> 
CLONE in non empty directory 
   git init
   git remote add origin PATH/TO/REPO
   git fetch
   git checkout -t origin/master
      or 
   git reset origin/master
https://github.com/vim-scripts
# 0. List


### 	Setup and config 
		-> config 
		-> help 
### 	Getting and Creating project 
		-> init 
		-> clone 
### 	Basic Snapshotting 
		-> add 
		-> status 
		-> diff
		-> commit 
		-> reset
		-> rm 
		-> mv
### 	Branching and Merging 
		-> branch 
		-> checkout 
		-> merge
		-> mergetools 
		-> log 
		-> stash 
		-> tag 
### 	Sharing and updating project ~
		-> fetch 
		-> pull
		-> push 
		-> remote 
		-> submodule 
### 	Inspection and comparaison 
		-> show 
		-> log 
		-> diff 
		-> rebase 
		-> revert 
### 	Debugging 
		-> bisect
		-> blame 
		-> grep 
### 	Email 
		-> am
		-> apply 
		-> format-patch 
		-> send-email 
		-> request-pull
### 	External system 
		-> svn
		-> fast-import 
### 	Administration 
		-> clean 
		-> gc 
		-> fsck 
		-> reflog
		-> filter -branch 
		-> instaweb, 
		-> arcive 
		-> bundle 
### 	Server Admin 
		-> daemon 
		-> update-server_info 
### 	Plumbing-commands 
		-> cat-file
		-> commit-tree 
		-> count-objects
		-> diff-index 
		-> for-each-ref
		-> hash-object 
		-> ls-files
		-> merge-base 
		-> read-treee
		-> rev-list 
		-> rev-parse 
		-> show-ref 
		-> symbolic-ref 
		-> update-index
		-> update-ref 
		-> verify-pack 
		-> write-tree


# 1. Init

```
	git init 
	git add LICENSE.txt
	git commit -m 'first commit'

	git clone https://github.com/libgit2 mylibgit
```

# 2. Config

```
	git config --global user.name "Martin T"
	git config --global user.email tbf@tbf
			    core.editor vim 
	git config --list 	# See all config vars 
	git config user.name 	# See the var git is using for name 
```

# 3. Aliases

```
	git config --global alias.co checkout 	
	git config --global alias.br branch 
	git config --global alias.ci commit  	
	git config --global alias.st status 

	git config --global alias.unstage 'reset HEAD --'
	git config --global alias.last 'log -1 HEAD'
```

# 4. Branches


	
	-> Each Commit has a pointer to the previous commit 
	-> The default branch name is master *git-master* .
	-> HEAD is a pointer pointing to the current branch 
```
	git branch testing 
<		Creates a new pointer at the same commit you're currently on 
```
	git checkout testing 
	git checkout -b testing # creates the branch and go in it 
<		Moves HEAD to the testing branch  
	
	-> Switching to a branch changes the working directory 
```
	git branch 
	git branch -v 	# see the last commit 
	git branch -m <oldname> <newname>  
<		rename a branch 
```
	git branch [--no-merged] [--merged]
<		Lists all Branches 
```
	git log --oneline --decorate --graph --all 
< 		Shows where branch pointers are
	-> Creating a branch is just creating a 41 byte pointer (to a sha-1) in a file 

# 5. Merge


	-> You want to merge myBranch into master 
```
	git checkout master
	git merge myBranch
<		If you changed the same part of the same file differently, this will cause confict. So this won't auto-merge and you have to resolve the conflict and then commit.
```
	git status 
<		To see the conflict 
	Open the files manually to resolve the conflict and add them to the stage to remove them from conclicting files
```
	git mergetool
```
```
	git branch -d myBranch 
<		To deleta a branch, usefull if this branch is already merged 


# 6. Rebasing

	-> Get the change one branch applied to the most common ancestor and apply this change to the other branch 
```
	git rebase --onto master server client
<		Check client branch, figure the changes from the common
ancestor with client and apply these changes to master
```
	git rebase master server 
	git checkout master 
	git merge server
	git branch -d server
<		Replay server changes on master branch 
		Then go to the master branch (without the server applyed) 
		And merge both branch so master and server are now one branch 
		Remove the server branch, not usefull anymore 

	-> Don't rebase commits that exist outside your repository 

# 7. Remote


```
	git remote add maisonDir D:\Iso\VimMaison
```
```
	git ls-remote (remote) 
	git remote show (remote) 
<		To see all remote vars 
	-> Origin is the default name for a remote when you run git clone *git-origin*
```
	git fetch origin 
< 		Fetch data from origin into a new branch called origin/master 
```
	git push (remote) (branch) 
<		Take my local branch and update the remote origin branch (with the same name) 
```
	git checkout -b serverfix origin/serverfix 
<		This gives a local branch where origin/serverfix was 

	-> Tracking branches are local branches that are looking to remote branches. When you git clone, your master branch is tracking origin/master. You can then update master with "git pull". From a tracking branch, git pull will act as git fetch and git merge  

# 8. Remote

```
	git remote add local_proc /opt/git/projct.git 
	git pull /home/john/project 
```

# 9.
