%Git Wiki

# Tips

```bash
git fetch wiki pull/982/head:pr_982   # wiki is the name I gave to the remote -> https://github.com/vimwiki/vimwiki/
git rev-parse --abbrev-ref HEAD  # Get branch name
git branch -a --contains b3fc085e3cf71df6ff01f858cc1cb9858cd5c290
git push <remote-name> <local-branch-name>:<remote-branch-name>
git branch -m old-name new-name # Rename branch 
g -c merge.driver.union rebase  origin/master 
```

### Pickaxe

Git can search diffs with the -S option (it's called pickaxe in the docs)

git log -Spassword  # word like --grep=word
git log -Gword  # regex

This will find any commit that added or removed the string password. Here a few options:

    -p: will show the diffs. If you provide a file (-p file), it will generate a patch for you.
    -G: looks for differences whose added or removed line matches the given regexp, as opposed to -S, which "looks for differences that introduce or remove an instance of string".
    --all: searches over all branches and tags; alternatively, use --branches[=<pattern>] or --tags[=<pattern>]


### Reset one commit
* git reset --hard HEAD^  # One
* git reset --hard HEAD~2  # Two

### Checkout to PR

Description: https://github.com/vimwiki/vimwiki/pull/982

```bash
git fetch wiki pull/982/head:pr_982   # wiki is the name I gave to the remote -> https://github.com/vimwiki/vimwiki/
git checkout pr_982

# Oh I must rebase because Tinmarino pushed some commit on dev after divergence and I want to get this line much clearer so let's forget Jeromg history, and put the diff in one commit
git checkout -b pr_reset_982   # create new branch for backup the pr_982
# Searching for last merge from 4431caf
git reset  4431caf
git diff
# Insepection, looking the changes
# => Lets go
git commit -m 'Feature: Utility function: linkify to extract link title from url (PR #982 from @jeromg)'
# I'm still down I mus tmove to the top
git rebase dev

    Loading the weapon

git checkout dev && git rebase pr_reset_982

    Fire ! : Warning: Point de non retour:

git push wiki
```



### Ugly tips from draft

* git push <remote_name> --delete <branch_name>  # or -d branch or :branch
* git commit --amend --no-edit # Amend without changing message
* git diff --cached (stage vs currznt dir)
* git diff --staged (stage vs commit)
* git config --list

, Rc conf


```sh
# In glo
git log --graph --color=always --format='%C(auto)%h%d %s %C(blue)%an %C(black)%C(bold)%cr'

# Old
--graph --color=always --abbrev=7 --format='%C(cyan)%h %C(blue)%ar%C(auto)%d %C(yellow)%s%+b %C(black)%ae' "$@"
--graph --color=always --abbrev=7 --format='%C(cyan)%h %C(blue)%ar%C(auto)%d %C(yellow)%s%+b %C(black)%ae' "$@"
```


* Add wisely
  * `git cherrypick <commit_sha1>`
  * `git add -p # add by chunk (remember patch)`

* Store credentials
  * `git config --global credential.helper cache` : Tells Git to keep your password cached in memory for (by default) 15 minutes. You can set a longer timeout with:
  * `git config credential.helper store` : Stores permanently
  * Note : While this is convenient, Git will store your credentials in clear text in a local file (.git-credentials) under your project directory (see below for the "home" directory). If you don't like this, delete this file and switch to using the cache option.

* Submodules
  * `git submodule update --recursive --remote --jobs 8`
  * `git submodule sync`  # after modyfing .gitmodules
  * `git pull --recurse-submodules`
  * `git submodule forech [--recursive] 'git reset --hard'`

* Merge commit
  * `git reset --soft "HEAD~10"` # Merge last 10 commits into 1

* Display
	* `git log --all --full-history -- **/thefile.*`
	* `git log --diff-filter=D --summary | grep delete`
	* `git log --all --{file_path}` : file_path can have * inside
	* `git log --pretty=format:"%h"`
	* `git log --pretty=oneline`
	* `git log -S watever [--source --all] [--decorate] [--reverse]` : pickaxe or pickace
	* `git log -G "^(\s)*function foo[(][)](\s)**{$"` : regex
	* `git reflog`
	* `git show <COMMIT_ID> -- <FILE_PATH>` : show deleted files
	* `git checkout <SHA>^ -- <FILE_PATH>`
	* `git check-ignore *` : show ignored files
	* `git ls-files --others --exclude=standard`
	* `git ls-tree --full-tree -r HEAD`
	* `git cat-file -s`
	* `git diff-tree`

* Interface
  * `git add -i` : add items without copying full file name

* Patch
  * `git .git/objects/pack SAMPLE`
  * `git unpack-object < SAMPLE/*.pack`

* Ignore
  * `.git/info/exclude` : personal gitignore

* Clean
  * `git clean -[xd]n` : Show what I will clean
  * `git clean -[xd]f` : Do

* Grep regex
  * `git log -S'regex'`
  * `git log -S'regex'`
  * `git grep "regex"`

* Compress
  * `git reflog expire --expire=now --all`
  * `git gc [--agressive --prune=now]` : garbage collector

* Filter : remove certain files
  * `git filter-branch --tree-filter 'rm -f pass.txt' ~HEAD`
  * `git filter-branch --tree-filter 'git clean -f -X' -- --all
    * Removegitignore form history
    * Aster rebasing with a gitignore at first commit


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

*  Show word regex in diff
  *  `git diff --word-diff-regex=.`

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

* Choose ours (master) theirs (current branch) automaticcaly in case of conflict
  * `git rebase -Xtheirs branch-b`
  * `git merge -Xours origin/master`
  * `git checkout --ours foo/bar.java`
  * `git add foo/bar.java`


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

*  Personal gitignore
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


# Change history

## Analyse

* To see which commit modified the file
  * `git log --all -- <filepath accepting *>`
  * `git log --all --full-history -- **/thefile.*`

* Filter
  * `git filter-branch --index-filter "git rm --cached --ignore-unmach file.txt" [HEAD~5..HEAD` # file?txt can have a *

* Clean
  * `git rebase -i <commit>~1`          # Can edit or delete commits  
  * `git commit --amend --author="tinwin <tin@windows>`





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
  git config --list   # See all config vars 
  git config user.name   # See the var git is using for name 
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
<    Creates a new pointer at the same commit you're currently on 
```
  git checkout testing 
  git checkout -b testing # creates the branch and go in it 
<    Moves HEAD to the testing branch  
  
  -> Switching to a branch changes the working directory 
```
  git branch 
  git branch -v   # see the last commit 
  git branch -m <oldname> <newname>  
<    rename a branch 
```
  git branch [--no-merged] [--merged]
<    Lists all Branches 
```
  git log --oneline --decorate --graph --all 
<     Shows where branch pointers are
  -> Creating a branch is just creating a 41 byte pointer (to a sha-1) in a file 

# 5. Merge


  -> You want to merge myBranch into master 
```
  git checkout master
  git merge myBranch
<    If you changed the same part of the same file differently, this will cause confict. So this won't auto-merge and you have to resolve the conflict and then commit.
```
  git status 
<    To see the conflict 
  Open the files manually to resolve the conflict and add them to the stage to remove them from conclicting files
```
  git mergetool
```
```
  git branch -d myBranch 
<    To deleta a branch, usefull if this branch is already merged 


# 6. Rebasing

  -> Get the change one branch applied to the most common ancestor and apply this change to the other branch 
```
  git rebase --onto master server client
<    Check client branch, figure the changes from the common
ancestor with client and apply these changes to master
```
  git rebase master server 
  git checkout master 
  git merge server
  git branch -d server
<    Replay server changes on master branch 
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
<    To see all remote vars 
  -> Origin is the default name for a remote when you run git clone *git-origin*
```
  git fetch origin 
<     Fetch data from origin into a new branch called origin/master 
```
  git push (remote) (branch) 
<    Take my local branch and update the remote origin branch (with the same name) 
```
  git checkout -b serverfix origin/serverfix 
<    This gives a local branch where origin/serverfix was 

  -> Tracking branches are local branches that are looking to remote branches. When you git clone, your master branch is tracking origin/master. You can then update master with "git pull". From a tracking branch, git pull will act as git fetch and git merge  

# 8. Remote

```
  git remote add local_proc /opt/git/projct.git 
  git pull /home/john/project 
```

# 9.
