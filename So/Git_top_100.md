---
title: Git <- StackOverflow top 100
category: git
wiki_css: ../Css/color_dark_solarized.css, ../Css/layout_toc.css
header-includes: <script type="text/javascript" src="../Css/js_masonry_desandro.js"></script>
wiki_pandoc: --toc
---

<section class="level2">

</b> </em> </i> </small> </strong> </sub> </sup>

### 1: How do I undo the most recent local commits in Git? (score [8179416](https://stackoverflow.com/q/927358) in 2019)

#### Question
I accidentally committed the wrong files to <a href="https://en.wikipedia.org/wiki/Git" rel="noreferrer">Git</a>, but I haven't pushed the commit to the server yet.  

<strong>How can I undo those commits from the local repository?</strong>   

#### Answer accepted (score 21822)
<h5>Undo a commit and redo</h3>

```sh
$ git commit -m "Something terribly misguided"             # (1)
$ git reset HEAD~                                          # (2)
<< edit files as necessary >>                              # (3)
$ git add ...                                              # (4)
$ git commit -c ORIG_HEAD                                  # (5)
```

<ol>
<li>This is what you want to undo.</li>
<li>This leaves your working tree (the state of your files on disk) unchanged but undoes the commit and leaves the changes you committed unstaged (so they'll appear as "Changes not staged for commit" in `git status`, so you'll need to add them again before committing). If you <em>only</em> want to <em>add</em> more changes to the previous commit, or change the commit message<sup>1</sup>, you could use `git reset --soft HEAD~` instead, which is like `git reset HEAD~` (where `HEAD~` is the same as `HEAD~1`) but leaves your existing changes staged.</li>
<li>Make corrections to working tree files.</li>
<li>`git add` anything that you want to include in your new commit.</li>
<li>Commit the changes, reusing the old commit message. `reset` copied the old head to `.git/ORIG_HEAD`; `commit` with `-c ORIG_HEAD` will open an editor, which initially contains the log message from the old commit and allows you to edit it. If you do not need to edit the message, you could use the `-C` option.</li>
</ol>

Beware however that if you have added any new changes to the index, using `commit --amend` will add them to your previous commit.  

If the code is already pushed to your server and you have permissions to overwrite history (rebase) then:  

```sh
git push origin master --force
```

You can also look at this answer:    

<a href="https://stackoverflow.com/questions/34519665/how-to-move-head-back-to-a-previous-location-detached-head/34519716#34519716">How to move HEAD back to a previous location? (Detached head) &amp; Undo commits</a>  

The above answer will show you `git reflog` which is used to find out what is the SHA-1 which you wish to revert to. Once you found the point to which you wish to undo to use the sequence of commands as explained above.  

<hr>

<sup>1</sup> Note, however, that you don't need to reset to an earlier commit if you just made a mistake in your <em>commit message</em>. The easier option is to `git reset` (to unstage any changes you've made since) and then <a href="https://stackoverflow.com/q/179123/1146608">`git commit --amend`</a>, which will open your default commit message editor pre-populated with the last commit message.   

#### Answer 2 (score 10426)
Undoing a commit is a little scary if you don't know how it works.  But it's actually amazingly easy if you do understand.  

Say you have this, where C is your HEAD and (F) is the state of your files.  

```sh
   (F)
A-B-C
    ↑
  master
```

You want to <strong>nuke commit C and never see it again</strong>.  You do this:  

```sh
git reset --hard HEAD~1
```

The result is:  

```sh
 (F)
A-B
  ↑
master
```

Now B is the HEAD.  Because you used `--hard`, your files are reset to their state at commit B.  

Ah, but suppose commit C wasn't a disaster, but just a bit off.  You want to <strong>undo the commit but keep your changes</strong> for a bit of editing before you do a better commit.  Starting again from here, with C as your HEAD:  

```sh
   (F)
A-B-C
    ↑
  master
```

You can do this, leaving off the `--hard`:  

```sh
git reset HEAD~1
```

In this case the result is:  

```sh
   (F)
A-B-C
  ↑
master
```

In both cases, HEAD is just a pointer to the latest commit.  When you do a `git reset HEAD~1`, you tell Git to move the HEAD pointer back one commit.  But (unless you use `--hard`) you leave your files as they were.  So now `git status` shows the changes you had checked into C.  You haven't lost a thing!  

For the lightest touch, you can even <strong>undo your commit but leave your files and your <a href="https://git.wiki.kernel.org/index.php/WhatIsTheIndex" rel="noreferrer">index</a></strong>:  

```sh
git reset --soft HEAD~1
```

This not only leaves your files alone, it even leaves your <em>index</em> alone.  When you do `git status`, you'll see that the same files are in the index as before.  In fact, right after this command, you could do `git commit` and you'd be redoing the same commit you just had.  

One more thing: <strong>Suppose you destroy a commit</strong> as in the first example, <strong>but then discover you needed it after all</strong>?  Tough luck, right?  

Nope, there's <em>still</em> a way to get it back.  Type `git reflog` and you'll see a list of (partial) commit <a href="https://en.wikipedia.org/wiki/SHA-1#Data_integrity" rel="noreferrer">shas</a> (that is, hashes) that you've moved around in.  Find the commit you destroyed, and do this:  

```sh
git checkout -b someNewBranchName shaYouDestroyed
```

You've now resurrected that commit.  Commits don't actually get destroyed in Git for some 90 days, so you can usually go back and rescue one you didn't mean to get rid of.  

#### Answer 3 (score 2005)
This took me a while to figure out, so maybe this will help someone...  

There are two ways to "undo" your last commit, depending on whether or not you have already made your commit public (pushed to your remote repository):  

<h5>How to undo a local commit</h2>

Let's say I committed locally, but now want to remove that commit.  

```sh
git log
    commit 101: bad commit    # latest commit, this would be called 'HEAD'
    commit 100: good commit   # second to last commit, this is the one we want
```

To restore everything back to the way it was prior to the last commit, we need to `reset` to the commit before `HEAD`:  

```sh
git reset --soft HEAD^     # use --soft if you want to keep your changes
git reset --hard HEAD^     # use --hard if you don't care about keeping the changes you made
```

Now `git log` will show that our last commit has been removed.  

<h5>How to undo a public commit</h2>

If you have already made your commits public, you will want to create a new commit which will "revert" the changes you made in your previous commit (current HEAD).  

```sh
git revert HEAD
```

Your changes will now be reverted and ready for you to commit:  

```sh
git commit -m 'restoring the file I removed by accident'
git log
    commit 102: restoring the file I removed by accident
    commit 101: removing a file we don't need
    commit 100: adding a file that we need
```

For more info, check out <a href="https://git-scm.com/book/en/v2/Git-Basics-Undoing-Things" rel="noreferrer">Git Basics - Undoing Things</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 2: How do I delete a Git branch locally and remotely? (score [7599991](https://stackoverflow.com/q/2003505) in 2019)

#### Question
I want to delete a branch both locally and remotely.  

<h5>Failed Attempts to Delete Remote Branch</h2>

```sh
$ git branch -d remotes/origin/bugfix
error: branch 'remotes/origin/bugfix' not found.

$ git branch -d origin/bugfix
error: branch 'origin/bugfix' not found.

$ git branch -rd origin/bugfix
Deleted remote branch origin/bugfix (was 2a14ef7).

$ git push
Everything up-to-date

$ git pull
From github.com:gituser/gitproject
* [new branch] bugfix -> origin/bugfix
Already up-to-date.
```

<p>What should I do differently to successfully delete the
`remotes/origin/bugfix` branch both locally and remotely?</p>

#### Answer accepted (score 20171)
<h5>Executive Summary</h1>

```sh
$ git push -d <remote_name> <branch_name>
$ git branch -d <branch_name>
```

Note that in most cases the remote name is `origin`.  

<h5>Delete Local Branch</h1>

To delete the <em>local</em> branch use one of the following:  

```sh
$ git branch -d branch_name
$ git branch -D branch_name
```

<strong>Note:</strong> The `-d` option is an alias for `--delete`, which only deletes the branch if it has already been fully merged in its upstream branch. You could also use `-D`, which is an alias for `--delete --force`, which deletes the branch "irrespective of its merged status." [Source: `man git-branch`]   

<h5>Delete Remote Branch [Updated on 8-Sep-2017]</h1>

As of <a href="https://github.com/gitster/git/blob/master/Documentation/RelNotes/1.7.0.txt" rel="noreferrer">Git v1.7.0</a>, you can delete a <strong><em>remote</em></strong> branch using  

```sh
$ git push <remote_name> --delete <branch_name>
```

which might be easier to remember than  

```sh
$ git push <remote_name> :<branch_name>
```

which was added in <a href="https://github.com/gitster/git/blob/master/Documentation/RelNotes/1.5.0.txt" rel="noreferrer">Git v1.5.0</a> "to delete a remote branch or a tag."  

Starting on <a href="https://github.com/git/git/blob/master/Documentation/RelNotes/2.8.0.txt" rel="noreferrer">Git v2.8.0</a> you can also use `git push` with the `-d` option as an alias for `--delete`.  

Therefore, the version of Git you have installed will dictate whether you need to use the easier or harder syntax.  

<h5>Delete Remote Branch [Original Answer from 5-Jan-2010]</h2>

From Chapter 3 of <a href="http://git-scm.com/book/en/Git-Branching-Remote-Branches" rel="noreferrer"><em>Pro Git</em></a> by Scott Chacon:  

<blockquote>
  <h5>Deleting Remote Branches</h3>
  
  Suppose you’re done with a remote branch — say, you and your collaborators are finished with a feature and have merged it into your remote’s master branch (or whatever branch your stable code-line is in). You can delete a remote branch using the rather obtuse syntax `git push [remotename] :[branch]`. If you want to delete your server-fix branch from the server, you run the following:  

```sh
$ git push origin :serverfix
To git@github.com:schacon/simplegit.git
 - [deleted]         serverfix
```
  
  Boom. No more branches on your server. You may want to dog-ear this page, because you’ll need that command, and you’ll likely forget the syntax. A way to remember this command is by recalling the `git push [remotename] [localbranch]:[remotebranch]` syntax that we went over a bit earlier. If you leave off the `[localbranch]` portion, then you’re basically saying, “Take nothing on my side and make it be `[remotebranch]`.”  
</blockquote>

I issued `git push origin: bugfix` and it worked beautifully. Scott Chacon was right—I will want to <a href="http://en.wiktionary.org/wiki/dogear#Verb" rel="noreferrer">dog ear</a> that page (or virtually dog ear by answering this on Stack&nbsp;Overflow).  

Then you should execute this on other machines  

```sh
# Fetch changes from all remotes and locally delete 
# remote deleted branches/tags etc
# --prune will do the job :-;
git fetch --all --prune
```

to propagate changes.  

#### Answer 2 (score 3198)
<a href="https://stackoverflow.com/a/2003515/2637261">Matthew's answer</a> is great for removing <em>remote</em> branches and I also appreciate the explanation, but to make a simple distinction between the two commands:  

To remove a <strong><em>local branch</em></strong> from your machine:  

`git branch -d {the_local_branch}` (use `-D` instead to force deleting the branch without checking merged status)  

To remove a <strong><em>remote branch</em></strong> from the server:  

`git push origin --delete {the_remote_branch}`  

Reference: <a href="https://makandracards.com/makandra/621-git-delete-a-branch-local-or-remote" rel="noreferrer">https://makandracards.com/makandra/621-git-delete-a-branch-local-or-remote</a>  

#### Answer 3 (score 1805)
<h5>The Short Answers</h1>

If you want more detailed explanations of the following commands, then see the long answers in the next section.  

Deleting a remote branch:  

```sh
git push origin --delete <branch>  # Git version 1.7.0 or newer
git push origin :<branch>          # Git versions older than 1.7.0
```

Deleting a local branch:  

```sh
git branch --delete <branch>
git branch -d <branch> # Shorter version
git branch -D <branch> # Force delete un-merged branches
```

Deleting a local remote-tracking branch:  

```sh
git branch --delete --remotes <remote>/<branch>
git branch -dr <remote>/<branch> # Shorter

git fetch <remote> --prune # Delete multiple obsolete tracking branches
git fetch <remote> -p      # Shorter
```

<h5>The Long Answer: there are 3 different branches to delete!</h1>

When you're dealing with deleting branches both locally and remotely, keep in mind that <strong>there are 3 different branches involved</strong>:  

<ol>
<li>The local branch `X`.</li>
<li>The remote origin branch `X`.</li>
<li>The local remote-tracking branch `origin/X` that tracks the remote branch `X`.</li>
</ol>

<img src="https://i.stack.imgur.com/NLAqw.png" alt="Visualization of 3 branches">  

The original poster used  

```sh
git branch -rd origin/bugfix
```

which only deleted his <strong>local remote-tracking branch</strong> `origin/bugfix`, and not the actual remote branch `bugfix` on `origin`.  

<img src="https://i.stack.imgur.com/iCOnz.png" alt="Diagram 2">  

<strong>To delete that actual remote branch</strong>, you need  

```sh
git push origin --delete bugfix
```

<img src="https://i.stack.imgur.com/6Z3GY.png" alt="Diagram 3">  

<h5>Additional Details</h1>

The following sections describe additional details to consider when deleting your remote and remote-tracking branches.  

<h5>Pushing to delete remote branches also deletes remote-tracking branches</h2>

Note that deleting the remote branch `X` from the command line using a `git push` <strong>will also delete the local remote-tracking branch</strong> `origin/X`, so it is not necessary to prune the obsolete remote-tracking branch with `git fetch --prune` or `git fetch -p`, though it wouldn't hurt if you did it anyway.  

You can verify that the remote-tracking branch `origin/X` was also deleted by running the following:  

```sh
# View just remote-tracking branches
git branch --remotes
git branch -r

# View both strictly local as well as remote-tracking branches
git branch --all
git branch -a
```

<h5>Pruning the obsolete local remote-tracking branch origin/X</h2>

If you didn't delete your remote branch `X` from the command line (like above), then your local repo will still contain (a now obsolete) remote-tracking branch `origin/X`. This can happen if you deleted a remote branch directly through GitHub's web interface, for example.  

A typical way to remove these obsolete remote-tracking branches (since Git version 1.6.6) is to simply run `git fetch` with the `--prune` or shorter `-p`. <strong>Note that this removes all obsolete local remote-tracking branches for any remote branches that no longer exist on the remote</strong>:  

```sh
git fetch origin --prune
git fetch origin -p # Shorter
```

Here is the relevant quote from the <a href="https://github.com/git/git/blob/v2.0.0/Documentation/RelNotes/1.6.6.txt#L162-L166" rel="noreferrer">1.6.6 release notes</a> (emphasis mine):  

<blockquote>
  <p><strong>"git fetch" learned</strong> `--all` and `--multiple`options, to run fetch from
  many repositories, and <strong>`--prune` option to remove remote tracking
  branches that went stale.</strong>  These make "git remote update" and "git
  remote prune" less necessary (there is no plan to remove "remote
  update" nor "remote prune", though).</p>
</blockquote>

<h5>Alternative to above automatic pruning for obsolete remote-tracking branches</h3>

Alternatively, instead of pruning your obsolete local remote-tracking branches through `git fetch -p`, <em>you can avoid making the extra network operation</em> by just manually removing the branch(es) with the `--remote` or `-r` flags:  

```sh
git branch --delete --remotes origin/X
git branch -dr origin/X # Shorter
```

<h5>See Also</h2>

<ul>
<li><a href="https://jk.gs/git-branch.html" rel="noreferrer">git-branch(1) Manual Page</a>.</li>
<li><a href="https://jk.gs/git-fetch.html" rel="noreferrer">git-fetch(1) Manual Page</a>.</li>
<li><a href="https://git-scm.com/book/en/Git-Branching-Remote-Branches" rel="noreferrer">Pro Git &sect; 3.5 Git Branching - Remote Branches</a>.</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 3: How do I revert a Git repository to a previous commit? (score [5388210](https://stackoverflow.com/q/4114095) in 2019)

#### Question
How do I revert from my current state to a snapshot made on a certain commit?  

If I do `git log`, then I get the following output:  

```sh
$ git log
commit a867b4af366350be2e7c21b8de9cc6504678a61b`
Author: Me <me@me.com>
Date:   Thu Nov 4 18:59:41 2010 -0400

blah blah blah...

commit 25eee4caef46ae64aa08e8ab3f988bc917ee1ce4
Author: Me <me@me.com>
Date:   Thu Nov 4 05:13:39 2010 -0400

more blah blah blah...

commit 0766c053c0ea2035e90f504928f8df3c9363b8bd
Author: Me <me@me.com>
Date:   Thu Nov 4 00:55:06 2010 -0400

And yet more blah blah...

commit 0d1d7fc32e5a947fbd92ee598033d85bfc445a50
Author: Me <me@me.com>
Date:   Wed Nov 3 23:56:08 2010 -0400

Yep, more blah blah.
```

How do revert to the commit from November 3, i.e. commit `0d1d7fc`?  

#### Answer accepted (score 9090)
This depends a lot on what you mean by "revert".  

<h5>Temporarily switch to a different commit</h2>

If you want to temporarily go back to it, fool around, then come back to where you are, all you have to do is check out the desired commit:  

```sh
# This will detach your HEAD, that is, leave you with no branch checked out:
git checkout 0d1d7fc32
```

Or if you want to make commits while you're there, go ahead and make a new branch while you're at it:  

```sh
git checkout -b old-state 0d1d7fc32
```

To go back to where you were, just check out the branch you were on again. (If you've made changes, as always when switching branches, you'll have to deal with them as appropriate. You could reset to throw them away; you could stash, checkout, stash pop to take them with you; you could commit them to a branch there if you want a branch there.)  

<h5>Hard delete unpublished commits</h2>

If, on the other hand, you want to really get rid of everything you've done since then, there are two possibilities. One, if you haven't published any of these commits, simply reset:  

```sh
# This will destroy any local modifications.
# Don't do it if you have uncommitted work you want to keep.
git reset --hard 0d1d7fc32

# Alternatively, if there's work to keep:
git stash
git reset --hard 0d1d7fc32
git stash pop
# This saves the modifications, then reapplies that patch after resetting.
# You could get merge conflicts, if you've modified things which were
# changed since the commit you reset to.
```

If you mess up, you've already thrown away your local changes, but you can at least get back to where you were before by resetting again.  

<h5>Undo published commits with new commits</h2>

On the other hand, if you've published the work, you probably don't want to reset the branch, since that's effectively rewriting history. In that case, you could indeed revert the commits. With Git, revert has a very specific meaning: create a commit with the reverse patch to cancel it out. This way you don't rewrite any history.  

```sh
# This will create three separate revert commits:
git revert a867b4af 25eee4ca 0766c053

# It also takes ranges. This will revert the last two commits:
git revert HEAD~2..HEAD

#Similarly, you can revert a range of commits using commit hashes:
git revert a867b4af..0766c053 

# Reverting a merge commit
git revert -m 1 <merge_commit_sha>

# To get just one, you could use `rebase -i` to squash them afterwards
# Or, you could do it manually (be sure to do this at top level of the repo)
# get your index and work tree into the desired state, without changing HEAD:
git checkout 0d1d7fc32 .

# Then commit. Be sure and write a good message describing what you just did
git commit
```

The <a href="http://schacon.github.com/git/git-revert.html" rel="noreferrer">`git-revert` manpage</a> actually covers a lot of this in its description. Another useful link is <a href="https://git-scm.com/book/en/v2/Git-Tools-Advanced-Merging#_undoing_merges" rel="noreferrer">this git-scm.com section discussing git-revert</a>.  

If you decide you didn't want to revert after all, you can revert the revert (as described here) or reset back to before the revert (see the previous section).  

<p>You may also find this answer helpful in this case:<br>
<a href="https://stackoverflow.com/questions/34519665/how-to-move-head-forward-checkout-revet-reflog-reset/34519716#34519716">How to move HEAD back to a previous location? (Detached head)</a></p>

#### Answer 2 (score 1571)
Lots of complicated and dangerous answers here, but it's actually easy:  

```sh
git revert --no-commit 0766c053..HEAD
git commit
```

This will revert everything from the HEAD back to the commit hash, meaning it will recreate that commit state in the working tree <em>as if</em> every commit since had been walked back. You can then commit the current tree, and it will create a brand new commit essentially equivalent to the commit you "reverted" to.    

(The `--no-commit` flag lets git revert all the commits at once- otherwise you'll be prompted for a message for each commit in the range, littering your history with unnecessary new commits.)  

This is a <strong>safe and easy way to rollback to a previous state</strong>. No history is destroyed, so it can be used for commits that have already been made public.  

#### Answer 3 (score 1521)
<h5>Rogue Coder?</h2>

Working on your own and just want it to work? Follow these instructions below, they’ve worked reliably for me and many others for years.  

Working with others? Git is complicated. Read the comments below this answer before you do something rash.  

<h5>Reverting Working Copy to Most Recent Commit</h3>

To revert to a previous commit, ignoring any changes:  

```sh
git reset --hard HEAD
```

where HEAD is the last commit in your current branch  

<h5>Reverting The Working Copy to an Older Commit</h3>

To revert to a commit that's older than the most recent commit:  

```sh
# Resets index to former commit; replace '56e05fced' with your commit code
git reset 56e05fced 

# Moves pointer back to previous HEAD
git reset --soft HEAD@{1}

git commit -m "Revert to 56e05fced"

# Updates working copy to reflect the new commit
git reset --hard
```

Credits go to a similar Stack Overflow question, <em><a href="https://stackoverflow.com/questions/1895059/git-revert-to-a-commit-by-sha-hash">Revert to a commit by a SHA hash in Git?</a></em>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 4: How do I check out a remote Git branch? (score [4913384](https://stackoverflow.com/q/1783405) in 2017)

#### Question
Somebody pushed a branch called `test` with `git push origin test` to a shared repository. I can see the branch with `git branch -r`.  

Now I'm trying to check out the remote `test` branch.  

I've tried:  

<ul>
<li><p>`git checkout test` which does nothing</p></li>
<li><p>`git checkout origin/test` gives `* (no branch)`. Which is confusing. How can I be on "no branch"?</p></li>
</ul>

How do I check out a remote Git branch?  

#### Answer accepted (score 8745)
<h5>Update</h2>

<a href="https://stackoverflow.com/a/1787014/456814">Jakub's answer</a> actually improves on this. With Git versions &ge; 1.6.6, with only one remote, you can just do:  

```sh
git fetch
git checkout test
```

As user masukomi points out in a comment, `git checkout test` will NOT work in modern git if you have multiple remotes. In this case use  

```sh
git checkout -b test <name of remote>/test
```

or the shorthand  

```sh
git checkout -t <name of remote>/test
```

<h5>Old Answer</h2>

Before you can start working locally on a remote branch, you need to fetch it as called out in answers below.   

To fetch a branch, you simply need to:  

```sh
git fetch origin
```

This will fetch all of the remote branches for you. You can see the branches available for checkout with:  

```sh
git branch -v -a
```

With the remote branches in hand, you now  need to check out the branch you are interested in, giving you a local working copy:  

```sh
git checkout -b test origin/test
```

#### Answer 2 (score 1221)
<strong><em>Sidenote:</em></strong> With modern Git (>= <a href="https://raw.github.com/git/git/master/Documentation/RelNotes/1.6.6.txt" rel="noreferrer">1.6.6</a>), you are able to use just  

```sh
git checkout test
```

(note that it is 'test' not 'origin/test') to perform magical <a href="http://en.wikipedia.org/wiki/DWIM" rel="noreferrer" title="Do What I Mean">DWIM</a>-mery and create local branch 'test' for you, for which upstream would be remote-tracking branch 'origin/test'.  

<hr>

The `* (no branch)` in `git branch` output means that you are on unnamed branch, in so called "detached HEAD" state (HEAD points directly to commit, and is not symbolic reference to some local branch).  If you made some commits on this unnamed branch, you can always create local branch off current commit:  

```sh
git checkout -b test HEAD
```

#### Answer 3 (score 542)
In this case, you probably want to create a local `test` branch which is tracking the remote `test` branch:  

```sh
$ git branch test origin/test
```

In earlier versions of `git`, you needed an explicit `--track` option, but that is the default now when you are branching off a remote branch.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 5: How do I force "git pull" to overwrite local files? (score [4145107](https://stackoverflow.com/q/1125968) in 2018)

#### Question
How do I force an overwrite of local files on a `git pull`?  

The scenario is following:  

<ul>
<li>A team member is modifying the templates for a website we are working on</li>
<li>They are adding some images to the images directory (but forgets to add them under source control)</li>
<li>They are sending the images by mail, later, to me</li>
<li>I'm adding the images under the source control and pushing them to GitHub together with other changes</li>
<li>They cannot pull updates from GitHub because Git doesn't want to overwrite their files.</li>
</ul>

This is the error I'm getting:  

<blockquote>
  error: Untracked working tree file 'public/images/icon.gif' would be overwritten by merge  
</blockquote>

How do I force Git to overwrite them? The person is a designer - usually I resolve all the conflicts by hand, so the server has the most recent version that they just needs to update on their computer.  

#### Answer accepted (score 9103)
<h5>Important: If you have any local changes, they will be lost. With or without `--hard` option, any local commits that haven't been pushed will be lost.<sup>[*]</sup></h2>

If you have any files that are <em>not</em> tracked by Git (e.g. uploaded user content), these files will not be affected.  

<hr>

I think this is the right way:  

```sh
git fetch --all
```

Then, you have two options:  

```sh
git reset --hard origin/master
```

OR If you are on some other branch:  

```sh
git reset --hard origin/<branch_name>
```

<h5>Explanation:</h3>

`git fetch` downloads the latest from remote without trying to merge or rebase anything.  

Then the `git reset` resets the master branch to what you just fetched. The `--hard` option changes all the files in your working tree to match the files in `origin/master`  

<hr>

<h5>Maintain current local commits</h3>

<sup>[*]</sup>: It's worth noting that it is possible to maintain current local commits by creating a branch from `master` before resetting:  

```sh
git checkout master
git branch new-branch-to-save-current-commits
git fetch --all
git reset --hard origin/master
```

After this, all of the old commits will be kept in `new-branch-to-save-current-commits`.   

<h5>Uncommitted changes</h3>

Uncommitted changes, however (even staged), will be lost. Make sure to stash and commit anything you need. For that you can run the following:  

```sh
git stash
```

And then to reapply these uncommitted changes:  

```sh
git stash pop
```

#### Answer 2 (score 876)
Try this:  

```sh
git reset --hard HEAD
git pull
```

It should do what you want.  

#### Answer 3 (score 439)
<strong>WARNING: `git clean` deletes all your untracked files/directories and can't be undone.</strong>  

<hr>

Sometimes just `clean -f` does not help. In case you have untracked DIRECTORIES, -d option also needed:  

```sh
# WARNING: this can't be undone!

git reset --hard HEAD
git clean -f -d
git pull
```

<strong>WARNING: `git clean` deletes all your untracked files/directories and can't be undone.</strong>  

Consider using `-n` (`--dry-run`) flag first. This will show you what will be deleted without actually deleting anything:  

```sh
git clean -n -f -d
```

Example output:  

```sh
Would remove untracked-file-1.txt
Would remove untracked-file-2.txt
Would remove untracked/folder
...
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 6: How do I push a new local branch to a remote Git repository and track it too? (score [3200291](https://stackoverflow.com/q/2765421) in 2019)

#### Question
I want to be able to do the following:  

<ol>
<li><p>Create a local branch based on some other (remote or local) branch (via `git branch` or `git checkout -b`)</p></li>
<li><p>Push the local branch
to the remote repository (publish), but make it
trackable so `git pull` and `git push` will work immediately.</p></li>
</ol>

How do I do that?  

I know about `--set-upstream` in Git 1.7, but that is a post-creation action. I want to find a way to make a similar change when pushing the branch to the remote repository.  

#### Answer accepted (score 6363)
In Git 1.7.0 and later, you can checkout a new branch:  

```sh
git checkout -b <branch>
```

Edit files, add and commit. Then <a href="https://git-scm.com/docs/git-push" rel="noreferrer">push with the `-u` (short for `--set-upstream`)</a> option:  

```sh
git push -u origin <branch>
```

Git will set up the tracking information during the push.  

#### Answer 2 (score 478)
If you are not sharing your repo with others, this is useful to push <strong>all</strong> your branches to the remote, and `--set-upstream` tracking correctly for you:  

```sh
git push --all -u
```

(Not exactly what the OP was asking for, but this one-liner is pretty popular)  

If you are sharing your repo with others this isn't really good form as you will clog up the repo with all your dodgy experimental branches.  

#### Answer 3 (score 147)
Prior to the introduction of `git push -u`, there was no `git push` option to obtain what you desire. You had to add new configuration statements.  

If you create a new branch using:  

```sh
$ git checkout -b branchB
$ git push origin branchB:branchB
```

You can use the `git config` command to avoid editing directly the `.git/config` file.  

```sh
$ git config branch.branchB.remote origin
$ git config branch.branchB.merge refs/heads/branchB
```

Or you can edit manually the `.git/config` file to had tracking information to this branch.  

```sh
[branch "branchB"]
    remote = origin
    merge = refs/heads/branchB
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 7: How do I clone a specific Git branch? (score [2851810](https://stackoverflow.com/q/1911109) in 2019)

#### Question
Git clone will behave copying remote current working branch into local.   

Is there any way to clone a specific branch by myself without switching branches on the remote repository?  

#### Answer accepted (score 948)
```sh
git clone --single-branch --branch <branchname> <remote-repo>
```

The `--single-branch` option is valid from version <a href="https://github.com/git/git/blob/master/Documentation/RelNotes/1.7.10.txt" rel="noreferrer">1.7.10</a> and later.  

Please see also the <a href="https://stackoverflow.com/a/4568323/134077">other answer</a> which many people prefer.  

You may also want to make sure you understand the difference. And the difference is: by invoking `git clone --branch &lt;branchname&gt; url` you're fetching <em>all</em> the branches and checking out one. That may, for instance, mean that your repository has a 5kB documentation or wiki branch and 5GB data branch. And whenever you want to edit your frontpage, you may end up cloning 5GB of data.  

Again, that is not to say `git clone --branch` is not the way to accomplish that, it's just that it's not <em>always</em> what you want to accomplish, when you're asking about cloning a specific branch.  

At the time of writing the original answer below, git had no `--single-branch` option, but let's preserve it for full satisfaction of angry bees.  

The answer so badly disliked by copypasters was this:  

```sh
git init
git remote add -t refspec remotename host:/dir.git
git fetch
```

#### Answer 2 (score 7485)
```sh
git clone -b <branch> <remote_repo>
```

Example:  

```sh
git clone -b my-branch git@github.com:user/myproject.git
```

With Git 1.7.10 and later, add `--single-branch` to prevent fetching of all branches. Example, with OpenCV 2.4 branch:  

```sh
git clone -b opencv-2.4 --single-branch https://github.com/Itseez/opencv.git
```

#### Answer 3 (score 252)
Here is a really simple way to do it :)  

Clone the repository  

```sh
git clone <repository_url>
```

List all branches  

```sh
git branch -a 
```

Checkout the branch that you want  

```sh
git checkout <name_of_branch>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 8: How do I undo 'git add' before commit? (score [2801667](https://stackoverflow.com/q/348170) in 2019)

#### Question
I mistakenly added files to git using the command:  

```sh
git add myfile.txt
```

I have not yet run `git commit`. Is there a way to undo this, so these files won't be included in the commit?  

#### Answer accepted (score 9641)
You can undo `git add` before commit with  

```sh
git reset <file>
```

which will remove it from the current index (the "about to be committed" list) without changing anything else.  

You can use  

```sh
git reset
```

without any file name to unstage all due changes. This can come in handy when there are too many files to be listed one by one in a reasonable amount of time.  

In old versions of Git, the above commands are equivalent to `git reset HEAD &lt;file&gt;` and `git reset HEAD` respectively, and will fail if `HEAD` is undefined (because you haven't yet made any commits in your repo) or ambiguous (because you created a branch called `HEAD`, which is a stupid thing that you shouldn't do). This <a href="https://git.kernel.org/cgit/git/git.git/tree/Documentation/RelNotes/1.8.2.txt#n179" rel="noreferrer">was changed in Git 1.8.2</a>, though, so in modern versions of Git you can use the commands above even prior to making your first commit:  

<blockquote>
  <p>"git reset" (without options or parameters) used to error out when
     you do not have any commits in your history, but it now gives you
     an empty index (to match non-existent commit you are not even on).</p>
</blockquote>

#### Answer 2 (score 2097)
You want:  

```sh
git rm --cached <added_file_to_undo>
```

Reasoning:  

When I was new to this, I first tried  

```sh
git reset .
```

(to undo my entire initial add), only to get this (not so) helpful message:  

```sh
fatal: Failed to resolve 'HEAD' as a valid ref.
```

It turns out that this is because the HEAD ref (branch?) doesn't exist until after the first commit. That is, you'll run into the same beginner's problem as me if your workflow, like mine, was something like:  

<ol>
<li>cd to my great new project directory to try out Git, the new hotness</li>
<li>`git init`</li>
<li>`git add .`</li>
<li><p>`git status`</p>

... lots of crap scrolls by ...  

=> Damn, I didn't want to add all of that.  </li>
<li><p>google "undo git add"</p>

=> find Stack Overflow - yay  </li>
<li><p>`git reset .`</p>

=>    fatal: Failed to resolve 'HEAD' as a valid ref.  </li>
</ol>

It further turns out that there's <a href="http://kerneltrap.org/mailarchive/git/2008/2/13/846664/thread" rel="noreferrer">a bug logged</a> against the unhelpfulness of this in the mailing list.  

And that the correct solution was right there in the Git status output (which, yes, I glossed over as 'crap)  

<blockquote>
```sh
...
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
...
```
</blockquote>

And the solution indeed is to use `git rm --cached FILE`.  

Note the warnings elsewhere here - `git rm` deletes your local working copy of the file, but <em>not</em> if you use <strong>--cached</strong>.  Here's the result of `git help rm`:  

<blockquote>
  <p>--cached
      Use this option to unstage and remove paths only from the index.
      Working tree files, whether modified or not, will be left.</p>
</blockquote>

I proceed to use  

```sh
git rm --cached .
```

to remove everything and start again. Didn't work though, because while `add .` is recursive, turns out `rm` needs `-r` to recurse. Sigh.  

```sh
git rm -r --cached .
```

Okay, now I'm back to where I started. Next time I'm going to use `-n` to do a dry run and see what will be added:  

```sh
git add -n .
```

I zipped up everything to a safe place before trusting `git help rm` about the `--cached` not destroying anything (and what if I misspelled it).  

#### Answer 3 (score 518)
If you type:  

```sh
git status
```

git will tell you what is staged, etc, including instructions on how to unstage:  

```sh
use "git reset HEAD <file>..." to unstage
```

I find git does a pretty good job of nudging me to do the right thing in situations like this.  

<strong>Note: Recent git versions (1.8.4.x) have changed this message:</strong>  

```sh
(use "git rm --cached <file>..." to unstage)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 9: Reset local repository branch to be just like remote repository HEAD (score [2740228](https://stackoverflow.com/q/1628088) in 2016)

#### Question
How do I reset my local branch to be just like the branch on the remote repository?  

I did:  

```sh
git reset --hard HEAD
```

But when I run a `git status`,  

```sh
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
      modified:   java/com/mycompany/TestContacts.java
      modified:   java/com/mycompany/TestParser.java
```

Can you please tell me why I have these 'modified'? I haven't touched these files? If I did, I want to remove those.  

#### Answer accepted (score 5911)
Setting your branch to exactly match the remote branch can be done in two steps:  

```sh
git fetch origin
git reset --hard origin/master
```

If you want to save your current branch's state before doing this (just in case), you can do:  

```sh
git commit -a -m "Saving my work, just in case"
git branch my-saved-work
```

Now your work is saved on the branch "my-saved-work" in case you decide you want it back (or want to look at it later or diff it against your updated branch).  

Note that the first example assumes that the remote repo's name is "origin" and that the branch named "master" in the remote repo matches the currently checked-out branch in your local repo.  

BTW, this situation that you're in looks an awful lot like a common case where a push has been done into the currently checked out branch of a non-bare repository. Did you recently push into your local repo? If not, then no worries -- something else must have caused these files to unexpectedly end up modified. Otherwise, you should be aware that it's not recommended to push into a non-bare repository (and not into the currently checked-out branch, in particular).  

#### Answer 2 (score 354)
I needed to do (the solution in the accepted answer):  

```sh
git fetch origin
git reset --hard origin/master
```

Followed by:  

```sh
git clean -f
```

<a href="https://stackoverflow.com/questions/61212/remove-local-untracked-files-from-my-current-git-branch">to remove local files</a>  

To see what files will be removed (without actually removing them):  

```sh
git clean -n -f
```

#### Answer 3 (score 245)
First, reset to the previously fetched `HEAD` of the corresponding upstream branch:  

```sh
git reset --hard @{u}
```

The advantage of specifying `@{u}` or its verbose form `@{upstream}` is that the name of the remote repo and branch don't have to be explicitly specified.  

Next, as needed, remove untracked files, optionally also with `-x`:  

```sh
git clean -df
```

Finally, as needed, get the latest changes:  

```sh
git pull
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 10: How do I use 'git reset --hard HEAD' to revert to a previous commit? (score [2672030](https://stackoverflow.com/q/9529078) in 2015)

#### Question
I know that Git tracks changes I make to my application, and it holds on to them until I commit the changes, but here's where I'm hung up:  

When I want to revert to a previous commit I use:   

```sh
git reset --hard HEAD```

And Git returns:  

```sh
HEAD is now at 820f417 micro
```

How do I then revert the files on my hard drive back to that previous commit?  

My next steps were:  

```sh
git add .
git commit -m "revert"
```

But none of the files have changed on my hard drive...  

What am I doing right/wrong?  

#### Answer accepted (score 1005)
First, it's always worth noting that `git reset --hard` is a potentially dangerous command, since it throws away all your uncommitted changes. For safety, you should always check that the output of `git status` is clean (that is, empty) before using it.  

Initially you say the following:  

<blockquote>
  So I know that Git tracks changes I make to my application, and it holds on to them until I commit the changes, but here's where I'm hung up:  
</blockquote>

That's incorrect. Git only records the state of the files when you stage them (with `git add`) or when you create a commit. Once you've created a commit which has your project files in a particular state, they're very safe, but until then Git's not really "tracking changes" to your files. (for example, even if you do `git add` to stage a new version of the file, that overwrites the previously staged version of that file in the staging area.)  

In your question you then go on to ask the following:  

<blockquote>
  When I want to revert to a previous commit I use: git reset --hard HEAD And git returns: HEAD is now at 820f417 micro  
  
  How do I then revert the files on my hard drive back to that previous commit?  
</blockquote>

If you do `git reset --hard &lt;SOME-COMMIT&gt;` then Git will:  

<ul>
<li>Make your current branch (typically `master`) back to point at `&lt;SOME-COMMIT&gt;`.</li>
<li>Then make the files in your working tree and the index ("staging area") the same as the versions committed in `&lt;SOME-COMMIT&gt;`.</li>
</ul>

`HEAD` points to your current branch (or current commit), so all that `git reset --hard HEAD` will do is to throw away any uncommitted changes you have.  

So, suppose the good commit that you want to go back to is `f414f31`. (You can find that via `git log` or any history browser.) You then have a few different options depending on exactly what you want to do:  

<ul>
<li>Change your current branch to point to the older commit instead. You could do that with `git reset --hard f414f31`. However, this is rewriting the history of your branch, so you should avoid it if you've shared this branch with anyone. Also, the commits you did after `f414f31` will no longer be in the history of your `master` branch.</li>
<li><p>Create a new commit that represents exactly the same state of the project as `f414f31`, but just adds that on to the history, so you don't lose any history. You can do that using the steps suggested in <a href="https://stackoverflow.com/a/1895095/223092">this answer</a> - something like:</p>

```sh
git reset --hard f414f31
git reset --soft HEAD@{1}
git commit -m "Reverting to the state of the project at f414f31"
```</li>
</ul>

#### Answer 2 (score 202)
<blockquote>
  <strong>WARNING: `git clean -f` will remove untracked files, meaning they're gone for good since they aren't stored in the repository. Make sure you really want to remove all untracked files before doing this.</strong>  
</blockquote>

<hr>

Try this and see `git clean -f`.    

`git reset --hard` will not remove untracked files, where as `git-clean` will remove any files from the tracked root directory that are not under Git tracking.  

Alternatively, as @Paul Betts said, you can do this (beware though - that removes all ignored files too)  

<ul>
<li>`git clean -df`</li>
<li>`git clean -xdf` <strong>CAUTION! This will also delete ignored files</strong></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 11: What is the difference between 'git pull' and 'git fetch'? (score [2657617](https://stackoverflow.com/q/292357) in 2018)

#### Question
<blockquote>
  <strong>Moderator Note:</strong> Given that this question has already had <em>sixty-seven answers</em> posted to it (some of them deleted), consider whether or not you are <strong><em>contributing anything new</em></strong> before posting another one.  
</blockquote>

What are the differences between `git pull` and `git fetch`?  

#### Answer accepted (score 9440)
In the simplest terms, `git pull` does a `git fetch` followed by a `git merge`.  

You can do a `git fetch` at any time to update your remote-tracking branches under `refs/remotes/&lt;remote&gt;/`.  

This operation never changes any of your own local branches under `refs/heads`, and is safe to do without changing your working copy. I have even heard of people running `git fetch` periodically in a cron job in the background (although I wouldn't recommend doing this).  

A `git pull` is what you would do to bring a local branch up-to-date with its remote version, while also updating your other remote-tracking branches.  

Git documentation – <a href="http://git-scm.com/docs/git-pull" rel="noreferrer"><strong>git pull</strong></a>:  

<blockquote>
  In its default mode, `git pull` is shorthand for `git fetch` followed by `git merge FETCH_HEAD`.  
</blockquote>

#### Answer 2 (score 2076)
<ul>
<li><p>When you use `pull`, Git tries to automatically do your work for you. <strong>It is context sensitive</strong>, so Git will merge any pulled commits into the branch you are currently working in.  `pull` <strong>automatically merges the commits without letting you review them first</strong>. If you don’t closely manage your branches, you may run into frequent conflicts.</p></li>
<li><p>When you `fetch`, Git gathers any commits from the target branch that do not exist in your current branch and <strong>stores them in your local repository</strong>. However, <strong>it does not merge them with your current branch</strong>. This is particularly useful if you need to keep your repository up to date, but are working on something that might break if you update your files. 
To integrate the commits into your master branch, you use `merge`.</p></li>
</ul>

#### Answer 3 (score 1155)
It is important to contrast the design philosophy of git with the philosophy of a more traditional source control tool like SVN.  

Subversion was designed and built with a client/server model. There is a single repository that is the server, and several clients can fetch code from the server, work on it, then commit it back to the server. The assumption is that the client can always contact the server when it needs to perform an operation.  

Git was designed to support a more distributed model with no need for a central repository (though you can certainly use one if you like). Also git was designed so that the client and the "server" don't need to be online at the same time. Git was designed so that people on an unreliable link could exchange code via email, even. It is possible to work completely disconnected and burn a CD to exchange code via git.  

In order to support this model git maintains a local repository with your code and also an additional local repository that mirrors the state of the remote repository. By keeping a copy of the remote repository locally, git can figure out the changes needed even when the remote repository is not reachable.  Later when you need to send the changes to someone else, git can transfer them as a set of changes from a point in time known to the remote repository.  

<ul>
<li><p><strong>`git fetch`</strong> is the command that says "bring my local copy of the remote repository up to date." </p></li>
<li><p><strong>`git pull`</strong> says "bring the changes in the remote repository to where I keep my own code."</p></li>
</ul>

Normally <strong>`git pull`</strong> does this by doing a <strong>`git fetch`</strong> to bring the local copy of the remote repository up to date, and then merging the changes into your own code repository and possibly your working copy.  

The take away is to keep in mind that there are often at least <strong>three copies</strong> of a project on your workstation. One copy is your own repository with your own commit history. The second copy is your working copy where you are editing and building. The third copy is your local "cached" copy of a remote repository.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 12: How do I rename a local Git branch? (score [2621697](https://stackoverflow.com/q/6591213) in 2019)

#### Question
I don't want to rename a remote branch, as described in <em><a href="https://stackoverflow.com/questions/1526794/rename-master-branch-for-both-local-and-remote-git-repositories?answertab=votes#tab-top">Rename master branch for both local and remote Git repositories</a></em>.  

How can I rename a local branch which hasn't been pushed to a remote branch?  

<p>In case you need to rename <strong>remote</strong> branch as well:<br>
<em><a href="https://stackoverflow.com/questions/30590083/how-to-rename-a-remote-git-branch-name/30590238#30590238">How do I rename both a Git local and remote branch name</a></em></p>

#### Answer accepted (score 12738)
If you want to rename a branch while pointed to any branch, do:  

```sh
git branch -m <oldname> <newname>
```

If you want to rename the current branch, you can do:  

```sh
git branch -m <newname>
```

A way to remember this is `-m` is for "move" (or `mv`), which is how you rename files.  

If you are on Windows or another case-insensitive filesystem, and there are any capitalization change in the name, you need to use `-M`, otherwise, git will throw <em><strong>branch already exists</strong></em> error:  

```sh
git branch -M <newname>
```

#### Answer 2 (score 412)
```sh
git branch -m old_branch_name new_branch_name
```

The above command will change your branch name, but you have to be very careful using the renamed branch, because it will still refer to the old upstream branch associated with it, if any.  

If you want to push some changes into master after your local branch is renamed into new_branch_name (example name):  

`git push origin new_branch_name:master` (now changes will go to master branch but your local branch name is new_branch_name)  

For more details, see "<a href="http://madhan-tech-updates.blogspot.in/2013/01/how-to-rename-your-local-branch-name-in.html">How to rename your local branch name in Git</a>."  

#### Answer 3 (score 301)
To rename your current branch:  

```sh
git branch -m <newname>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 13: How can I determine the URL that a local Git repository was originally cloned from? (score [2524689](https://stackoverflow.com/q/4089430) in 2015)

#### Question
I pulled a project from GitHub a few days ago. I've since discovered that there are several forks on GitHub, and I neglected to note which one I took originally. How can I determine which of those forks I pulled?  

#### Answer accepted (score 5209)
If you want only the remote URL, or if your are not connected to a network that can reach the remote repo:  

```sh
git config --get remote.origin.url
```

If you require full output and you <em>are</em> on a network that can reach the remote repo where the origin resides :  

```sh
git remote show origin
```

When using `git clone` (from GitHub, or any source repository for that matter) the default name for the source of the clone is "origin". Using `git remote show` will display the information about this remote name. The first few lines should show:  

```sh
C:\Users\jaredpar\VsVim> git remote show origin
* remote origin
  Fetch URL: git@github.com:jaredpar/VsVim.git
  Push  URL: git@github.com:jaredpar/VsVim.git
  HEAD branch: master
  Remote branches:
```

If you want to use the value in the script, you would use the first command listed in this answer.  

#### Answer 2 (score 597)
Should you want this for scripting purposes, you can get only the URL with  

```sh
git config --get remote.origin.url
```

#### Answer 3 (score 514)
You can try:  

```sh
git remote -v
```

It will print all your remotes' fetch/push URLs.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 14: How to resolve merge conflicts in Git (score [2455683](https://stackoverflow.com/q/161813) in 2019)

#### Question
How do I resolve merge conflicts in Git?  

#### Answer accepted (score 2738)
Try: `git mergetool`  

It opens a GUI that steps you through each conflict, and you get to choose how to merge.  Sometimes it requires a bit of hand editing afterwards, but usually it's enough by itself.  It is much better than doing the whole thing by hand certainly.  

As per @JoshGlover comment:  

The command doesn't necessarily open a GUI unless you install one. Running `git mergetool` for me resulted in `vimdiff` being used. You can install one of the following tools to use it instead: `meld`, `opendiff`, `kdiff3`, `tkdiff`, `xxdiff`, `tortoisemerge`, `gvimdiff`, `diffuse`, `ecmerge`, `p4merge`, `araxis`, `vimdiff`, `emerge`.  

Below is the sample procedure to use `vimdiff` for resolve merge conflicts. Based on <a href="http://www.rosipov.com/blog/use-vimdiff-as-git-mergetool/#fromHistor" rel="noreferrer">this link</a>  

<strong>Step 1</strong>: Run following commands in your terminal  

```sh
git config merge.tool vimdiff
git config merge.conflictstyle diff3
git config mergetool.prompt false
```

This will set vimdiff as the default merge tool.  

<strong>Step 2</strong>: Run following command in terminal  

```sh
git mergetool
```

<strong>Step 3</strong>: You will see a vimdiff display in following format   

```sh
  ╔═══════╦══════╦════════╗
  ║       ║      ║        ║
  ║ LOCAL ║ BASE ║ REMOTE ║
  ║       ║      ║        ║
  ╠═══════╩══════╩════════╣
  ║                       ║
  ║        MERGED         ║
  ║                       ║
  ╚═══════════════════════╝
```

These 4 views are   

<blockquote>
  LOCAL – this is file from the current branch    
  
  BASE – common ancestor, how file looked before both changes   
  
  REMOTE – file you are merging into your branch   
  
  MERGED – merge result, this is what gets saved in the repo  
</blockquote>

You can navigate among these views using <kbd>ctrl</kbd>+<kbd>w</kbd>. You can directly reach MERGED view using <kbd>ctrl</kbd>+<kbd>w</kbd> followed by <kbd>j</kbd>.  

More info about vimdiff navigation <a href="https://stackoverflow.com/questions/4556184/vim-move-window-left-right">here</a> and <a href="https://stackoverflow.com/questions/27151456/how-do-i-jump-to-the-next-prev-diff-in-git-difftool">here</a>  

<strong>Step 4</strong>. You could edit the MERGED view the following way   

If you want to get changes from REMOTE  

```sh
:diffg RE  
```

If you want to get changes from BASE  

```sh
:diffg BA  
```

If you want to get changes from LOCAL  

```sh
:diffg LO 
```

<strong>Step 5</strong>. Save, Exit, Commit and Clean up  

`:wqa` save and exit from vi  

`git commit -m "message"`  

`git clean` Remove extra files (e.g. *.orig) created by diff tool.  

#### Answer 2 (score 1662)
Here's a probable use-case, from the top:  

You're going to pull some changes, but oops, you're not up to date:  

```sh
git fetch origin
git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Updating a030c3a..ee25213
error: Entry 'filename.c' not uptodate. Cannot merge.
```

So you get up-to-date and try again, but have a conflict:  

```sh
git add filename.c
git commit -m "made some wild and crazy changes"
git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Auto-merging filename.c
CONFLICT (content): Merge conflict in filename.c
Automatic merge failed; fix conflicts and then commit the result.
```

So you decide to take a look at the changes:  

```sh
git mergetool
```

Oh my, oh my, upstream changed some things, but just to use my changes...no...their changes...  

```sh
git checkout --ours filename.c
git checkout --theirs filename.c
git add filename.c
git commit -m "using theirs"
```

And then we try a final time  

```sh
git pull origin master

From ssh://gitosis@example.com:22/projectname
 * branch            master     -> FETCH_HEAD
Already up-to-date.
```

Ta-da!  

#### Answer 3 (score 718)
I find merge tools rarely help me understand the conflict or the resolution. I'm usually more successful looking at the conflict markers in a text editor and using git log as a supplement.  

Here are a few tips:  

<h5>Tip One</h1>

The best thing I have found is to use the "diff3" merge conflict style:  

`git config merge.conflictstyle diff3`  

This produces conflict markers like this:  

```sh
<<<<<<<
Changes made on the branch that is being merged into. In most cases,
this is the branch that I have currently checked out (i.e. HEAD).
|||||||
The common ancestor version.
=======
Changes made on the branch that is being merged in. This is often a 
feature/topic branch.
>>>>>>>
```

The middle section is what the common ancestor looked like. This is useful because you can compare it to the top and bottom versions to get a better sense of what was changed on each branch, which gives you a better idea for what the purpose of each change was.  

If the conflict is only a few lines, this generally makes the conflict very obvious. (Knowing how to fix a conflict is very different; you need to be aware of what other people are working on. If you're confused, it's probably best to just call that person into your room so they can see what you're looking at.)  

If the conflict is longer, then I will cut and paste each of the three sections into three separate files, such as "mine", "common" and "theirs".  

Then I can run the following commands to see the two diff hunks that caused the conflict:  

```sh
diff common mine
diff common theirs
```

This is not the same as using a merge tool, since a merge tool will include all of the non-conflicting diff hunks too. I find that to be distracting.  

<h5>Tip Two</h1>

Somebody already mentioned this, but understanding the intention behind each diff hunk is generally very helpful for understanding where a conflict came from and how to handle it.  

```sh
git log --merge -p <name of file>
```

This shows all of the commits that touched that file in between the common ancestor and the two heads you are merging. (So it doesn't include commits that already exist in both branches before merging.) This helps you ignore diff hunks that clearly are not a factor in your current conflict.  

<h5>Tip Three</h1>

Verify your changes with automated tools.  

If you have automated tests, run those. If you have a <a href="https://en.wikipedia.org/wiki/Lint_%28software%29">lint</a>, run that. If it's a buildable project, then build it before you commit, etc. In all cases, you need to do a bit of testing to make sure your changes didn't break anything. (Heck, even a merge without conflicts can break working code.)  

<h5>Tip Four</h1>

Plan ahead; communicate with co-workers.  

Planning ahead and being aware of what others are working on can help prevent merge conflicts and/or help resolve them earlier -- while the details are still fresh in mind.   

For example, if you know that you and another person are both working on different refactoring that will both affect the same set of files, you should talk to each other ahead of time and get a better sense for what types of changes each of you is making. You might save considerable time and effort if you conduct your planned changes serially rather than in parallel.   

For major refactorings that cut across a large swath of code, you should strongly consider working serially: everybody stops working on that area of the code while one person performs the complete refactoring.  

If you can't work serially (due to time pressure, maybe), then communicating about expected merge conflicts at least helps you solve the problems sooner while the details are still fresh in mind. For example, if a co-worker is making a disruptive series of commits over the course of a one-week period, you may choose to merge/rebase on that co-workers branch once or twice each day during that week. That way, if you do find merge/rebase conflicts, you can solve them more quickly than if you wait a few weeks to merge everything together in one big lump.  

<h5>Tip Five</h1>

If you're unsure of a merge, don't force it.  

Merging can feel overwhelming, especially when there are a lot of conflicting files and the conflict markers cover hundreds of lines. Often times when estimating software projects we don't include enough time for overhead items like handling a gnarly merge, so it feels like a real drag to spend several hours dissecting each conflict.  

In the long run, planning ahead and being aware of what others are working on are the best tools for anticipating merge conflicts and prepare yourself to resolve them correctly in less time.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 15: How to modify existing, unpushed commit messages? (score [2441373](https://stackoverflow.com/q/179123) in 2019)

#### Question
I wrote the wrong thing in a commit message.  

How can I change the message? The commit has not been pushed yet.  

#### Answer accepted (score 15563)
<h5>Amending the most recent commit message</h1>

```sh
git commit --amend
```

will open your editor, allowing you to change the commit message of the most recent commit. Additionally, you can set the commit message directly in the command line with:  

```sh
git commit --amend -m "New commit message"
```

…however, this can make multi-line commit messages or small corrections more cumbersome to enter.  

Make sure you don't have any working copy changes <em>staged</em> before doing this or they will get committed too. (<em>Unstaged</em> changes will not get committed.)  

<h5>Changing the message of a commit that you've already pushed to your remote branch</h2>

If you've already pushed your commit up to your remote branch, then you'll <a href="https://stackoverflow.com/questions/41003071/why-must-i-force-push-after-changing-a-commit-message">need to force push the commit</a> with:   

```sh
git push <remote> <branch> --force
# Or
git push <remote> <branch> -f
```

<strong>Warning: force-pushing will overwrite the remote branch with the state of your local one</strong>. If there are commits on the remote branch that you don't have in your local branch, you <em>will</em> lose those commits.  

<strong>Warning: be cautious about amending commits that you have already shared with other people.</strong> Amending commits essentially <em>rewrites</em> them to have different <a href="http://en.wikipedia.org/wiki/SHA-1" rel="noreferrer">SHA</a> IDs, which poses a problem if other people have copies of the old commit that you've rewritten. Anyone who has a copy of the old commit will need to synchronize their work with your newly re-written commit, which can sometimes be difficult, so make sure you coordinate with others when attempting to rewrite shared commit history, or just avoid rewriting shared commits altogether.  

<hr>

<h5>Use interactive rebase</h3>

<p>Another option is to use interactive rebase.<br>
This allows you to edit any message you want to update even if it's not the latest message.</p>

In order to do a git squash, follow these steps:  

```sh
// X is the number of commits to the last commit you want to be able to edit
git rebase -i HEAD~X
```

Once you squash your commits - choose the `e/r` for editing the message  

<a href="https://i.stack.imgur.com/LVcm9.png" rel="noreferrer"><img src="https://i.stack.imgur.com/LVcm9.png" alt="enter image description here"></a>  

<h5>Important note about Interactive rebase</h3>

When you use the `git rebase -i HEAD~X` there can be <strong>more</strong> than `X` commits. Git will "collect" all the commits in the last `X` commits and if there was a merge somewhere in between that range you will see all the commits as well so the outcome will be X+.  

<h5>Good tip:</h3>

If you have to do it for more than a single branch and you might face conflicts when amending the content, set up <a href="https://stackoverflow.com/questions/35415925/is-it-possible-to-setup-git-merge-for-automatic-resolving-git-rerere/35417944#35417944">`git rerere`</a> and let git resolve those conflicts automatically for you.  

<hr>

<h5>Documentation</h2>

<ul>
<li><p><a href="https://www.kernel.org/pub/software/scm/git/docs/git-commit.html" rel="noreferrer">git-commit(1) Manual Page</a></p></li>
<li><p><a href="https://www.kernel.org/pub/software/scm/git/docs/git-rebase.html" rel="noreferrer">git-rebase(1) Manual Page</a></p></li>
<li><p><a href="https://www.kernel.org/pub/software/scm/git/docs/git-push.html" rel="noreferrer">git-push(1) Manual Page</a></p></li>
</ul>

#### Answer 2 (score 2471)
```sh
git commit --amend -m "your new message"
```

#### Answer 3 (score 2351)
If the commit you want to fix isn’t the most recent one:  

<ol>
<li><p>`git rebase --interactive $parent_of_flawed_commit`</p>

If you want to fix several flawed commits, pass the parent of the oldest one of them.  </li>
<li><p>An editor will come up, with a list of all commits since the one you gave.</p>

<ol>
<li>Change `pick` to `reword` (or on old versions of Git, to `edit`) in front of any commits you want to fix.</li>
<li>Once you save, Git will replay the listed commits. <br /> <br /></li>
</ol></li>
<li><p>For each commit you want to <em>reword</em>, Git will drop you back into your editor. For each commit you want to <em>edit</em>, Git drops you into the shell. If you’re in the shell:</p>

<ol>
<li>Change the commit in any way you like.</li>
<li>`git commit --amend`</li>
<li>`git rebase --continue`</li>
</ol></li>
</ol>

Most of this sequence will be explained to you by the output of the various commands as you go. It’s very easy, you don’t need to memorise it – just remember that `git rebase --interactive` lets you correct commits no matter how long ago they were.  

<hr>

Note that you will not want to change commits that you have already pushed. Or maybe you do, but in that case you will have to take great care to communicate with everyone who may have pulled your commits and done work on top of them. <a href="https://stackoverflow.com/questions/4084868">How do I recover/resynchronise after someone pushes a rebase or a reset to a published branch?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 16: How do I discard unstaged changes in Git? (score [2381631](https://stackoverflow.com/q/52704) in 2019)

#### Question
How do I discard changes in my working copy that are not in the index?  

#### Answer accepted (score 2515)
Another quicker way is:  

```sh
git stash save --keep-index --include-untracked
```

You don't need to include `--include-untracked` if you don't want to be thorough about it.  

After that, you can drop that stash with a `git stash drop` command if you like.  

#### Answer 2 (score 4950)
For all unstaged files in current working directory use:  

```sh
git checkout -- .
```

For a specific file use:  

```sh
git checkout -- path/to/file/to/revert
```

`--` here to remove <a href="https://git-scm.com/docs/git-checkout#_argument_disambiguation" rel="noreferrer">argument ambiguation</a>.  

#### Answer 3 (score 1803)
It seems like the complete solution is:  

```sh
git clean -df
git checkout -- .
```

<a href="https://git-scm.com/docs/git-clean" rel="noreferrer">`git clean`</a> removes all untracked files (<strong>warning</strong>: while it won't delete ignored files mentioned directly in .gitignore, <strong>it may delete ignored files residing in folders</strong>) and `git checkout` clears all unstaged changes.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 17: Git fetch remote branch (score [2247058](https://stackoverflow.com/q/9537392) in 2019)

#### Question
My colleague and I are working on the same repository we've branched it into two branches each technically for different projects, but they have similarities so we'll sometimes want to commit back to the *`master` from the `branch`.  

However, I have the `branch`. My question is, <strong>how can my colleague pull that branch specifically?</strong>   

A `git clone` of the repo does not seem to create the branches locally for him, though I can see them live on unfuddle after a push on my end.  

Also, when I originally made the branch I did `-b checkout`. <strong><em>Not sure if that makes much difference?</em></strong>  

```sh
$ git branch -r
origin/HEAD -> origin/master
origin/daves_branch
origin/discover
origin/master

$ git fetch origin discover
$ git checkout discover
```

These are the commands I ran. But it definitely is not working.   

<strong>I want to be able to check out that branch and then push and commit back just the branches changes from various collaborators or workstations</strong>.  

#### Answer accepted (score 2768)
You need to create a local branch that tracks a remote branch. The following command will create a local branch named <strong>daves_branch</strong>, tracking the remote branch <strong>origin/daves_branch</strong>. When you push your changes the remote branch will be updated.  

For most recent versions of git:  

```sh
git checkout --track origin/daves_branch
```

`--track` is shorthand for `git checkout -b [branch] [remotename]/[branch]` where [remotename] is <strong>origin</strong> in this case and [branch] is twice the same, <strong>daves_branch</strong> in this case.  

For git 1.5.6.5 you needed this:   

```sh
git checkout --track -b daves_branch origin/daves_branch
```

For git 1.7.2.3 and higher this is enough (might have started earlier but this is the earliest confirmation I could find quickly):  

```sh
git checkout daves_branch
```

<p>Note that with recent git versions, this command will not create a local branch and will put you in a 'detached HEAD' state. If you want a local branch, use the `--track` option.
Full details here: <a href="http://git-scm.com/book/en/v2/Git-Branching-Remote-Branches#Tracking-Branches" rel="noreferrer">http://git-scm.com/book/en/v2/Git-Branching-Remote-Branches#Tracking-Branches</a></p>

#### Answer 2 (score 907)
I have used <a href="https://www.kernel.org/pub/software/scm/git/docs/git-fetch.html" rel="noreferrer">`fetch`</a> followed by <a href="https://www.kernel.org/pub/software/scm/git/docs/git-checkout.html" rel="noreferrer">`checkout`</a>...  

```sh
git fetch <remote> <rbranch>:<lbranch> 
git checkout <lbranch>
```

...where `&lt;rbranch&gt;` is the remote branch or <em>source ref</em> and `&lt;lbranch&gt;` is the as yet <strong>non-existent</strong> local branch or <em>destination ref</em> you want to track and which you probably want to name the same as the remote branch or source ref. This is explained under <a href="https://www.kernel.org/pub/software/scm/git/docs/git-fetch.html#_options" rel="noreferrer">options</a> in the explanation of `&lt;refspec&gt;`.  

<strong>Git is so smart it auto completes the first command if I <em>tab</em> after the first few letters of the remote branch. IE: I don't even have to name the local branch, Git automatically copies the name of the remote branch for me. Thanks Git!</strong>  

Also as <a href="https://stackoverflow.com/a/1783426/1020470">the answer in this similar SO post</a> shows, if you don't name the local branch in `fetch`, you can still create it when you check it out by using the `-b` flag. <em>IE:</em> `git fetch &lt;remote&gt; &lt;branch&gt;` followed by `git checkout -b &lt;branch&gt; &lt;remote&gt;/&lt;branch&gt;` does exactly the same as my initial answer. And evidently if your repo has <em>only one</em> remote, then you can just do `git checkout &lt;branch&gt;` after `fetch` and it will create a local branch for you. <em>EG:</em> You just cloned a repo and want to check out additional branches from the remote.  

I believe that some of the documentation for `fetch` may have been copied verbatim from <a href="https://www.kernel.org/pub/software/scm/git/docs/git-pull.html" rel="noreferrer">`pull`</a>. In particular the section on `&lt;refspec&gt;` in <a href="https://www.kernel.org/pub/software/scm/git/docs/git-pull.html#_options" rel="noreferrer">options</a> is the same. However, I do not believe that `fetch` will ever <a href="https://www.kernel.org/pub/software/scm/git/docs/git-merge.html" rel="noreferrer">`merge`</a>, so that if you leave the destination side of the colon empty `fetch` <strong>should do nothing</strong>.  

NOTE: That `git fetch &lt;remote&gt; &lt;refspec&gt;` is short for `git fetch &lt;remote&gt; &lt;refspec&gt;:` which would therefore do nothing, but `git fetch &lt;remote&gt; &lt;tag&gt;` is the same as `git fetch &lt;remote&gt; &lt;tag&gt;:&lt;tag&gt;` which should copy the remote `&lt;tag&gt;` locally.  

I guess this is only helpful if you want to copy a remote branch locally, but not necessarily check it out right away. Otherwise I now would use <a href="https://stackoverflow.com/a/9537923/1020470">the accepted answer above</a>, which is explained in detail in the first section of the <a href="https://www.kernel.org/pub/software/scm/git/docs/git-checkout.html#_description" rel="noreferrer">checkout description</a> and later in the <a href="https://www.kernel.org/pub/software/scm/git/docs/git-checkout.html#_options" rel="noreferrer">options</a> section under the explanation of `--track`, since it's a 1-liner. <em>Well...</em> sort of a 1-liner, because you would <em>still</em> have to run `git fetch &lt;remote&gt;` first.  

FYI: The order of the `&lt;refspecs&gt;` (source:destination) explains the bizarre pre Git-1.7 method for <a href="http://git-scm.com/book/en/Git-Branching-Remote-Branches#Deleting-Remote-Branches" rel="noreferrer">deleting remote branches</a>. IE: Push nothing into the destination refspec.  

#### Answer 3 (score 347)
If you are trying to "checkout" a new remote branch (that exists only on the remote, but not locally), here's what you'll need:  

```sh
git fetch origin
git checkout --track origin/<remote_branch_name>
```

This assumes you want to fetch from <em>origin</em>. If not, replace <em>origin</em> by your <em>remote</em> name.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 18: How to remove local (untracked) files from the current Git working tree (score [2119033](https://stackoverflow.com/q/61212) in 2019)

#### Question
How do you delete untracked local files from your current working tree?  

#### Answer accepted (score 8380)
As per the Git Documentation <a href="https://git-scm.com/docs/git-clean" rel="noreferrer">git clean</a>  

<blockquote>
  Remove untracked files from the working tree  
</blockquote>

<hr>

Step 1 is to show what will be deleted by using the `-n` option:  

```sh
# Print out the list of files which will be removed (dry run)
git clean -n
```

Clean Step - <strong>beware: this will delete files</strong>:  

```sh
# Delete the files from the repository
git clean -f
```

<ul>
<li>To remove directories, run `git clean -f -d` or `git clean -fd`</li>
<li>To remove ignored files, run `git clean -f -X` or `git clean -fX`</li>
<li>To remove ignored and non-ignored files, run `git clean -f -x` or `git clean -fx`</li>
</ul>

<strong>Note</strong> the case difference on the `X` for the two latter commands.  

If `clean.requireForce` is set to "true" (the default) in your configuration, one needs to specify `-f` otherwise nothing will actually happen.  

Again see the <a href="http://git-scm.com/docs/git-clean" rel="noreferrer">`git-clean`</a> docs for more information.  

<hr>

<h5>Options</h1>

<blockquote>
  <strong>`-f`, `--force`</strong>    
  
  <p>If the Git configuration variable clean.requireForce is not set to
  false, git clean will refuse to run unless given `-f`, `-n` or `-i`.</p>
  
  <strong>`-x`</strong>  
  
  <p>Don’t use the standard ignore rules read from .gitignore (per
  directory) and `$GIT_DIR/info/exclude`, but do still use the ignore
  rules given with `-e` options. This allows removing all untracked files,
  including build products. This can be used (possibly in conjunction
  with git reset) to create a pristine working directory to test a clean
  build.</p>
  
  <strong>`-X`</strong>  
  
  <p>Remove only files ignored by Git. This may be useful to rebuild
  everything from scratch, but keep manually created files.</p>
  
  <strong>`-n`, `--dry-run`</strong>  
  
  Don’t actually remove anything, just show what would be done.  
  
  <strong>`-d`</strong>  
  
  <p>Remove untracked directories in addition to untracked files. If an
  untracked directory is managed by a different Git repository, it is
  not removed by default. Use `-f` option twice if you really want to
  remove such a directory.</p>
</blockquote>

#### Answer 2 (score 921)
Use `git clean -f -d` to make sure that <strong>directories</strong> are also removed.  

```sh
-n, -dry-run
```

Don’t actually remove anything, just show what would be done.  

```sh
-d
```

Remove untracked directories in addition to untracked files. If an untracked directory is managed by a different Git repository, it is not removed by default. Use -f option twice if you really want to remove such a directory.  

You can then check if your files are really gone with `git status`.  

#### Answer 3 (score 450)
I am surprised nobody mentioned this before:  

```sh
git clean -i
```

That stands for <em>interactive</em> and you will get a quick overview of what is going to be deleted offering you the possibility to include/exclude the affected files. Overall, still faster than running the mandatory `--dry-run` before the real cleaning.  

You will have to toss in a `-d` if you also want to take care of empty folders. At the end, it makes  for a nice alias:  

```sh
git iclean
```

That being said, the extra hand holding of interactive commands can be tiring for experienced users.  These days I just use the already mentioned `git clean -fd`   

</b> </em> </i> </small> </strong> </sub> </sup>

### 19: Delete commits from a branch in Git (score [2101706](https://stackoverflow.com/q/1338728) in 2018)

#### Question
I would like to know how to delete a commit.  

By `delete`, I mean it is as if I didn't make that commit, and when I do a push in the future, my changes will not push to the remote branch.  

I read git help, and I think the command I should use is `git reset --hard HEAD`.  Is this correct?  

#### Answer accepted (score 3810)
<strong>Careful:</strong> `git reset --hard` <em>WILL DELETE YOUR WORKING DIRECTORY CHANGES</em>. Be sure to <strong>stash any local changes you want to keep</strong> before running this command.  

Assuming you are sitting on that commit, then this command will wack it...  

```sh
git reset --hard HEAD~1
```

The `HEAD~1` means the commit before head.  

Or, you could look at the output of `git log`, find the commit id of the commit you want to back up to, and then do this:  

```sh
git reset --hard <sha1-commit-id>
```

<hr/>

If you already pushed it, you will need to do a force push to get rid of it...  

```sh
git push origin HEAD --force
```

<strong>However</strong>, if others may have pulled it, then you would be better off starting a new branch.  Because when they pull, it will just merge it into their work, and you will get it pushed back up again.  

If you already pushed, it may be better to use `git revert`, to create a "mirror image" commit that will undo the changes.  However, both commits will be in the log.  

<hr />

FYI -- `git reset --hard HEAD` is great if you want to get rid of WORK IN PROGRESS.  It will reset you back to the most recent commit, and erase all the changes in your working tree and index.  

<hr />

Lastly, if you need to find a commit that you "deleted", it is typically present in `git reflog` unless you have garbage collected your repository.  

#### Answer 2 (score 672)
If you have not yet pushed the commit anywhere, you can use <a href="http://git-scm.com/docs/git-rebase" rel="noreferrer">`git rebase -i`</a> to remove that commit. First, find out how far back that commit is (approximately). Then do:  

```sh
git rebase -i HEAD~N
```

The `~N` means rebase the last `N` commits (`N` must be a number, for example `HEAD~10`). Then, you can edit the file that Git presents to you to delete the offending commit. On saving that file, Git will then rewrite all the following commits as if the one you deleted didn't exist.  

The Git Book has a good <a href="http://git-scm.com/book/en/Git-Branching-Rebasing" rel="noreferrer">section on rebasing</a> with pictures and examples.  

Be careful with this though, because if you change something that you <em>have</em> pushed elsewhere, another approach will be needed unless you are planning to do a force push.  

#### Answer 3 (score 473)
Another possibility is one of my personal favorite commands:  

```sh
git rebase -i <commit>~1
```

This will start the rebase in interactive mode `-i` at the point just before the commit you want to whack. The editor will start up listing all of the commits since then. Delete the line containing the commit you want to obliterate and save the file. Rebase will do the rest of the work, deleting only that commit, and replaying all of the others back into the log.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 20: How can I delete a file from a Git repository? (score [2100597](https://stackoverflow.com/q/2047465) in 2019)

#### Question
I have added a file named `"file1.txt"` to a Git repository. After that, I committed it, added a couple of directories called `dir1` and `dir2`, and committed them to the Git repository.  

Now the current repository has `"file1.txt"`, `dir1`, and `dir2`. How can I delete `"file1.txt"` without affecting others, like `dir1` and `dir2`?  

#### Answer accepted (score 2900)
Use <a href="https://git-scm.com/docs/git-rm" rel="noreferrer">`git rm`</a>:  

```sh
git rm file1.txt
git commit -m "remove file1.txt"
```

But if you want to remove the file only from the Git repository and not remove it from the filesystem, use:    

```sh
git rm --cached file1.txt
git commit -m "remove file1.txt"
```

And to push changes to remote repo  

```sh
git push origin branch_name  
```

#### Answer 2 (score 594)
`git rm file.txt` removes the file from the repo but <strong>also deletes it from the local file system</strong>.  

<p>To remove the file from the repo and <strong>not</strong> delete it from the local file system use:<br>
`git rm --cached file.txt` </p>

The below exact situation is where I use git to maintain version control for my business's website, but the "mickey" directory was a tmp folder to share private content with a CAD developer. When he needed HUGE files, I made a private, unlinked directory and ftpd the files there for him to fetch via browser. Forgetting I did this, I later performed a `git add -A` from the website's base directory. Subsequently, `git status` showed the new files needing committing. Now I needed to delete them from git's tracking and version control...  

Sample output below is from what just happened to me, where I unintentionally deleted the `.003` file. Thankfully, I don't care what happened to the local copy to `.003`, but some of the other currently changed files were updates I just made to the website and would be epic to have been deleted on the local file system! "Local file system" = the live website <em>(not a great practice, but is reality)</em>.  



```sh
[~/www]$ git rm shop/mickey/mtt_flange_SCN.7z.003
error: 'shop/mickey/mtt_flange_SCN.7z.003' has local modifications
(use --cached to keep the file, or -f to force removal)
[~/www]$ git rm -f shop/mickey/mtt_flange_SCN.7z.003
rm 'shop/mickey/mtt_flange_SCN.7z.003'
[~/www]$ 
[~/www]$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   deleted:    shop/mickey/mtt_flange_SCN.7z.003
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#   modified:   shop/mickey/mtt_flange_SCN.7z.001
#   modified:   shop/mickey/mtt_flange_SCN.7z.002
[~/www]$ ls shop/mickey/mtt_flange_S*
shop/mickey/mtt_flange_SCN.7z.001  shop/mickey/mtt_flange_SCN.7z.002
[~/www]$ 
[~/www]$ 
[~/www]$ git rm --cached shop/mickey/mtt_flange_SCN.7z.002
rm 'shop/mickey/mtt_flange_SCN.7z.002'
[~/www]$ ls shop/mickey/mtt_flange_S*
shop/mickey/mtt_flange_SCN.7z.001  shop/mickey/mtt_flange_SCN.7z.002
[~/www]$ 
[~/www]$ 
[~/www]$ git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#   deleted:    shop/mickey/mtt_flange_SCN.7z.002
#   deleted:    shop/mickey/mtt_flange_SCN.7z.003
#
# Changed but not updated:
#   modified:   shop/mickey/mtt_flange_SCN.7z.001
[~/www]$
```

<strong>Update:</strong> This answer is getting some traffic, so I thought I'd mention my <a href="https://stackoverflow.com/questions/9069061">other Git answer</a> shares a couple of great resources: <a href="http://nvie.com/posts/a-successful-git-branching-model/" rel="noreferrer">This page</a> has a graphic that help demystify Git for me. The <a href="http://git-scm.com/book" rel="noreferrer">"Pro Git" book is online</a> and helps me a lot.  

#### Answer 3 (score 68)
First, if you are using <a href="https://git-scm.com/docs/git-rm" rel="nofollow noreferrer">`git rm`</a>, especially for multiple files, consider any wildcard will be resolved by the shell, not by the `git` command.  

```sh
git rm -- *.anExtension
git commit -m "remove multiple files"
```

But, if your file is already on GitHub, <a href="https://github.com/blog/1545-deleting-files-on-github" rel="nofollow noreferrer">you can (since July 2013)</a> directly delete it from the web GUI!  

<blockquote>
  Simply view any file in your repository, click the trash can icon at the top, and commit the removal just like any other web-based edit.  
</blockquote>

<p>Then "`git pull`" on your local repo, and that will delete the file locally too.<br>
Which makes this answer a (roundabout) way to delete a file from git repo?<br>
(Not to mention that a file on GitHub <em>is</em> in a "git repo")</p>

<hr>

<a href="https://i.stack.imgur.com/259au.jpg" rel="nofollow noreferrer"><img src="https://i.stack.imgur.com/259au.jpg" alt="delete button"></a>  

(the commit will reflect the deletion of that file):  

<img src="https://i.stack.imgur.com/fgXe9.png" alt="commit a deletion">  

<blockquote>
  And just like that, it’s gone.  
  
  For help with these features, be sure to read our help articles on <a href="https://help.github.com/articles/creating-new-files" rel="nofollow noreferrer">creating</a>, <a href="https://help.github.com/articles/moving-a-file-to-a-new-location" rel="nofollow noreferrer">moving</a>, <a href="https://help.github.com/articles/renaming-a-file" rel="nofollow noreferrer">renaming</a>, and <a href="https://help.github.com/articles/deleting-files" rel="nofollow noreferrer">deleting</a> files.  
  
  Note: Since it’s a version control system, Git always has your back if you need to recover the file later.   
</blockquote>

The last sentence means that the deleted file is still part of the history, and you can restore it easily enough (but not yet through the GitHub web interface):   

See "<a href="https://stackoverflow.com/q/953481/6309">Restore a deleted file in a Git repo</a>".  

</b> </em> </i> </small> </strong> </sub> </sup>

### 21: How do you create a remote Git branch? (score [1980171](https://stackoverflow.com/q/1519006) in 2017)

#### Question
I created a local branch which I want to 'push' upstream. There is a similar question here on Stack Overflow on how to track a newly created remote branch.   

However, my workflow is slightly different. <strong>First</strong> I want to create a local branch, and I will only push it upstream when I'm satisfied and want to share my branch.  

<ul>
<li>How would I do that? (my google searches did not seem to come up with anything).</li>
<li>How would I tell my colleagues to pull it from the upstream repository?</li>
</ul>

<strong>UPDATE With Git 2.0 there is a simpler answer</strong> I have written below: <a href="https://stackoverflow.com/a/27185855/109305">https://stackoverflow.com/a/27185855/109305</a>  

#### Answer accepted (score 309)
<h5>Simple Git 2.0+ solution:</h2>

As of <strong>Git 2.0 the behaviour has become simpler</strong>:   

You can configure git with <strong>`push.default = current`</strong> to make life easier:  

I added this so now I can just push a new branch upstream with  

```sh
$ git push -u
```

`-u` will track remote branch of same name. Now with this configuration you will auto-guess the remote reference to git push. From <a href="http://git-scm.com/docs/git-config" rel="noreferrer">git.config documentation</a>:  

<blockquote>
  <strong>push.default</strong>   
  
  Defines the action git push should take if no refspec is explicitly given.  
  
  <p><strong>`push.default = current`</strong> - push the current branch to update a branch with the 
  same name on the receiving end. Works in both central and non-central workflows.</p>
</blockquote>

For me, this is a good simplification of my day-to-day Git workflow. The configuration setting takes care of the 'usual' use case where you add a branch locally and want to create it remotely. Also, I can just as easily create local branches from remotes by just doing `git co remote_branch_name` (as opposed to using `--set-upstream-to` flag).   

I know this question and the accepted answers are rather old, but the behaviour has changed so that now configuration options exists to make your workflow simpler.   

To add to your global Git configuration, run this on the command line:  

```sh
$ git config --global push.default current
```

#### Answer 2 (score 3610)
First, you create your branch locally:  

```sh
git checkout -b <branch-name> # Create a new branch and check it out
```

The remote branch is automatically created when you push it to the remote server. So when you feel ready for it, you can just do:  

```sh
git push <remote-name> <branch-name> 
```

Where `&lt;remote-name&gt;` is typically `origin`, the name which git gives to the remote you cloned from. Your colleagues would then just pull that branch, and it's automatically created locally.  

Note however that formally, the format is:  

```sh
git push <remote-name> <local-branch-name>:<remote-branch-name>
```

But when you omit one, it assumes both branch names are the same. Having said this, as a word of <strong>caution</strong>, do not make the critical mistake of specifying only `:&lt;remote-branch-name&gt;` (with the colon), or the remote branch will be deleted!  

So that a subsequent `git pull` will know what to do, you might instead want to use:  

```sh
git push --set-upstream <remote-name> <local-branch-name> 
```

As described below, the `--set-upstream` option sets up an upstream branch:  

<blockquote>
  <p>For every branch that is up to date or
  successfully pushed, add upstream
  (tracking) reference, used by
  argument-less git-pull(1) and other
  commands.</p>
</blockquote>

#### Answer 3 (score 854)
First, you must create your branch locally  

```sh
git checkout -b your_branch
```

After that, you can work locally in your branch, when you are ready to share the branch, push it. The next command push the branch to the remote repository origin and tracks it  

```sh
git push -u origin your_branch
```

Teammates can reach your branch, by doing:  

```sh
git fetch
git checkout origin/your_branch
```

You can continue working in the branch and pushing whenever you want without passing arguments to git push (argumentless git push will push the master to remote master, your_branch local to remote your_branch, etc...)  

```sh
git push
```

Teammates can push to your branch by doing commits and then push explicitly  

```sh
... work ...
git commit
... work ...
git commit
git push origin HEAD:refs/heads/your_branch
```

Or tracking the branch to avoid the arguments to git push  

```sh
git checkout --track -b your_branch origin/your_branch
... work ...
git commit
... work ...
git commit
git push
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 22: Undo a Git merge that hasn't been pushed yet (score [1960312](https://stackoverflow.com/q/2389361) in 2016)

#### Question
Within my master branch, I did a `git merge some-other-branch` locally, but never pushed the changes to origin master. I didn't mean to merge, so I'd like to undo it. When doing a `git status` after my merge, I was getting this message:  

```sh
# On branch master
# Your branch is ahead of 'origin/master' by 4 commits.
```

Based upon some <a href="http://www.gitready.com/intermediate/2009/03/16/rolling-back-changes-with-revert.html" rel="noreferrer">instructions I found</a>, I tried running  

```sh
git revert HEAD -m 1
```

but now I'm getting this message with `git status`:  

```sh
# On branch master
# Your branch is ahead of 'origin/master' by 5 commits.
```

I don't want my branch to be ahead by any number of commits. How do I get back to that point?  

#### Answer accepted (score 4068)
With `git reflog` check which commit is one prior the merge (`git reflog` will be a better option than `git log`). Then you can reset it using:  

```sh
git reset --hard commit_sha
```

There's also another way:  

```sh
git reset --hard HEAD~1
```

It will get you back 1 commit.  

<strong>Be aware that any modified and uncommitted/unstashed files will be reset to their unmodified state</strong>. To keep them either stash changes away or see `--merge` option below.    

<hr>

As @Velmont suggested below in his answer, in this direct case using:  

```sh
git reset --hard ORIG_HEAD
```

might yield better results, as it should preserve your changes. `ORIG_HEAD` will point to a commit directly before merge has occurred, so you don't have to hunt for it yourself.  

<hr>

A further tip is to use the `--merge` switch instead of `--hard` since it doesn't reset files unnecessarily:  

```sh
git reset --merge ORIG_HEAD
```

<blockquote>
  --merge  
  
  Resets the index and updates the files in the working tree that are different between &lt;commit&gt; and HEAD, but keeps those which are different between the index and working tree (i.e. which have changes which have not been added).   
</blockquote>

#### Answer 2 (score 1396)
Assuming your local master was not ahead of origin/master, you should be able to do  

```sh
git reset --hard origin/master
```

Then your local `master` branch should look identical to `origin/master`.  

#### Answer 3 (score 1146)
See <a href="http://git-scm.com/book/en/Git-Basics-Undoing-Things" rel="noreferrer">chapter 4 in the Git book</a> and <a href="http://opensource.apple.com/source/Git/Git-26/src/git-htmldocs/howto/revert-a-faulty-merge.txt" rel="noreferrer">the original post by Linus Torvalds</a>.  

To undo a merge <strong>that was already pushed</strong>:  

```sh
git revert -m 1 commit_hash
```

Be sure to revert the revert if you're committing the branch again, like Linus said.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 23: How can I reset or revert a file to a specific revision? (score [1760694](https://stackoverflow.com/q/215718) in 2019)

#### Question
I have made some changes to a file which has been committed a few times as part of a group of files, but now want to reset/revert the changes on it back to a previous version.   

I have done a `git log` along with a `git diff` to find the revision I need, but just have no idea how to get the file back to its former state in the past.  

#### Answer accepted (score 5679)
Assuming the hash of the commit you want is `c5f567`:  

```sh
git checkout c5f567 -- file1/to/restore file2/to/restore
```

The <a href="https://git-scm.com/docs/git-checkout" rel="noreferrer">git checkout</a> man page gives more information.  

If you want to revert to the commit before `c5f567`, append `~1` (works with any number):  

```sh
git checkout c5f567~1 -- file1/to/restore file2/to/restore
```

As a side note, I've always been uncomfortable with this command because it's used for both ordinary things (changing between branches) and unusual, destructive things (discarding changes in the working directory).  

#### Answer 2 (score 581)
You can quickly review the changes made to a file using the diff command:  

```sh
git diff <commit hash> <filename>
```

Then to revert a specific file to that commit use the reset command:  

```sh
git reset <commit hash> <filename>
```

You may need to use the `--hard` option if you have local modifications.  

A good workflow for managaging waypoints is to use tags to cleanly mark points in your timeline. I can't quite understand your last sentence but what you may want is diverge a branch from a previous point in time. To do this, use the handy checkout command:  

```sh
git checkout <commit hash>
git checkout -b <new branch name>
```

You can then rebase that against your mainline when you are ready to merge those changes:  

```sh
git checkout <my branch>
git rebase master
git checkout master
git merge <my branch>
```

#### Answer 3 (score 347)
You can use any reference to a git commit, including the SHA-1 if that's most convenient. The point is that the command looks like this:  

`git checkout [commit-ref] -- [filename]`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 24: How do you clone a Git repository into a specific folder? (score [1749479](https://stackoverflow.com/q/651038) in 2016)

#### Question
Executing the command `git clone git@github.com:whatever` creates a directory in my current folder named whatever, and drops the contents of the Git repository into that folder:  

```sh
/httpdocs/whatever/public
```

My problem is that I need the contents of the Git repository cloned into my current directory so that they appear in the proper location for the web server:  

```sh
/httpdocs/public
```

I know how to move the files after I've cloned the repository, but this seems to break Git, and I'd like to be able to update just by calling `git pull`. How can I do this?  

#### Answer accepted (score 2940)
<strong>Option A:</strong>  

```sh
git clone git@github.com:whatever folder-name
```

Ergo, for `right here` use:  

```sh
git clone git@github.com:whatever .
```

<strong>Option B:</strong>  

Move the `.git` folder, too. Note that the `.git` folder is hidden in most graphical file explorers, so be sure to show hidden files.  

```sh
mv /where/it/is/right/now/* /where/I/want/it/
mv /where/it/is/right/now/.* /where/I/want/it/
```

The first line grabs all normal files, the second line grabs dot-files. It is also possibe to do it in one line by enabling dotglob (i.e. `shopt -s dotglob`) but that is probably a bad solution if you are asking the question this answer answers.  

<strong>Better yet:</strong>  

Keep your working copy somewhere else, and create a symbolic link. Like this:  

```sh
ln -s /where/it/is/right/now /the/path/I/want/to/use
```

For you case this would be something like:  

```sh
ln -sfn /opt/projectA/prod/public /httpdocs/public
```

Which easily could be changed to test if you wanted it, i.e.:  

```sh
ln -sfn /opt/projectA/test/public /httpdocs/public
```

without moving files around. Added `-fn` in case someone is copying these lines (`-f` is force,  `-n` avoid some often unwanted interactions with already and non-existing links).   

If you just want it to work, use Option A, if someone else is going to look at what you have done, use Option C.  

#### Answer 2 (score 578)
The example I think a lot of people asking this question are after is this. If you are <em>in</em> the directory you want the contents of the git repository dumped to, run:  

```sh
git clone git@github.com:whatever .
```

The "." at the end specifies the current folder as the checkout folder.  

#### Answer 3 (score 208)
Go into the folder.. If the folder is empty, then:  

```sh
git clone git@github.com:whatever .
```

else  

```sh
git init
git remote add origin PATH/TO/REPO
git fetch
git checkout -t origin/master
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 25: Message 'src refspec master does not match any' when pushing commits in Git (score [1674634](https://stackoverflow.com/q/4181861) in 2019)

#### Question
I clone my repository with:  

```sh
git clone ssh://xxxxx/xx.git 
```

But after I change some files and `add` and `commit` them, I want to push them to the server:  

```sh
git add xxx.php
git commit -m "TEST"
git push origin master
```

But the error I get back is:  

```sh
error: src refspec master does not match any.  
error: failed to push some refs to 'ssh://xxxxx.com/project.git'
```

#### Answer 2 (score 3735)
Maybe you just need to commit. I ran into this when I did:  

```sh
mkdir repo && cd repo
git remote add origin /path/to/origin.git
git add .
```

Oops! Never committed!  

```sh
git push -u origin master
error: src refspec master does not match any.
```

All I had to do was:  

```sh
git commit -m "initial commit"
git push origin master
```

Success!  

#### Answer 3 (score 762)
<ol>
<li><p>Try `git show-ref` to see what refs do you have. Is there `refs/heads/master`?</p></li>
<li><p>You can try `git push origin HEAD:master` as more local-reference-independent solution. This explicitly states that you want to push the local ref `HEAD` to the remote ref `master` (see the <a href="https://git-scm.com/docs/git-push#git-push-ltrefspecgt82308203" rel="noreferrer">git-push refspec</a> documentation).</p></li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 26: I ran into a merge conflict. How can I abort the merge? (score [1595425](https://stackoverflow.com/q/101752) in 2018)

#### Question
I used `git pull` and had a merge conflict:  

```sh
unmerged:   _widget.html.erb

You are in the middle of a conflicted merge.
```

I know that the other version of the file is good and that mine is bad so all my changes should be abandoned. How can I do this?  

#### Answer 2 (score 2093)
Since your `pull` was unsuccessful then `HEAD` (not `HEAD^`) is the last "valid" commit on your branch:  

```sh
git reset --hard HEAD
```

The other piece you want is to let their changes over-ride your changes.    

Older versions of git allowed you to use the "theirs" merge strategy:  

```sh
git pull --strategy=theirs remote_branch
```

But this has since been removed, as explained in <a href="http://marc.info/?l=git&amp;m=121637513604413&amp;w=2" rel="noreferrer">this message by Junio Hamano</a> (the Git maintainer).  As noted in <a href="http://marc.info/?l=git&amp;m=121637513604413&amp;w=2" rel="noreferrer">the link</a>, instead you would do this:  

```sh
git fetch origin
git reset --hard origin
```

#### Answer 3 (score 1851)
If your git version is >= 1.6.1, you can use `git reset --merge`.  

Also, as @Michael Johnson mentions, if your git version is >= 1.7.4, you can also use `git merge --abort`.  

As always, make sure you have no uncommitted changes before you start a merge.  

From the <a href="https://www.kernel.org/pub/software/scm/git/docs/git-merge.html" rel="noreferrer">git merge man page</a>  

`git merge --abort` is equivalent to `git reset --merge` when `MERGE_HEAD` is present.  

`MERGE_HEAD` is present when a merge is in progress.  

Also, regarding uncommitted changes when starting a merge:  

If you have changes you don't want to commit before starting a merge, just `git stash` them  before the merge and `git stash pop` after finishing the merge or aborting it.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 27: Difference between "git add -A" and "git add ." (score [1568771](https://stackoverflow.com/q/572549) in 2013)

#### Question
The command `git add [--all|-A]` appears to be identical to `git add .`. Is this correct? If not, how do they differ?  

#### Answer accepted (score 4037)
<em>This answer only applies to <strong>Git version 1.x</strong>. For Git version 2.x, see other answers.</em>  

<hr>

<strong>Summary:</strong>  

<ul>
<li><p>`git add -A` stages <strong>all changes</strong></p></li>
<li><p>`git add .` stages new files and modifications, <strong>without deletions</strong></p></li>
<li><p>`git add -u` stages modifications and deletions, <strong>without new files</strong></p></li>
</ul>

<hr>

<strong>Detail:</strong>  

`git add -A` is equivalent to  `git add .; git add -u`.  

The important point about `git add .` is that it looks at the working tree and adds all those paths to the staged changes if they are either changed or are new and not ignored, it does not stage any 'rm' actions.  

`git add -u` looks at all the <em>already</em> tracked files and stages the changes to those files if they are different or if they have been removed. It does not add any new files, it only stages changes to already tracked files.  

`git add -A` is a handy shortcut for doing both of those.  

You can test the differences out with something like this (note that for Git version 2.x your output for `git add .` `git status` <strong>will</strong> be different):  

```sh
git init
echo Change me > change-me
echo Delete me > delete-me
git add change-me delete-me
git commit -m initial

echo OK >> change-me
rm delete-me
echo Add me > add-me

git status
# Changed but not updated:
#   modified:   change-me
#   deleted:    delete-me
# Untracked files:
#   add-me

git add .
git status

# Changes to be committed:
#   new file:   add-me
#   modified:   change-me
# Changed but not updated:
#   deleted:    delete-me

git reset

git add -u
git status

# Changes to be committed:
#   modified:   change-me
#   deleted:    delete-me
# Untracked files:
#   add-me

git reset

git add -A
git status

# Changes to be committed:
#   new file:   add-me
#   modified:   change-me
#   deleted:    delete-me
```

#### Answer 2 (score 852)
Here is a table for quick understanding:  

<strong>Git Version 1.x</strong>:  

<img src="https://i.stack.imgur.com/YfLUZ.jpg" alt="Enter image description here">  

<strong>Git Version 2.x</strong>:  

<img src="https://i.stack.imgur.com/KwOLu.jpg" alt="Enter image description here">  

Long-form flags:  

<ul>
<li>`git add -A` is equivalent to `git add --all`</li>
<li>`git add -u` is equivalent to `git add --update`</li>
</ul>

<strong>Further reading:</strong>  

<ul>
<li><em><a href="https://stackoverflow.com/questions/315911/git-for-beginners-the-definitive-practical-guide">Git for beginners: The definitive practical guide</a></em></li>
<li><em><a href="https://try.github.io/levels/1/challenges/1" rel="noreferrer">Got 15 minutes and want to learn Git? (in an interactive way)</a></em></li>
<li><em><a href="http://pcottle.github.io/learnGitBranching/" rel="noreferrer">Learn Git Branching</a></em></li>
<li><em><a href="https://onlywei.github.io/explain-git-with-d3/" rel="noreferrer">Explain Git With D3</a></em></li>
</ul>

#### Answer 3 (score 161)
With <a href="https://github.com/git/git/blob/f99a38c0121456822f8a9dfb7928eefceaa98201/Documentation/RelNotes/2.0.0.txt#L32-L36" rel="noreferrer"><strong>Git 2.0, `git add -A` is default: `git add .` equals `git add -A .`</strong></a>.    

<blockquote>
  <p>`git add &lt;path&gt;` is the same as "`git add -A &lt;path&gt;`" now, so that
  "`git add dir/`" will notice paths you removed from the directory and
  record the removal.<br>
  In older versions of Git, "`git add &lt;path&gt;`" used to ignore removals.  </p>
  
  <p>You can say "`git add --ignore-removal &lt;path&gt;`" to
  add only added or modified paths in `&lt;path&gt;`, if you really want to.</p>
</blockquote>

<p>`git add` is like `git add :/` (<a href="https://stackoverflow.com/a/31951899/6309">add everything from top git repo folder</a>).<br>
Note that git 2.7 (Nov. 2015) will allow you to add a folder named "`:`"!<br>
See <a href="https://github.com/git/git/commit/29abb33978f713cd0a5cc3687bf61077b0928840" rel="noreferrer">commit 29abb33</a> (25 Oct 2015) by <a href="https://github.com/gitster" rel="noreferrer">Junio C Hamano (`gitster`)</a>.  </p>

<hr>

Note that <a href="https://github.com/git/git/blob/master/Documentation/RelNotes/1.8.3.txt#L19-L30" rel="noreferrer">starting git 2.0 (Q1 or Q2 2014)</a>, when talking about <strong>`git add .`</strong> (current path within the working tree), you must use '`.`' in the other `git add` commands as well.  

That means:  

<blockquote>
  "`git add -A .`" is equivalent to "`git add .; git add -u .`"  
</blockquote>

(Note the extra '`.`' for `git add -A` and `git add -u`)  

Because `git add -A` or `git add -u` would operate (starting git 2.0 only) on the <strong>entire working tree</strong>, and not just on the current path.  

<blockquote>
  <p>Those commands will <strong>operate on the entire tree in Git 2.0 for consistency with "`git commit -a`" and other commands</strong>.
  Because there will be no mechanism to make "`git add -u`" behave as if "`git add -u .`", it is important for those who are used to "`git add -u`" (without pathspec) updating the index only for paths in the current subdirectory to start training their fingers to explicitly say "`git add -u .`" when they mean it before Git 2.0 comes.</p>
  
  <p><strong>A warning is issued when these commands are run without a pathspec and when you have local changes outside the current directory</strong>, because the behaviour in Git 2.0 will be different
  from today's version in such a situation.</p>
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 28: View the change history of a file using Git versioning (score [1532762](https://stackoverflow.com/q/278192) in 2017)

#### Question
How can I view the change history of an individual file in Git, complete details with what has changed?  

I have got as far as:   

```sh
git log -- [filename]
```

which shows me the commit history of the file, but how do I get at the content of each of the file changes?  

I'm trying to make the transition from MS SourceSafe and that used to be a simple `right-click` → `show history`.  

#### Answer accepted (score 2222)
For this I'd use:  

```sh
gitk [filename]
```

or to follow filename past renames  

```sh
gitk --follow [filename]
```

#### Answer 2 (score 2083)
You can use   

```sh
git log -p filename
```

to let git generate the patches for each log entry.   

See  

```sh
git help log
```

for more options - it can actually do a lot of nice things :) To get just the diff for a specific commit you can   

```sh
git show HEAD 
```

or any other revision by identifier. Or use   

```sh
gitk
```

to browse the changes visually.  

#### Answer 3 (score 1389)
`git log --follow -p -- path-to-file`  

This will show the <strong>entire</strong> history of the file (including history beyond renames and with diffs for each change).  

In other words, if the file named `bar` was once named `foo`, then `git log -p bar` (without the `--follow` option) will only show the file's history up to the point where it was renamed -- it won't show the file's history when it was known as `foo`. Using `git log --follow -p bar` will show the file's entire history, including any changes to the file when it was known as `foo`. The `-p` option ensures that diffs are included for each change.      

</b> </em> </i> </small> </strong> </sub> </sup>

### 29: Squash my last X commits together using Git (score [1425969](https://stackoverflow.com/q/5189560) in 2017)

#### Question
How can I squash my last X commits together into one commit using Git?  

#### Answer accepted (score 1819)
Use `git rebase -i &lt;after-this-commit&gt;` and replace "pick" on the second and subsequent commits with "squash" or "fixup", as described in <a href="http://git-scm.com/docs/git-rebase#_interactive_mode">the manual</a>.  

In this example, `&lt;after-this-commit&gt;` is either the SHA1 hash or the relative location from the HEAD of the current branch from which commits are analyzed for the rebase command. For example, if the user wishes to view 5 commits from the current HEAD in the past the command is `git rebase -i HEAD~5`.   

#### Answer 2 (score 3450)
You can do this fairly easily without `git rebase` or `git merge --squash`. In this example, we'll squash the last 3 commits.  

If you want to write the new commit message from scratch, this suffices:  

```sh
git reset --soft HEAD~3 &&
git commit
```

If you want to start editing the new commit message with a concatenation of the existing commit messages (i.e. similar to what a pick/squash/squash/…/squash `git rebase -i` instruction list would start you with), then you need to extract those messages and pass them to `git commit`:  

```sh
git reset --soft HEAD~3 && 
git commit --edit -m"$(git log --format=%B --reverse HEAD..HEAD@{1})"
```

Both of those methods squash the last three commits into a single new commit in the same way. The soft reset just re-points HEAD to the last commit that you do not want to squash. Neither the index nor the working tree are touched by the soft reset, leaving the index in the desired state for your new commit (i.e. it already has all the changes from the commits that you are about to “throw away”).  

#### Answer 3 (score 693)
You can use `git merge --squash` for this, which is slightly more elegant than `git rebase -i`.  Suppose you're on master and you want to squash the last 12 commits into one.  

WARNING: First make sure you commit your work—check that `git status` is clean (since `git reset --hard` will throw away staged and unstaged changes)  

Then:  

```sh
# Reset the current branch to the commit just before the last 12:
git reset --hard HEAD~12

# HEAD@{1} is where the branch was just before the previous command.
# This command sets the state of the index to be as it would just
# after a merge from that commit:
git merge --squash HEAD@{1}

# Commit those squashed changes.  The commit message will be helpfully
# prepopulated with the commit messages of all the squashed commits:
git commit
```

The <a href="http://www.kernel.org/pub/software/scm/git/docs/git-merge.html" rel="noreferrer">documentation for `git merge`</a> describes the `--squash` option in more detail.  

<hr>

<em>Update:</em> the only real advantage of this method over the simpler `git reset --soft HEAD~12 &amp;&amp; git commit` suggested by Chris Johnsen in <a href="https://stackoverflow.com/questions/5189560/how-can-i-squash-my-last-x-commits-together-using-git/5201642#5201642">his answer</a> is that you get the commit message prepopulated with every commit message that you're squashing.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 30: Comparing two branches in Git? (score [1416596](https://stackoverflow.com/q/9834689) in 2015)

#### Question
I have two branches, `branch_1` and `branch_2`.   

I want to see the differences between the two branches in Git.  

#### Answer 2 (score 2890)
```sh
git diff branch_1..branch_2
```

That will produce the diff between the tips of the two branches. If you'd prefer to find the diff from their common ancestor to test, you can use three dots instead of two:  

```sh
git diff branch_1...branch_2
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 31: What is the best (and safest) way to merge a Git branch into master? (score [1403349](https://stackoverflow.com/q/5601931) in 2019)

#### Question
A new branch from `master` is created, we call it `test`.  

There are several developers who either commit to `master` or create other branches and later merge into `master`.  

Let's say work on `test` is taking several days and you want to continuously keep `test` updated with commits inside `master`.  

I would do `git pull origin master` from `test`.   

<strong>Question 1:</strong> Is this the right approach?  Other developers could have easily worked on same files as I have worked btw.  

<hr>

My work on `test` is done and I am ready to merge it back to `master`. Here are the two ways I can think of:  

<strong>A:</strong>    

```sh
git checkout test
git pull origin master
git push origin test
git checkout master
git pull origin test 
```

<strong>B:</strong>   

```sh
git checkout test
git pull origin master
git checkout master
git merge test
```

I am not using `--rebase` because from my understanding, rebase will get the changes from `master` and stack mine on top of that hence it could overwrite changes other people made.  

<strong>Question 2:</strong> Which one of these two methods is right?  What is the difference there?  

The goal in all of this is to keep my `test` branch updated with the things happening in `master` and later I could merge them back into `master` hoping to keep the timeline as linear as possible.  

#### Answer accepted (score 2791)
How I would do this  

```sh
git checkout master
git pull origin master
git merge test
git push origin master
```

If I have a local branch from a remote one, I don't feel comfortable with merging other branches than this one with the remote. Also I would not push my changes, until I'm happy with what I want to push and also I wouldn't push things at all, that are only for me and my local repository. In your description it seems, that `test` is only for you? So no reason to publish it.  

git always tries to respect yours and others changes, and so will `--rebase`. I don't think I can explain it appropriately, so have a look at <a href="http://git-scm.com/book/en/Git-Branching-Rebasing" rel="noreferrer">the Git book - Rebasing</a> or <a href="http://gitready.com/intermediate/2009/01/31/intro-to-rebase.html" rel="noreferrer">git-ready: Intro into rebasing</a> for a little description. It's a quite cool feature  

#### Answer 2 (score 357)
This is a very practical question, but all the answers above are not practical.  

Like  

```sh
git checkout master
git pull origin master
git merge test
git push origin master
```

This approach has <strong>two issues</strong>:  

<ol>
<li><p>It's unsafe, because we don't know if there are any conflicts between test branch and master branch.</p></li>
<li><p>It would "squeeze" all test commits into one merge commit on master; that is to say on master branch, we can't see the all change logs of test branch.</p></li>
</ol>

So, when we suspect there would some conflicts, we can have following git operations:  

```sh
git checkout test
git pull 
git checkout master
git pull
git merge --no-ff --no-commit test
```

Test `merge` before `commit`, avoid a fast-forward commit by `--no-ff`,  

If conflict is encountered, we can run `git status` to check details about the conflicts and try to solve   

```sh
git status
```

Once we solve the conflicts, or if there is no conflict, we `commit` and `push` them  

```sh
git commit -m 'merge test branch'
git push
```

But this way will lose the changes history logged in test branch, and it would make master branch to be hard for other developers to understand the history of the project.  

So the best method is we have to use `rebase` instead of `merge` (suppose, when in this time, we have solved the branch conflicts).  

Following is one simple sample, for advanced operations, please refer to <a href="http://git-scm.com/book/en/v2/Git-Branching-Rebasing" rel="noreferrer">http://git-scm.com/book/en/v2/Git-Branching-Rebasing</a>  

```sh
git checkout master
git pull
git checkout test
git pull
git rebase -i master
git checkout master
git merge test
```

Yep, when you have uppers done, all the Test branch's commits will be moved onto the head of Master branch. The major benefit of rebasing is that you get a linear and much cleaner project history.  

The only thing you need to avoid is: never use `rebase` on public branch, like master branch.  

<strong>Never do operations</strong> like the following:  

```sh
git checkout master
git rebase -i test
```

Details for <a href="https://www.atlassian.com/git/tutorials/merging-vs-rebasing/the-golden-rule-of-rebasing" rel="noreferrer">https://www.atlassian.com/git/tutorials/merging-vs-rebasing/the-golden-rule-of-rebasing</a>  

appendix:  

<ul>
<li>if you are not sure about rebasing operations, please refer to: <a href="https://git-scm.com/book/en/v2/Git-Branching-Rebasing" rel="noreferrer">https://git-scm.com/book/en/v2/Git-Branching-Rebasing</a> </li>
</ul>

#### Answer 3 (score 87)
Neither a rebase nor a merge should overwrite anyone's changes (unless you choose to do so when resolving a conflict).  

The usual approach while developing is  

```sh
git checkout master
git pull
git checkout test
git log master.. # if you're curious
git merge origin/test # to update your local test from the fetch in the pull earlier
```

When you're ready to merge back into master,  

```sh
git checkout master
git log ..test # if you're curious
git merge test
git push
```

If you're worried about breaking something on the merge, `git merge --abort` is there for you.  

Using push and then pull as a means of merging is silly. I'm also not sure why you're pushing test to origin.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 32: How to change the URI (URL) for a remote Git repository? (score [1386571](https://stackoverflow.com/q/2432764) in 2018)

#### Question
I have a repo (origin) on a USB key that I cloned on my hard drive (local). I moved "origin" to a NAS and successfully tested cloning it from here.  

I would like to know if I can change the URI of "origin" in the settings of "local" so it will now pull from the NAS, and not from the USB key.  

For now, I can see two solutions:  

<ul>
<li><p>push everything to the usb-orign, and copy it to the NAS again (implies a lot of work due to new commits to nas-origin);</p></li>
<li><p>add a new remote to "local" and delete the old one (I fear I'll break my history).</p></li>
</ul>

#### Answer accepted (score 5612)
You can  

```sh
git remote set-url origin new.git.url/here
```

(see `git help remote`) or you can just edit `.git/config` and change the URLs there. You're not in any danger of losing history unless you do something very silly (and if you're worried, just make a copy of your repo, since your repo <em>is</em> your history.)  

#### Answer 2 (score 771)
```sh
git remote -v
# View existing remotes
# origin  https://github.com/user/repo.git (fetch)
# origin  https://github.com/user/repo.git (push)

git remote set-url origin https://github.com/user/repo2.git
# Change the 'origin' remote's URL

git remote -v
# Verify new remote URL
# origin  https://github.com/user/repo2.git (fetch)
# origin  https://github.com/user/repo2.git (push)
```

<a href="http://help.github.com/articles/changing-a-remote-s-url">Changing a remote's URL</a>  

#### Answer 3 (score 89)
<a href="http://pseudofish.com/blog/2010/06/28/change-host-for-a-git-origin-server/" rel="noreferrer">Change Host for a Git Origin Server</a>  

from: <a href="http://pseudofish.com/blog/2010/06/28/change-host-for-a-git-origin-server/" rel="noreferrer">http://pseudofish.com/blog/2010/06/28/change-host-for-a-git-origin-server/</a>  

Hopefully this isn’t something you need to do. The server that I’ve been using to collaborate on a few git projects with had the domain name expire. This meant finding a way of migrating the local repositories to get back in sync.  

Update: Thanks to @mawolf for pointing out there is an easy way with recent git versions (post Feb, 2010):  

```sh
git remote set-url origin ssh://newhost.com/usr/local/gitroot/myproject.git
```

See the man page for details.  

If you’re on an older version, then try this:  

As a caveat, this works only as it is the same server, just with different names.  

Assuming that the new hostname is `newhost.com`, and the old one was `oldhost.com`, the change is quite simple.  

Edit the `.git/config` file in your working directory. You should see something like:  

```sh
[remote "origin"]
fetch = +refs/heads/*:refs/remotes/origin/*
url = ssh://oldhost.com/usr/local/gitroot/myproject.git
```

Change `oldhost.com` to `newhost.com`, save the file and you’re done.  

From my limited testing (`git pull origin; git push origin; gitx`) everything seems in order. And yes, I know it is bad form to mess with git internals.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 33: How do I revert all local changes in Git managed project to previous state? (score [1362819](https://stackoverflow.com/q/1146973) in 2015)

#### Question
<p>I have a project in which I ran `git init`.
After several commits, I did `git status` which told me everything was up to date and there were no local changes. </p>

Then I made several consecutive changes and realized I wanted to throw everything away and get back to my original state. Will this command do it for me?  

```sh
git reset --hard HEAD
```

#### Answer accepted (score 3210)
If you want to revert changes made to your working copy, do this:  

```sh
git checkout .
```

If you want to revert changes made to the index (i.e., that you have added), do this. <strong>Warning this will reset all of your unpushed commits to master!</strong>:  

```sh
git reset
```

If you want to revert a change that you have committed, do this:  

```sh
git revert <commit 1> <commit 2>
```

If you want to remove untracked files (e.g., new files, generated files):  

```sh
git clean -f
```

Or untracked directories (e.g., new or automatically generated directories):    

```sh
git clean -fd
```

#### Answer 2 (score 373)
Note: You may also want to run   

```sh
git clean -fd
```

as  

```sh
git reset --hard
```

will <em>not</em> remove untracked files, where as git-clean will remove any files from the tracked root directory that are not under git tracking. WARNING - BE CAREFUL WITH THIS! It is helpful to run a dry-run with git-clean first, to see what it will delete.  

This is also especially useful when you get the error message  

```sh
~"performing this command will cause an un-tracked file to be overwritten"
```

Which can occur when doing several things, one being updating a working copy when you and your friend have both added a new file of the same name, but he's committed it into source control first, and you don't care about deleting your untracked copy.  

In this situation, doing a dry run will also help show you a list of files that would be overwritten.  

#### Answer 3 (score 113)
<h5>Re-clone</h1>

```sh
GIT=$(git rev-parse --show-toplevel)
cd $GIT/..
rm -rf $GIT
git clone ...
```

<ul>
<li>✅ Deletes local, non-pushed commits</li>
<li>✅ Reverts changes you made to tracked files</li>
<li>✅ Restores tracked files you deleted</li>
<li>✅ Deletes files/dirs listed in `.gitignore` (like build files)</li>
<li>✅ Deletes files/dirs that are not tracked and not in `.gitignore`</li>
<li>😀 You won't forget this approach</li>
<li>😔 Wastes bandwidth</li>
</ul>

<hr>

Following are other commands I forget daily.  

<h5>Clean and reset</h1>

```sh
git clean --force -d -x
git reset --hard
```

<ul>
<li>❌ Deletes local, non-pushed commits</li>
<li>✅ Reverts changes you made to tracked files</li>
<li>✅ Restores tracked files you deleted</li>
<li>✅ Deletes files/dirs listed in `.gitignore` (like build files)</li>
<li>✅ Deletes files/dirs that are not tracked and not in `.gitignore`</li>
</ul>

<h5>Clean</h1>

```sh
git clean --force -d -x
```

<ul>
<li>❌ Deletes local, non-pushed commits</li>
<li>❌ Reverts changes you made to tracked files</li>
<li>❌ Restores tracked files you deleted</li>
<li>✅ Deletes files/dirs listed in `.gitignore` (like build files)</li>
<li>✅ Deletes files/dirs that are not tracked and not in `.gitignore`</li>
</ul>

<h5>Reset</h1>

```sh
git reset --hard
```

<ul>
<li>❌ Deletes local, non-pushed commits</li>
<li>✅ Reverts changes you made to tracked files</li>
<li>✅ Restores tracked files you deleted</li>
<li>❌ Deletes files/dirs listed in `.gitignore` (like build files)</li>
<li>❌ Deletes files/dirs that are not tracked and not in `.gitignore`</li>
</ul>

<hr>

<h5>Notes</h2>

<strong>Test case for confirming all the above (use bash or sh):</strong>  

```sh
mkdir project
cd project
git init
echo '*.built' > .gitignore
echo 'CODE' > a.sourceCode
mkdir b
echo 'CODE' > b/b.sourceCode
cp -r b c
git add .
git commit -m 'Initial checkin'
echo 'NEW FEATURE' >> a.sourceCode
cp a.sourceCode a.built
rm -rf c
echo 'CODE' > 'd.sourceCode'
```

<strong>See also</strong>  

<ul>
<li><a href="https://git-scm.com/docs/git-revert" rel="noreferrer">`git revert`</a> to make new commits that undo prior commits</li>
<li><a href="https://git-scm.com/docs/git-checkout" rel="noreferrer">`git checkout`</a> to go back in time to prior commits (may require running above commands first)</li>
<li><a href="https://git-scm.com/docs/git-stash" rel="noreferrer">`git stash`</a> same as `git reset` above, but you can undo it</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 34: How to list all the files in a commit? (score [1353105](https://stackoverflow.com/q/424071) in 2015)

#### Question
I am looking for a simple `git` command that provides a nicely formatted list of all files that were part of the commit given by a hash (SHA1), with no extraneous information.  

I have tried:  

```sh
git show a303aa90779efdd2f6b9d90693e2cbbbe4613c1d
```

Although it lists the files, it also includes unwanted diff information for each.  

Is there another `git` command that will provide just the list I want, so that I can avoid parsing it from the `git show` output?  

#### Answer accepted (score 3451)
<strong>Preferred Way</strong> (because it's a <em>plumbing</em> command; meant to be programmatic):  

```sh
$ git diff-tree --no-commit-id --name-only -r bd61ad98
index.html
javascript/application.js
javascript/ie6.js
```

<strong>Another Way</strong> (less preferred for scripts, because it's a <em>porcelain</em> command; meant to be user-facing)  

```sh
$ git show --pretty="" --name-only bd61ad98    
index.html
javascript/application.js
javascript/ie6.js
```

<hr>

<ul>
<li>The `--no-commit-id` suppresses the commit ID output.</li>
<li>The `--pretty` argument specifies an empty format string to avoid the cruft at the beginning.</li>
<li>The `--name-only` argument shows only the file names that were affected (Thanks Hank). Use `--name-status` instead, if you want to see what happened to each file (<strong>D</strong>eleted, <strong>M</strong>odified, <strong>A</strong>dded)</li>
<li>The `-r` argument is to recurse into sub-trees</li>
</ul>

#### Answer 2 (score 220)
If you want to get list of changed files:  

```sh
git diff-tree --no-commit-id --name-only -r <commit-ish>
```

If you want to get list of all files in a commit, you can use  

```sh
git ls-tree --name-only -r <commit-ish>
```

#### Answer 3 (score 208)
I'll just assume that `gitk` is not desired for this. In that case, try `git show --name-only &lt;sha&gt;`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 35: Download a specific tag with Git (score [1311826](https://stackoverflow.com/q/791959) in 2017)

#### Question
I'm trying to figure out how I can download a particular tag of a Git repository - it's one version behind the current version.  

I saw there was a tag for the previous version on the git web page, with object name of something long hex number.   

But the version name is "`Tagged release 1.1.5`" according the site.  

I tried a command like this (with names changed):  

```sh
git clone http://git.abc.net/git/abc.git my_abc
```

And I did get something - a directory, a bunch of subdirectories, etc.    

If it's the whole repository, how do I get at the version I'm seeking? If not, how do I download that particular version?   

#### Answer accepted (score 2810)
```sh
$ git clone
```

will give you the whole repository.  

After the clone, you can list the tags with `$ git tag -l` and then checkout a specific tag:  

```sh
$ git checkout tags/<tag_name>
```

Even better, checkout and create a branch (otherwise you will be on a branch named after the revision number of tag):  

```sh
$ git checkout tags/<tag_name> -b <branch_name>
```

#### Answer 2 (score 385)
```sh
git clone --branch my_abc http://git.abc.net/git/abc.git
```

Will clone the repo and leave you on the tag you are interested in.  

Documentation for 1.8.0 of <strong>git clone</strong> states.  

<blockquote>
  --branch can also take tags and detaches the HEAD at that commit in the resulting repository.  
</blockquote>

#### Answer 3 (score 155)
For checking out only a given tag for deployment, I use e.g.:  

```sh
git clone -b 'v2.0' --single-branch --depth 1 https://github.com/git/git.git
```

This seems to be the fastest way to check out code from a remote repository if one has only interest in the most recent code instead of in a complete repository. In this way, it resembles the 'svn co' command.  

Note: Per <a href="https://git-scm.com/docs/git-clone" rel="noreferrer">the Git manual</a>, passing the `--depth` flag implies `--single-branch` by default.  

<blockquote>
  --depth   
  
  Create a shallow clone with a history truncated to the specified number of commits. Implies --single-branch unless --no-single-branch is given to fetch the histories near the tips of all branches. If you want to clone submodules shallowly, also pass --shallow-submodules.  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 36: How to get the current branch name in Git? (score [1309177](https://stackoverflow.com/q/6245570) in 2016)

#### Question
I'm from a Subversion background and, when I had a branch, I knew what I was working on with "These working files point to this branch".  

But with Git I'm not sure when I am editing a file in NetBeans or Notepad++, whether it's tied to the master or another branch.  

There's no problem with `git` in bash, it tells me what I'm doing.  

#### Answer accepted (score 1831)
```sh
git branch
```

should show all the local branches of your repo. The starred branch is your current branch.  

If you want to retrieve only the name of the branch you are on, you can do:  

```sh
git branch | grep \* | cut -d ' ' -f2
```

#### Answer 2 (score 4456)
To display the current branch you're on, without the other branches listed, you can do the following:<br/>  

```sh
git rev-parse --abbrev-ref HEAD
```

Reference:  

<ul>
<li><a href="https://stackoverflow.com/a/1418022/367456">Show just the current branch in Git (Sep 2009)</a></li>
</ul>

#### Answer 3 (score 493)
You have also `git symbolic-ref HEAD` which displays the full refspec.  

To show only the branch name in Git v1.8 and later (thank's to Greg for pointing that out):  

```sh
$ git symbolic-ref --short HEAD
```

On Git v1.7+ you can also do:  

```sh
$ git rev-parse --abbrev-ref HEAD
```

Both should give the same branch name if you're on a branch. If you're on a detached head answers differ.  

<blockquote>
  <strong><em>Note:</em></strong>  
  
  On an earlier client, this seems to work:  

```sh
$ git symbolic-ref HEAD | sed -e "s/^refs\/heads\///"
```
  
  –  <em>Darien 26. Mar 2014</em>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 37: Make an existing Git branch track a remote branch? (score [1272353](https://stackoverflow.com/q/520650) in 2014)

#### Question
I know how to make a new branch that tracks remote branches, but <strong>how do I make an existing branch track a remote branch?</strong>  

I know I can just edit the `.git/config` file, but it seems there should be an easier way.  

#### Answer accepted (score 4145)
Given a branch `foo` and a remote `upstream`:  

<strong>As of Git 1.8.0:</strong>  

```sh
git branch -u upstream/foo
```

Or, if local branch `foo` is not the current branch:  

```sh
git branch -u upstream/foo foo
```

Or, if you like to type longer commands, these are equivalent to the above two:  

```sh
git branch --set-upstream-to=upstream/foo

git branch --set-upstream-to=upstream/foo foo
```

<strong>As of Git 1.7.0:</strong>  

```sh
git branch --set-upstream foo upstream/foo
```

<strong>Notes:</strong>  

<ul>
<li>All of the above commands will cause local branch `foo` to track remote branch `foo` from remote `upstream`.  </li>
<li>The old (1.7.x) syntax is deprecated in favor of the new (1.8+) syntax.  The new syntax is intended to be more intuitive and easier to remember.</li>
<li>Defining the upstream will fail with newly created remotes that have not been fetched. In that case run `git fetch upstream` beforehand.</li>
</ul>

<hr>

See also: <a href="https://stackoverflow.com/q/6089294/95706">Why do I need to do `--set-upstream` all the time?</a>  

#### Answer 2 (score 232)
You can do the following (assuming you are checked out on master and want to push to a remote branch master):  

Set up the 'remote' if you don't have it already  

```sh
git remote add origin ssh://...
```

Now configure master to know to track:  

```sh
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
```

And push:  

```sh
git push origin master
```

#### Answer 3 (score 156)
I do this as a side-effect of pushing with the `-u` option as in  

```sh
$ git push -u origin branch-name
```

The equivalent long option is `--set-upstream`.  

The `git-branch` command also understands `--set-upstream`, but its use can be confusing. <a href="https://lkml.org/lkml/2012/10/1/419" rel="noreferrer">Version 1.8.0</a> modifies the interface.  

<blockquote>
  `git branch --set-upstream` is deprecated and may be removed in a relatively distant future.  `git branch [-u|--set-upstream-to]` has been introduced with a saner order of arguments.  
  
  &hellip;  
  
  It was tempting to say `git branch --set-upstream origin/master`, but that tells Git to arrange the local branch "origin/master" to integrate with the currently checked out branch, which is highly unlikely what the user meant. The option is deprecated; use the new `--set-upstream-to` (with a short-and-sweet `-u`) option instead.  
</blockquote>

Say you have a local `foo` branch and want it to treat the branch by the same name as its upstream. Make this happen with  

```sh
$ git branch foo
$ git branch --set-upstream-to=origin/foo
```

or just  

```sh
$ git branch --set-upstream-to=origin/foo foo
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 38: Fix a Git detached head? (score [1238695](https://stackoverflow.com/q/10228760) in 2018)

#### Question
I was doing some work in my repository and noticed a file had local changes. I didn't want them anymore so I deleted the file, thinking I can just checkout a fresh copy. I wanted to do the Git equivalent of  

```sh
svn up .
```

Using `git pull` didn't seem to work. Some random searching led me to a site where someone recommended doing  

```sh
git checkout HEAD^ src/
```

(`src` is the directory containing the deleted file).  

<strong>Now I find out I have a detached head. I have no idea what that is. How can I undo?</strong>  

#### Answer accepted (score 1868)
Detached head means you are no longer on a branch, you have checked out a single commit in the history (in this case the commit previous to HEAD, i.e. HEAD^).  

<h5>If you want to <em>delete</em> your changes associated with the detached HEAD</h2>

You only need to checkout the branch you were on, e.g.   

```sh
git checkout master
```

Next time you have changed a file and want to restore it to the state it is in the index, don't delete the file first, just do  

```sh
git checkout -- path/to/foo
```

This will restore the file foo to the state it is in the index.   

<h5>If you want to <em>keep</em> your changes associated with the detached HEAD</h2>

<ol>
<li>Run `git log -n 1`; this will display the most recent commit on the detached HEAD. Copy the commit hash.</li>
<li>Run `git checkout master`</li>
<li>Run `git branch tmp &lt;commit-hash&gt;`. This will save your changes in a new branch called `tmp`.</li>
<li>If you would like to incorporate the changes you made into `master`, run `git merge tmp` from the `master` branch. You should be on the `master` branch after running `git checkout master`.</li>
</ol>

#### Answer 2 (score 446)
If you have changed files you don't want to lose, you can push them. I have committed them in the detached mode and after that you can move to a temporary branch to integrate later in master.  

```sh
git commit -m "....."
git branch my-temporary-work
git checkout master
git merge my-temporary-work
```

Extracted from:   

<a href="https://stackoverflow.com/questions/7124486/what-to-do-with-commit-made-in-a-detached-head/7124513#7124513">What to do with commit made in a detached head</a>  

#### Answer 3 (score 143)
<strong>A solution without creating a temporary branch.</strong>  

How to exit (“fix”) detached HEAD state <em>when you already changed something in this mode</em> and, optionally, want to save your changes:  

<ol>
<li><p><strong>Commit changes you want to keep.</strong> If you want to take over any of the changes you made in detached HEAD state, commit them. Like:</p>

```sh
git commit -a -m "your commit message"
```</li>
<li><p><strong>Discard changes you do not want to keep.</strong> The hard reset will discard any uncommitted changes that you made in detached HEAD state:</p>

```sh
git reset --hard
```

(Without this, step 3 would fail, complaining about modified uncommitted files in the detached HEAD.)  </li>
<li><p><strong>Check out your branch.</strong> Exit detached HEAD state by checking out the branch you worked on before, for example:</p>

```sh
git checkout master
```</li>
<li><p><strong>Take over your commits.</strong> You can now take over the commits you made in detached HEAD state by cherry-picking, as shown in <a href="https://stackoverflow.com/a/15774498/1270008">my answer to another question</a>.</p>

```sh
git reflog
git cherry-pick <hash1> <hash2> <hash3> …
```</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 39: Git refusing to merge unrelated histories on rebase (score [1194768](https://stackoverflow.com/q/37937984) in 2019)

#### Question
During `git rebase origin/development` the following error message is shown from Git:  

```sh
fatal: refusing to merge unrelated histories
Error redoing merge 1234deadbeef1234deadbeef
```

My Git version is 2.9.0. It used to work fine in the previous version.   

How can I continue this rebase allowing unrelated histories with the forced flag introduced in the new release?  

#### Answer 2 (score 2284)
The default behavior has changed since Git 2.9:  

<blockquote>
  <p>"git merge" used to allow merging two branches that have no common
     base by default, which led to a brand new history of an existing
     project created and then get pulled by an unsuspecting maintainer,
     which allowed an unnecessary parallel history merged into the
     existing project. The command has been taught <strong>not to allow this by
     default</strong>, with an escape hatch `--allow-unrelated-histories` option
     to be used in a rare event that merges histories of two projects
     that started their lives independently.</p>
</blockquote>

See the <a href="https://github.com/git/git/blob/master/Documentation/RelNotes/2.9.0.txt#L58-L68" rel="noreferrer">Git release changelog</a> for more information.  

You can use `--allow-unrelated-histories` to force the merge to happen.  

#### Answer 3 (score 999)
In my case, the error was just `fatal: refusing to merge unrelated histories` on every try, especially the first pull request after remotely adding a Git repository.  

Using the `--allow-unrelated-histories` flag worked with a pull request in this way:  

```sh
git pull origin branchname --allow-unrelated-histories
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 40: How to fetch all Git branches (score [1191591](https://stackoverflow.com/q/10312521) in 2018)

#### Question
I cloned a Git repository, which contains about five branches. However, when I do `git branch` I only see one of them:  

```sh
$ git branch
* master
```

I know that I can do `git branch -a` to see <strong>all</strong> the branches, but how would I pull all the branches locally so when I do `git branch`, it shows the following?  

```sh
$ git branch
* master
* staging
* etc...
```

#### Answer accepted (score 1791)
You can fetch all branches from all remotes like this:  

```sh
git fetch --all
```

It's basically a <a href="https://www.atlassian.com/git/tutorials/syncing/git-fetch" rel="noreferrer">power move</a>.   

`fetch` updates local copies of remote branches so this is always safe for your local branches <strong>BUT</strong>:  

<ol>
<li><p>`fetch` will not <strong>update</strong> local branches (which <strong>track</strong> remote branches); if you want to update your local branches you still need to pull every branch. </p></li>
<li><p>`fetch` will not <strong>create</strong> local branches (which <strong>track</strong> remote branches), you have to do this manually. If you want to list all remote branches:
`git branch -a`</p></li>
</ol>

To <strong>update</strong> local branches which track remote branches:  

```sh
git pull --all
```

However, this can be still insufficient. It will work only for your local branches which track remote branches. To track all remote branches execute this oneliner <strong>BEFORE</strong> `git pull --all`:  

```sh
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
```

<h5>TL;DR version</h3>

```sh
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch --all
git pull --all
```

(It seems that pull fetches all branches from all remotes, but I always fetch first just to be sure.)  

Run the first command only if there are remote branches on the server that aren't tracked by your local branches.  

P.S. AFAIK `git fetch --all` and `git remote update` are equivalent.  

<hr>

<hr>

Kamil Szot's <a href="https://stackoverflow.com/questions/10312521/how-to-fetch-all-git-branches#comment27984640_10312587">comment</a>, which folks have found useful.  

<blockquote>
  I had to use:  

```sh
for remote in `git branch -r`; do git branch --track ${remote#origin/} $remote; done
```
  
  <p>because your code created local branches named `origin/branchname` and
  I was getting "refname 'origin/branchname' is ambiguous whenever I
  referred to it.</p>
</blockquote>

#### Answer 2 (score 628)
<p>To list remote branches:<br>
`git branch -r` </p>

<p>You can check them out as local branches with:<br>
`git checkout -b LocalName origin/remotebranchname`</p>

#### Answer 3 (score 181)
You will need to create local branches tracking remote branches.  

Assuming that you've got only one remote called `origin`, this snippet will create local branches for all remote tracking ones:  

```sh
for b in `git branch -r | grep -v -- '->'`; do git branch --track ${b##origin/} $b; done
```

After that, `git fetch --all` will update all local copies of remote branches.  

Also, `git pull --all` will update your local tracking branches, but depending on your local commits and how the 'merge' configure option is set it might create a merge commit, fast-forward or fail.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 41: How do I properly force a Git push? (score [1164381](https://stackoverflow.com/q/5509543) in 2017)

#### Question
I've set up a remote non-bare "main" repo and cloned it to my computer. I made some local changes, updated my local repository, and pushed the changes back to my remote repo. Things were fine up to that point.  

Now, I had to change something in the remote repo. Then I changed something in my local repo. I realized that the change to the remote repo was not needed. So I tried to `git push` from my local repo to my remote repo, but I got an error like:  

<blockquote>
  <p>To prevent you from losing history, non-fast-forward updates were
  rejected Merge the remote changes before pushing again.  See the 'Note
  about fast-forwards' section of `git push --help` for details.</p>
</blockquote>

I thought that probably a  

```sh
git push --force
```

would force my local copy to push changes to the remote one and make it the same. <strong>It does force the update</strong>, but when I go back to the remote repo and make a commit, I notice that the files contain outdated changes (ones that the main remote repo previously had).  

As I mentioned in the <a href="https://stackoverflow.com/questions/5509543/how-do-i-properly-force-a-git-push#comment6275726_5509588">comments to one of the answers</a>:  

<blockquote>
  [I] tried forcing, but when going back to master server to save the changes, i get outdated staging. Thus, when i commit the repositories are not the same. And when i try to use git push again, i get the same error.  
</blockquote>

How can I fix this issue?  

#### Answer accepted (score 2168)
Just do:  

```sh
git push origin <your_branch_name> --force
```

or if you have a specific repo:  

```sh
git push https://git.... --force
```

This will delete your previous commit(s) and push your current one.  

It may not be proper, but if anyone stumbles upon this page, thought they might want a simple solution...  

<h5>Short flag</h3>

Also note that `-f` is short for `--force`, so  

```sh
git push origin <your_branch_name> -f
```

will also work.  

#### Answer 2 (score 235)
And if `push --force` doesn't work you can do <strong>`push --delete`</strong>. Look at 2<sup>nd</sup> line on this instance:  

```sh
git reset --hard HEAD~3  # reset current branch to 3 commits ago
git push origin master --delete  # do a very very bad bad thing
git push origin master  # regular push
```

But beware...  

<h5>Never ever go back on a public git history!</h1>

In other words:  

<ul>
<li>Don't ever `force` push on a public repository.</li>
<li>Don't do this or anything that can break someone's `pull`.</li>
<li>Don't ever `reset` or `rewrite` history in a <em>repo</em> someone might have already pulled.</li>
</ul>

Of course there are exceptionally rare exceptions even to this rule, but in most cases it's not needed to do it and it will generate problems to everyone else.  

<h5>Do a revert instead.</h1>

And <strong>always be careful with what you push to a public repo</strong>. Reverting:  

```sh
git revert -n HEAD~3..HEAD  # prepare a new commit reverting last 3 commits
git commit -m "sorry - revert last 3 commits because I was not careful"
git push origin master  # regular push
```

In effect, <strong>both</strong> origin HEADs (from the <strong>revert</strong> and from the <strong>evil reset</strong>) will contain the same files.  

<hr>

<h5>edit to add updated info and more arguments around `push --force`</h3>

<h5>Consider pushing force with lease instead of push, but still prefer revert</h2>

Another problem `push --force` may bring is when someone push anything before you do, but after you've already fetched. If you push force your <em>rebased</em> version now you will <strong>replace work from others</strong>.  

`git push --force-with-lease` introduced in the <a href="https://raw.github.com/git/git/master/Documentation/RelNotes/1.8.5.txt" rel="noreferrer">git 1.8.5</a> (<a href="https://stackoverflow.com/questions/3166713/git-how-to-ignore-fast-forward-and-revert-origin-branch-to-earlier-commit/18505634#18505634">thanks to @VonC</a> comment on the question) tries to address this specific issue. Basically, it will bring an error and not push if the remote was modified since your latest fetch.  

This is good if you're really sure a `push --force` is needed, but still want to prevent more problems. I'd go as far to say it should be the default `push --force` behaviour. But it's still far from being an excuse to force a `push`. People who <em>fetched</em> before your <em>rebase</em> will still have lots of troubles, which could be easily avoided if you had <em>reverted</em> instead.  

And since we're talking about `git --push` instances...  

<h5>Why would anyone want to force push?</h2>

<a href="https://stackoverflow.com/users/1031218/linquize">@linquize</a> brought a good push force example on the comments: <strong>sensitive data</strong>. You've wrongly leaked data that shouldn't be pushed. If you're fast enough, you can <em>"fix"</em>`*` it by forcing a push on top.  

`*` The <a href="http://git-scm.com/book/en/Git-Internals-Maintenance-and-Data-Recovery" rel="noreferrer">data will still be on the remote</a> unless you also do a <a href="https://stackoverflow.com/questions/3162786/how-to-do-git-gc-on-git-remote-repository">garbage collect</a>, or <a href="https://stackoverflow.com/a/8295172/274502">clean it somehow</a>. There is also the obvious potential for it to be spread by others who'd <em>fetched</em> it already, but you get the idea.  

#### Answer 3 (score 18)
First of all, I would not make any changes directly in the "main" repo. If you really want to have a "main" repo, then you should only push to it, never change it directly.  

Regarding the error you are getting, have you tried `git pull` from your local repo, and then `git push` to the main repo? What you are currently doing (if I understood it well) is forcing the push and then losing your changes in the "main" repo. You should merge the changes locally first.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 42: How to clone all remote branches in Git? (score [1148399](https://stackoverflow.com/q/67699) in 2017)

#### Question
I have a `master` and a `development` branch, both pushed to <a href="http://en.wikipedia.org/wiki/GitHub" rel="noreferrer">GitHub</a>. I've `clone`d, `pull`ed, and `fetch`ed, but I remain unable to get anything other than the `master` branch back.  

I'm sure I'm missing something obvious, but I have read the manual and I'm getting no joy at all.  

#### Answer accepted (score 4373)
First, clone a remote <a href="http://en.wikipedia.org/wiki/Git_%28software%29" rel="noreferrer">Git</a> repository and <a href="http://en.wikipedia.org/wiki/Cd_%28command%29" rel="noreferrer">cd</a> into it:  

```sh
$ git clone git://example.com/myproject
$ cd myproject
```

Next, look at the local branches in your repository:  

```sh
$ git branch
* master
```

But there are other branches hiding in your repository! You can see these using the `-a` flag:  

```sh
$ git branch -a
* master
  remotes/origin/HEAD
  remotes/origin/master
  remotes/origin/v1.0-stable
  remotes/origin/experimental
```

If you just want to take a quick peek at an upstream branch, you can check it out directly:  

```sh
$ git checkout origin/experimental
```

But if you want to work on that branch, you'll need to create a local tracking branch which is done automatically by:  

```sh
$ git checkout experimental
```

and you will see  

```sh
Branch experimental set up to track remote branch experimental from origin.
Switched to a new branch 'experimental'
```

<p>That last line throws some people: "New branch" - huh?
What it really means is that the branch is taken from the index and created locally for you.  The <em>previous</em> line is actually more informative as it tells you that the branch is being set up to track the remote branch, which usually means the origin/branch_name branch </p>

Now, if you look at your local branches, this is what you'll see:  

```sh
$ git branch
* experimental
  master
```

You can actually track more than one remote repository using `git remote`.  

```sh
$ git remote add win32 git://example.com/users/joe/myproject-win32-port
$ git branch -a
* master
  remotes/origin/HEAD
  remotes/origin/master
  remotes/origin/v1.0-stable
  remotes/origin/experimental
  remotes/win32/master
  remotes/win32/new-widgets
```

At this point, things are getting pretty crazy, so run `gitk` to see what's going on:  

```sh
$ gitk --all &
```

#### Answer 2 (score 790)
If you have many remote branches that you want to fetch at once, do:  

```sh
$ git pull --all
```

Now you can checkout any branch as you need to, without hitting the remote repository.  

#### Answer 3 (score 411)
This <a href="http://en.wikipedia.org/wiki/Bash_%28Unix_shell%29">Bash</a> script helped me out:  

```sh
#!/bin/bash
for branch in $(git branch --all | grep '^\s*remotes' | egrep --invert-match '(:?HEAD|master)$'); do
    git branch --track "${branch##*/}" "$branch"
done
```

It will create tracking branches for all remote branches, except master (which you probably got from the original clone command). I think you might still need to do a   

```sh
git fetch --all
git pull --all
```

to be sure.  

<blockquote>
  <strong>One liner</strong>: `git branch -a | grep -v HEAD | perl -ne 'chomp($_); s|^\*?\s*||; if (m|(.+)/(.+)| &amp;&amp; not $d{$2}) {print qq(git branch --track $2 $1/$2\n)} else {$d{$_}=1}' | csh -xfs` As usual: test in your setup before copying rm -rf universe as we know it   
  
  <em>Credits for one-liner go to user cfi</em>  
</blockquote>

</b> </em> </i> </small> </strong> </sub> </sup>

### 43: Remove files from Git commit (score [1142383](https://stackoverflow.com/q/12481639) in 2013)

#### Question
I am using Git and I have committed few files using   

```sh
git commit -a
```

Later, I found that a file had mistakenly been added to the commit.  

How can I remove a file from the last commit?  

#### Answer accepted (score 2773)
I think other answers here are wrong, because this is a question of moving the mistakenly committed files back to the staging area from the previous commit, without cancelling the changes done to them. This can be done like Paritosh Singh suggested:  

```sh
git reset --soft HEAD^ 
```

or  

```sh
git reset --soft HEAD~1
```

Then reset the unwanted files in order to leave them out from the commit:  

```sh
git reset HEAD path/to/unwanted_file
```

Now commit again, you can even re-use the same commit message:  

```sh
git commit -c ORIG_HEAD  
```

#### Answer 2 (score 293)
<strong>ATTENTION</strong>! If you only want to remove a file from your previous commit, and <em>keep it on disk</em>, read <a href="https://stackoverflow.com/a/15321456/11343">juzzlin's answer</a> just above.  

If this is your last commit and you want to <strong>completely delete the file from your local and the remote repository</strong>, you can:   

<ol>
<li>remove the file `git rm &lt;file&gt;`</li>
<li>commit with amend flag: `git commit --amend`</li>
</ol>

The amend flag tells git to commit again, but "merge" (not in the sense of merging two branches) this commit with the last commit.  

As stated in the comments, using `git rm` here is like using the `rm` command itself!  

#### Answer 3 (score 144)
Existing answers are all talking about removing the unwanted files from the <strong><em>last</em></strong> commit.  

If you want to remove unwanted files from an <strong><em>old</em></strong> commit (even pushed) and don't want to create a new commit, which is unnecessary, because of the action:  

1.  

Find the commit that you want the file to conform to.  

```sh
git checkout <commit_id> <path_to_file>
```

you can do this multiple times if you want to remove many files.  

2.  

```sh
git commit -am "remove unwanted files"
```

3.  

Find the commit_id of the commit <strong>on which the files were added mistakenly</strong>, let's say "35c23c2" here  

```sh
git rebase 35c23c2~1 -i  // notice: "~1" is necessary
```

This command opens the editor according to your settings. The default one is vim.  

Move the  last commit, which should be "remove unwanted files", to the next line of the incorrect commit("35c23c2" in our case), and set the command as `fixup`:  

```sh
pick 35c23c2 the first commit
fixup 0d78b28 remove unwanted files
```

You should be good after saving the file.  

To finish :   

```sh
git push -f
```

If you unfortunately get conflicts, you have to solve them manually.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 44: How do I provide a username and password when running "git clone git@remote.git"? (score [1128830](https://stackoverflow.com/q/10054318) in 2019)

#### Question
I know how to provide a username and password to an HTTPS request like this:  

```sh
git clone https://username:password@remote
```

But I'd like to know how to provide a username and password to the remote like this:  

```sh
git clone git@remote.git
```

I've tried like this:  

```sh
git clone username:password@git@remote.git
git clone git@username:password@remote.git
git clone git@remote.git@username:password
```

But they haven't worked.  

#### Answer accepted (score 1115)
Use:  

```sh
git clone https://username:password@github.com/username/repository.git
```

This way worked for me from a GitHub repository.  

Based on Michael Scharf's comment:  

You can leave out the password so that it won't be logged in your Bash history file:  

```sh
git clone https://username@github.com/username/repository.git
```

It will prompt you for your password.  

#### Answer 2 (score 193)
The `user@host:path/to/repo` format tells Git to use ssh to log in to `host` with username `user`.  From <a href="http://schacon.github.com/git/git-clone.html" rel="noreferrer">`git help clone`</a>:  

<blockquote>
  An alternative scp-like syntax may also be used with the ssh protocol:  
  
  `[user@]host.xz:path/to/repo.git/`  
</blockquote>

The part before the `@` is the username, and the authentication method (password, public key, etc.) is determined by ssh, not Git.  Git has no way to pass a password to ssh, because ssh might not even use a password depending on the configuration of the remote server.  

<h5>Use `ssh-agent` to avoid typing passwords all the time</h2>

If you don't want to type your ssh password all the time, the typical solution is to <a href="http://www.openbsd.org/cgi-bin/man.cgi?query=ssh-keygen&amp;sektion=1" rel="noreferrer">generate a public/private key pair</a>, put the public key in your <a href="http://www.openbsd.org/cgi-bin/man.cgi?query=sshd&amp;sektion=8" rel="noreferrer">`~/.ssh/authorized_keys` file</a> on the remote server, and load your private key into <a href="http://www.openbsd.org/cgi-bin/man.cgi?query=ssh-agent&amp;sektion=1" rel="noreferrer">`ssh-agent`</a>.  Also see <a href="https://stackoverflow.com/q/1595848/712605">Configuring Git over SSH to login once</a>, <a href="http://help.github.com/ssh-key-passphrases/" rel="noreferrer">GitHub's help page on ssh key passphrases</a>, <a href="http://sitaramc.github.com/gitolite/gl_ssh.html" rel="noreferrer">gitolite's ssh documentation</a>, and <a href="https://devcenter.heroku.com/articles/keys" rel="noreferrer">Heroku's ssh keys documentation</a>.  

<h5>Choosing between multiple accounts at GitHub (or Heroku or...)</h2>

If you have multiple accounts at a place like GitHub or Heroku, you'll have multiple ssh keys (at least one per account).  To pick which account you want to log in as, you have to <a href="https://superuser.com/q/232373">tell ssh which private key to use</a>.  

For example, suppose you had two GitHub accounts:  `foo` and `bar`.  Your ssh key for `foo` is `~/.ssh/foo_github_id` and your ssh key for `bar` is `~/.ssh/bar_github_id`.  You want to access `git@github.com:foo/foo.git` with your `foo` account and `git@github.com:bar/bar.git` with your `bar` account.  You would add the following to your `~/.ssh/config`:  

```sh
Host gh-foo
    Hostname github.com
    User git
    IdentityFile ~/.ssh/foo_github_id
Host gh-bar
    Hostname github.com
    User git
    IdentityFile ~/.ssh/bar_github_id
```

You would then clone the two repositories as follows:  

```sh
git clone gh-foo:foo/foo.git  # logs in with account foo
git clone gh-bar:bar/bar.git  # logs in with account bar
```

<h5>Avoiding ssh altogether</h2>

Some services provide HTTP access as an alternative to ssh:  

<ul>
<li><p>GitHub:</p>

```sh
https://username:password@github.com/username/repository.git
```</li>
<li><p>Gitorious:</p>

```sh
https://username:password@gitorious.org/project/repository.git
```</li>
<li><p>Heroku:  See <a href="https://devcenter.heroku.com/articles/http-git" rel="noreferrer">this support article</a>.</p></li>
</ul>

<strong>WARNING</strong>:  Adding your password to the clone URL will cause Git to store your plaintext password in `.git/config`.  To securely store your password when using HTTP, use a credential helper.  For example:  

```sh
git config --global credential.helper cache
git config --global credential.https://github.com.username foo
git clone https://github.com/foo/repository.git
```

The above will cause Git to ask for your password once every 15 minutes (by default).  See <a href="http://git-scm.com/docs/gitcredentials" rel="noreferrer">`git help credentials`</a> for details.  

#### Answer 3 (score 28)
In the comments of @Bassetassen's <a href="https://stackoverflow.com/a/10054470/1021259">answer</a>, @plosco mentioned that you can use `git clone https://&lt;token&gt;@github.com/username/repository.git` to clone from GitHub at the very least. I thought I would expand on how to do that, in case anyone comes across this answer like I did while trying to automate some cloning.  

GitHub has a <a href="https://help.github.com/articles/git-automation-with-oauth-tokens/" rel="noreferrer">very handy</a> guide on how to do this, but it doesn't cover what to do if you want to include it all in one line for automation purposes. It warns that <strong>adding the token to the clone URL will store it in plaintext in</strong> `.git/config`. This is obviously a security risk for almost every use case, but since I plan on deleting the repo and revoking the token when I'm done, I don't care.  

<h5>1. Create a Token</h2>

GitHub has a <a href="https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/" rel="noreferrer">whole guide here</a> on how to get a token, but here's the TL;DR.   

<ol>
<li>Go to <em>Settings > Developer Settings > Personal Access Tokens</em> (<a href="https://github.com/settings/tokens" rel="noreferrer">here's a direct link</a>)</li>
<li>Click "Generate a New Token" and enter your password again. (h<a href="https://github.com/settings/tokens/new" rel="noreferrer">ere's another direct link</a>)</li>
<li>Set a description/name for it, check the "repo" permission and hit the "Generate token" button at the bottom of the page.</li>
<li>Copy your new token <strong>before you leave the page</strong></li>
</ol>

<h5>2. Clone the Repo</h2>

Same as the command @plosco gave, `git clone https://&lt;token&gt;@github.com/&lt;username&gt;/&lt;repository&gt;.git`, just replace `&lt;token&gt;`, `&lt;username&gt;` and `&lt;repository&gt;` with whatever your info is.   

If you want to clone it to a specific folder, just insert the folder address at the end like so: `git clone https://&lt;token&gt;@github.com/&lt;username&gt;/&lt;repository.git&gt; &lt;folder&gt;`, where `&lt;folder&gt;` is, you guessed it, the folder to clone it to! You can of course use `.`, `..`, `~`, etc. here like you can elsewhere.  

<h5>3. Leave No Trace</h2>

Not all of this may be necessary, depending on how sensitive what you're doing is.  

<ul>
<li>You probably don't want to leave that token hanging around if you have no intentions of using it for some time, so go back to the <a href="https://github.com/settings/tokens" rel="noreferrer">tokens page</a> and hit the delete button next to it.</li>
<li>If you don't need the repo again, delete it `rm -rf &lt;folder&gt;`.</li>
<li>If do need the repo again, but don't need to automate it again, you can remove the remote by doing `git remote remove origin` or just remove the token by running `git remote set-url origin https://github.com/&lt;username&gt;/&lt;repository.git&gt;`.</li>
<li>Clear your bash history to make sure the token doesn't stay logged there. There are many ways to do this, see <a href="https://askubuntu.com/q/903362/487048">this question</a> and <a href="https://stackoverflow.com/q/14750650/1021259">this question</a>. However, it may be easier to just prepend all the above commands with a space in order to prevent them being stored to begin with.</li>
</ul>

Note that I'm no pro, so the above may not be secure in the sense that no trace would be left for any sort of forensic work.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 45: How to remove a directory from git repository? (score [1101791](https://stackoverflow.com/q/6313126) in 2016)

#### Question
I have 2 directories on my GitHub repository. I'd like to delete one of them. How could I do that without deleting and re-creating entire repository?  

#### Answer accepted (score 2100)
<h5>Remove directory from git and local</h1>

You could checkout 'master' with both directories;   

```sh
git rm -r one-of-the-directories
git commit -m "Remove duplicated directory"
git push origin <your-git-branch> (typically 'master', but not always)
```

<h5>Remove directory from git but NOT local</h1>

As mentioned in the comments, what you usually want to do is remove this directory from git but not delete it entirely from the filesystem (local)  

In that case use:    

```sh
git rm -r --cached myFolder
```

#### Answer 2 (score 257)
<h5>To remove folder/directory only from git repository and not from the local try 3 simple commands.</h3>

<hr>

<strong>Steps to remove directory</strong>  

```sh
git rm -r --cached FolderName
git commit -m "Removed folder from repository"
git push origin master
```

<hr>

<strong>Steps to ignore that folder in next commits</strong>  

<blockquote>
  <p>To ignore that folder from next commits make one file in root named <strong>.gitignore</strong>
  and put that folders name into it. You can put as many as you want</p>
</blockquote>

<strong>.gitignore</strong> file will be look like this  

```sh
/FolderName
```

<hr>

<img src="https://i.stack.imgur.com/mJYfF.png" alt="remove directory">  

#### Answer 3 (score 71)
<p>If, for some reason, what karmakaze said doesn't work, you could try deleting the directory you want using or with your file system browser (ex. In Windows File Explorer). After deleting the directory, issuing the command: <br>
`git add -A` <br>
and then <br>
`git commit -m 'deleting directory'` <br>
and then <br>
`git push origin master`.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 46: How to make Git "forget" about a file that was tracked but is now in .gitignore? (score [1080222](https://stackoverflow.com/q/1274057) in 2017)

#### Question
There is a file that was being tracked by `git`, but now the file is on the `.gitignore` list.  

However, that file keeps showing up in `git status` after it's edited. How do you force `git` to completely forget about it?  

#### Answer accepted (score 5017)
`.gitignore` will prevent untracked files from being added (without an `add -f`) to the set of files tracked by git, however git will continue to track any files that are already being tracked.  

To stop tracking a file you need to remove it from the index. This can be achieved with this command.  

```sh
git rm --cached <file>
```

If you want to remove a whole folder, you need to remove all files in it recursively.  

```sh
git rm -r --cached <folder>
```

The removal of the file from the head revision will happen on the next commit.  

<strong>WARNING: While this will not remove the physical file from your local, it will remove the files from other developers machines on next `git pull`.</strong>  

#### Answer 2 (score 2450)
The series of commands below will remove all of the items from the Git Index (not from the working directory or local repo), and then updates the Git Index, while respecting git ignores. <em>PS. Index = Cache</em>  

<strong>First:</strong>  

```sh
git rm -r --cached . 
git add .
```

<strong>Then:</strong>  

```sh
git commit -am "Remove ignored files"
```

#### Answer 3 (score 994)
<strong>git update-index</strong> does the job for me:  

```sh
git update-index --assume-unchanged <file>
```

<strong>Note:</strong> This solution is actually independent on `.gitignore` as gitignore is only for untracked files.  

<strong>edit:</strong> Since this answer was posted, a new option has been created and that should be prefered.  You should use <strong>`--skip-worktree`</strong> which is for modified tracked files that the user don't want to commit anymore and keep `--assume-unchanged` for performance to prevent git to check status of big tracked files. See <a href="https://stackoverflow.com/a/13631525/717372">https://stackoverflow.com/a/13631525/717372</a> for more details...   

```sh
git update-index --skip-worktree <file>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 47: Git pull a certain branch from GitHub (score [1066120](https://stackoverflow.com/q/1709177) in 2018)

#### Question
I have a project with multiple branches. I've been pushing them to <a href="http://en.wikipedia.org/wiki/GitHub" rel="noreferrer">GitHub</a>, and now that someone else is working on the project I need to pull their branches from GitHub. It works fine in master. But say that someone created a branch `xyz`. How can I pull branch `xyz` from GitHub and merge it into branch `xyz` on my `localhost`?  

<p>I actually have my answer here:
<em><a href="https://stackoverflow.com/questions/1072261/push-and-pull-branches-in-git">Push and pull branches in Git</a></em></p>

But I get an error "! [rejected]" and something about "non fast forward".  

Any suggestions?  

#### Answer accepted (score 664)
<blockquote>
  But I get an error "! [rejected]" and something about "non fast forward"  
</blockquote>

That's because Git can't merge the changes from the branches into your current master. Let's say you've checked out branch `master`, and you want to merge in the remote branch `other-branch`. When you do this:  

```sh
$ git pull origin other-branch
```

Git is basically doing this:  

```sh
$ git fetch origin other-branch && git merge other-branch
```

That is, a `pull` is just a `fetch` followed by a `merge`. However, when `pull`-ing, Git will <em>only</em> merge `other-branch` <em>if</em> it can perform a <em>fast-forward</em> merge. A <em>fast-forward</em> merge is a merge in which the head of the branch you are trying to merge into is a <em>direct descendent</em> of the head of the branch you want to merge. For example, if you have this history tree, then merging `other-branch` would result in a fast-forward merge:  

```sh
O-O-O-O-O-O
^         ^
master    other-branch
```

However, this would <em>not</em> be a fast-forward merge:  

```sh
    v master
O-O-O
\
 \-O-O-O-O
         ^ other-branch
```

To solve your problem, first <em>fetch</em> the remote branch:  

```sh
$ git fetch origin other-branch
```

Then merge it into your current branch (I'll assume that's `master`), and fix any merge conflicts:  

```sh
$ git merge origin/other-branch
# Fix merge conflicts, if they occur
# Add merge conflict fixes
$ git commit    # And commit the merge!
```

#### Answer 2 (score 290)
Simply track your remote branches explicitly and a simple `git pull` will do just what you want:  

```sh
git branch -f remote_branch_name origin/remote_branch_name
git checkout remote_branch_name
```

The latter is a local operation.  

Or even more fitting in with the <a href="https://help.github.com/articles/fork-a-repo" rel="noreferrer">GitHub documentation on forking</a>:  

```sh
git branch -f new_local_branch_name upstream/remote_branch_name
```

#### Answer 3 (score 112)
You could pull a branch to a branch with the following commands.  

```sh
git pull {repo} {remotebranchname}:{localbranchname}

git pull origin xyz:xyz
```

When you are on the master branch you also could first checkout a branch like:  

```sh
git checkout -b xyz
```

This creates a new branch, "xyz", from the master and directly checks it out.  

Then you do:  

```sh
git pull origin xyz
```

This pulls the new branch to your local `xyz` branch.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 48: How to fully delete a git repository created with init? (score [1051497](https://stackoverflow.com/q/1213430) in 2016)

#### Question
I created a git repository with `git init`. I'd like to delete it entirely and init a new one.  

#### Answer accepted (score 1768)
Git keeps all of its files in the `.git` directory. Just remove that one and init again.  

If you can't find it, it's because it is hidden.  

<ul>
<li><p>In Windows 7, you need to go to your folder, click on <kbd>Organize</kbd> on the top left, then click on <kbd>Folder and search options</kbd>, then click on the <kbd>View</kbd> tab and click on the <kbd>Show hidden files, folders and drives</kbd> radio button.</p></li>
<li><p>On a Mac OS:</p>

<ul>
<li><p>Open a Terminal (via Spotlight: press <kbd>CMD</kbd> + <kbd>SPACE</kbd>, type `terminal` and press <kbd>Enter</kbd>) and run:</p>

```sh
defaults write com.apple.finder AppleShowAllFiles 1 && killall Finder
```

<p>Note: The keyboard shortcut to show hidden files in Finder is 
<kbd>CMD</kbd> + <kbd>SHIFT</kbd> + <kbd>.</kbd> so it is no longer necessary to modify the 
finder config this way</p></li>
<li><p>You could also type `cd` (the space is important), drag and drop your git repo folder from Finder to the terminal window, press <kbd>return</kbd>, then type `rm -fr .git`, then <kbd>return</kbd> again.</p></li>
</ul></li>
<li><p>On Ubuntu, use shortcut <kbd>Ctrl + H</kbd>.</p></li>
</ul>

#### Answer 2 (score 703)
If you really want to remove all of the repository, leaving only the working directory then it should be as simple as this.  

```sh
rm -rf .git
```

The usual provisos about `rm -rf` apply. Make sure you have an up to date backup and are absolutely sure that you're in the right place before running the command. etc., etc.  

#### Answer 3 (score 59)
If you want to delete all .git folders in a project use the following command:  

```sh
find . -type f | grep -i "\.git" | xargs rm
```

This will also delete all the .git folders and .gitignore files from all subfolders  

</b> </em> </i> </small> </strong> </sub> </sup>

### 49: Git merge master into feature branch (score [1045383](https://stackoverflow.com/q/16955980) in 2019)

#### Question
Lets say we have the following situation in git:  

<ol>
<li><p>A created repository:</p>

```sh
mkdir GitTest2
cd GitTest2
git init
```</li>
<li><p>Some modifications in the master take place and get committed.</p>

```sh
echo "On Master" > file
git commit -a -m "Initial commit"
```</li>
<li><p>Feature1 branched off master and some work is done:</p>

```sh
git branch feature1
git checkout feature1
echo "Feature1" > featureFile
git commit -a -m "Commit for feature1"
```</li>
<li><p>Meanwhile, a bug is discovered in the master-code and a hotfix-branch is established</p>

```sh
git checkout master
git branch hotfix1
git checkout hotfix1
```</li>
<li><p>The bug is fixed in the hotfix branch and merged back into the master (perhaps after a pull request/code review):</p>

```sh
echo "Bugfix" > bugfixFile
git commit -a -m "Bugfix Commit"
git checkout master
git merge --no-ff hotfix1
```</li>
<li><p>Development on feature1 continues:</p>

```sh
git checkout feature1
```</li>
</ol>

Now my question: Say I need the hotfix in my feature branch, maybe because the bug also occurs there. How can I achieve this without duplicating the commits into my feature branch? I want to prevent to get two new commits on my feature branch which have no relation to the feature implementation. This especially seems important for me if I use Pull Requests: All these commits will also be included in the Pull Request and have to be reviewed although this has already been done (as the hotfix is already in the master).  

I can not do a `git merge master --ff-only`: "fatal: Not possible to fast-forward, aborting.", but I am not sure if this helped me.     

#### Answer accepted (score 530)
You should be able to rebase your branch on master:  

```sh
git checkout feature1
git rebase master
```

Manage all conflicts that arise. When you get to the commits with the bugfixes (already in master), git will say that there were no changes and that maybe they were already applied. You then continue the rebase (while skipping the commits already in master) with  

```sh
git rebase --skip
```

If you perform a `git log` on your feature branch, you'll see the bugfix commit appear only once, and in the master portion.  

For a more detailed discussion, take a look at the Git book docs on `git rebase` (<a href="https://git-scm.com/docs/git-rebase" rel="noreferrer">https://git-scm.com/docs/git-rebase</a>) which cover this exact use case.  

================ Edit for additional context ====================  

This answer was provided specifically for the question asked by @theomega, taking his particular situation into account. Note this part:  

<blockquote>
  I want to prevent [...] commits on my feature branch which have no relation to the feature implementation.  
</blockquote>

Rebasing his private branch on master is exactly what will yield that result. In contrast, merging master into his branch would precisely do what he <strong><em>specifically does not want to happen</em></strong>: adding a commit that is not related to the feature implementation he is working on via his branch.  

To address the users that read the question title, skip over the actual content and context of the question, and then only read the top answer blindly assuming it will always apply to their (different) use case, allow me to elaborate:  

<ul>
<li>only rebase private branches (i.e. that only exist in your local repo and haven't been shared with others). Rebasing shared branches would "break" the copies other people may have.</li>
<li>if you want to integrate changes from a branch (whether it's master or another branch) into a branch that is public (e.g. you've pushed the branch to open a pull request, but there are now conflicts with master and you need to update your branch to resolve those conflicts) you'll need to merge them in (e.g. with `git merge master` as in @Sven's answer).</li>
<li>you can also merge branches into your local private branches if that's your preference, but be aware that it will result in "foreign" commits in your branch.</li>
</ul>

Finally, if you're unhappy with the fact that this answer is not the best fit for your situation even though it was for @theomega, adding a comment below won't be particularly helpful: I don't control which answer is selected, only @theomega does.  

#### Answer 2 (score 1032)
How to merge the master branch into the feature branch? Easy:  

```sh
git checkout feature1
git merge master
```

There is no point in forcing a fast forward merge here, as it cannot be done. You committed both into the feature branch and the master branch. Fast forward is impossible now.  

Have a look at <a href="https://github.com/nvie/gitflow" rel="noreferrer">gitflow</a>. It is a branching model for git that can be followed, and you unconsciously already did. It also is an extension to git which adds some commands for the new workflow steps that do things automatically which you would otherwise need to do manually.  

So what did you do right in your workflow? You have two branches to work with, your feature1 branch is basically the "develop" branch in the gitflow model.  

You created a hotfix branch from master and merged it back. And now you are stuck.  

The gitflow model asks you to merge the hotfix also to the devel branch, which is "feature1" in your case.  

So the real answer would be:  

```sh
git checkout feature1
git merge --no-ff hotfix1
```

This adds all the changes that were made inside the hotfix to the feature branch, but ONLY those changes. They might conflict with other development changes in the branch, but they will not conflict with the master branch should you merge the feature branch back to master eventually.  

Be very careful with rebasing. Only rebase if the changes you did stayed local to your repository, e.g. you did not push any branches to some other repository. Rebasing is a great tool for you to arrange your local commits into a useful order before pushing it out into the world, but rebasing afterwards will mess up things for the git beginners like you.  

#### Answer 3 (score 63)
Basing on <a href="http://goodcode.io/blog/git-merge-rebase/" rel="nofollow noreferrer">this article</a> you should:  

<ul>
<li><p>create new branch which is based upon new version of master</p>

`git branch -b newmaster`  </li>
<li><p>merge your old feature branch into new one</p>

`git checkout newmaster`  </li>
<li><p>resolve conflict on new feature branch</p></li>
</ul>

The first two commands can be combined to `git checkout -b newmaster`  

<p>This way your history stays clear because you don't need back merges.
And you don't need to be so super cautious since you don't need git rebase</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 50: How to delete a remote tag? (score [1035939](https://stackoverflow.com/q/5480258) in 2018)

#### Question
How do you delete a Git tag that has already been pushed?  

#### Answer accepted (score 5046)
You just need to push an 'empty' reference to the remote tag name:  

```sh
git push origin :tagname
```

Or, more expressively, use the `--delete` option (or `-d` if your git version is older than 1.8.0):  

```sh
git push --delete origin tagname
```

Note that git has tag namespace and branch namespace so you may use the same name for a branch and for a tag. If you want to make sure that you cannot accidentally remove the branch instead of the tag, you can specify full ref which will never delete a branch:  

```sh
git push origin :refs/tags/tagname
```

If you also need to delete the local tag, use:  

```sh
git tag --delete tagname
```

<hr>

<h5>Background</h3>

Pushing a branch, tag, or other ref to a remote repository involves specifying "which repo, what source, what destination?"  

```sh
git push remote-repo source-ref:destination-ref
```

A real world example where you push your master branch to the origin's master branch is:  

```sh
git push origin refs/heads/master:refs/heads/master
```

Which because of default paths, can be shortened to:  

```sh
git push origin master:master
```

Tags work the same way:  

```sh
git push origin refs/tags/release-1.0:refs/tags/release-1.0
```

Which can also be shortened to:  

```sh
git push origin release-1.0:release-1.0
```

By omitting the source ref (the part before the colon), you push 'nothing' to the destination, deleting the ref on the remote end.  

#### Answer 2 (score 339)
A more straightforward way is   

```sh
git push --delete origin YOUR_TAG_NAME
```

IMO prefixing colon syntax is a little bit odd in this situation  

#### Answer 3 (score 195)
If you have a remote tag `v0.1.0` to delete, and your remote is `origin`, then simply:  

```sh
git push origin :refs/tags/v0.1.0
```

If you also need to delete the tag locally:  

```sh
git tag -d v0.1.0
```

See <a href="https://stackoverflow.com/a/5480292/535871"><strong>Adam Franco</strong>'s answer</a> for an explanation of Git's unusual `:` syntax for deletion.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 51: .gitignore and "The following untracked working tree files would be overwritten by checkout" (score [1011972](https://stackoverflow.com/q/4858047) in 2019)

#### Question
So I added a folder to my .gitignore file.  

Once I do a `git status` it tells me  

```sh
# On branch latest
nothing to commit (working directory clean)
```

However, when I try to change branches I get the following:  

```sh
My-MacBook-Pro:webapp marcamillion$ git checkout develop
error: The following untracked working tree files would be overwritten by checkout:
    public/system/images/9/thumb/red-stripe.jpg
    public/system/images/9/original/red-stripe.jpg
    public/system/images/8/thumb/red-stripe-red.jpg
    public/system/images/8/original/red-stripe-red.jpg
    public/system/images/8/original/00-louis_c.k.-chewed_up-cover-2008.jpg
    public/system/images/7/thumb/red-stripe-dark.jpg
    public/system/images/7/original/red-stripe-dark.jpg
    public/system/images/7/original/DSC07833.JPG
    public/system/images/6/thumb/red-stripe-bw.jpg
    public/system/images/6/original/website-logo.png
    public/system/images/6/original/red-stripe-bw.jpg
    public/system/images/5/thumb/Guy_Waving_Jamaican_Flag.jpg
    public/system/images/5/original/logocompv-colored-squares-100px.png
    public/system/images/5/original/Guy_Waving_Jamaican_Flag.jpg
    public/system/images/4/thumb/DSC_0001.JPG
    public/system/images/4/original/logo.png
    public/system/images/4/original/DSC_0001.JPG
    public/system/images/4/original/2-up.jpg
    public/system/images/3/thumb/logo2.gif
    public/system/images/3/original/logo2.gif
    public/system/images/3/original/Guy_Waving_Jamaican_Flag.jpg
    public/system/images/3/original/11002000962.jpg
    public/system/images/2/thumb/Profile Pic.jpg
    public/system/images/2/original/Profile Pic.jpg
    public/system/images/2/original/02 Login Screen.jpg
    public/system/images/1/original/Argentina-2010-World-Cup.jpg
Please move or remove them before you can switch branches.
Aborting
```

This is what my .gitignore file looks like:  

```sh
.bundle
.DS_Store
db/*.sqlite3
log/*.log
tmp/**/*
public/system/images/*
public/system/avatars/*
```

How do I get this working so I can switch branches without deleting those files?  

If I make a change, will it affect those files? In other words, if I came back to this branch afterwards would everything be perfect as up to my latest commit?  

I don't want to lose those files, I just don't want them tracked.  

#### Answer accepted (score 254)
It seems like you want the files ignored but they have already been commited. .gitignore has no effect on files that are already in the repo so they need to be removed with `git rm --cached`. The `--cached` will prevent it from having any effect on your working copy and it will just mark as removed the next time you commit. After the files are removed from the repo then the .gitignore will prevent them from being added again.  

But you have another problem with your .gitignore, you are excessively using wildcards and its causing it to match less than you expect it to. Instead lets change the .gitignore and try this.  

```sh
.bundle
.DS_Store
db/*.sqlite3
log/*.log
tmp/
public/system/images/
public/system/avatars/
```

#### Answer 2 (score 986)
<h5><strong>WARNING: it will delete untracked files, so it's not a great answer to the question being posed.</strong></h1>

I hit this message as well. In my case, I didn't want to keep the files, so this worked for me:  

<h5>git 2.11 and newer</h3>

```sh
git clean  -d  -f .
```

<h5>older git</h3>

```sh
git clean  -d  -f ""
```

If you also want to remove files ignored by git, then execute the following command.   

<h5>BE WARNED!!! THIS MOST PROBABLY DESTROYS YOUR PROJECT, USE ONLY IF YOU KNOW 100% WHAT YOU ARE DOING</h2>

<h5>git 2.11 and newer</h3>

```sh
git clean  -d  -fx .
```

<h5>older git</h3>

```sh
git clean  -d  -fx ""
```

<a href="http://www.kernel.org/pub/software/scm/git/docs/git-clean.html" rel="noreferrer">http://www.kernel.org/pub/software/scm/git/docs/git-clean.html</a>  

<ul>
<li><p>`-x` means ignored files are also removed as well as files unknown to git.</p></li>
<li><p>`-d` means remove untracked directories in addition to untracked files. </p></li>
<li><p>`-f` is required to force it to run.</p></li>
</ul>

#### Answer 3 (score 559)
<blockquote>
  <strong>Warning: This will delete the local files that are not indexed</strong>  
</blockquote>

Just force it : `git checkout -f another-branch`  

</b> </em> </i> </small> </strong> </sub> </sup>

### 52: How to create a .gitignore file (score [990996](https://stackoverflow.com/q/10744305) in 2019)

#### Question
I need to add some rules to my `.gitignore` file. However, I can't find it in my project folder. Isn't it created automatically by Xcode? If not, what command allows me to create one?  

#### Answer 2 (score 1587)
If you're using Windows it will not let you create a file without a filename in Windows Explorer. It will give you the error "<em>You must type a file name</em>" if you try to rename a text file as <strong>.gitignore</strong>  

<img src="https://i.imgur.com/W0J6Ort.png" alt="enter image description here">  

To get around this I used the following steps  

<ol>
<li>Create the text file gitignore.txt</li>
<li>Open it in a text editor and add your rules, then save and close</li>
<li>Hold SHIFT, right click the folder you're in, then select <strong>Open command window here</strong></li>
<li>Then rename the file in the command line, with `ren gitignore.txt .gitignore`</li>
</ol>

Alternatively <a href="https://stackoverflow.com/users/1526257/henningcash">@HenningCash</a> suggests in the comments  

<blockquote>
  <p>You can get around this Windows Explorer error by appending a dot to
  the filename without extension: .gitignore. will be automatically
  changed to .gitignore</p>
</blockquote>

#### Answer 3 (score 455)
As simple as things can (sometimes) be: Just add the following into your preferred command line interface (GNU Bash, Git Bash, etc.)  

```sh
touch .gitignore
```

As @Wardy pointed out in the comments, `touch` works on Windows as well as long as you provide the full path. This might also explain why it does not work for some users on <em>Windows</em>: The `touch` command seems to not be in the `$PATH` on some Windows versions per default.  

```sh
C:\> "c:\program files (x86)\git\bin\touch.exe" .gitignore
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 53: Why are there two ways to unstage a file in Git? (score [986301](https://stackoverflow.com/q/6919121) in 2019)

#### Question
Sometimes git suggests `git rm --cached` to unstage a file, sometimes `git reset HEAD file`. When should I use which?  

EDIT:  

```sh
D:\code\gt2>git init
Initialized empty Git repository in D:/code/gt2/.git/
D:\code\gt2>touch a

D:\code\gt2>git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       a
nothing added to commit but untracked files present (use "git add" to track)

D:\code\gt2>git add a

D:\code\gt2>git status
# On branch master
#
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached <file>..." to unstage)
#
#       new file:   a
#
D:\code\gt2>git commit -m a
[master (root-commit) c271e05] a
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 a

D:\code\gt2>touch b

D:\code\gt2>git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       b
nothing added to commit but untracked files present (use "git add" to track)

D:\code\gt2>git add b

D:\code\gt2>git status
# On branch master
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       new file:   b
#
```

#### Answer accepted (score 1766)
`git rm --cached &lt;filePath&gt;` <strong>does not unstage</strong> a file, it actually <strong>stages the removal of the file(s)</strong> from the repo (assuming it was already committed before) but leaves the file in your working tree (leaving you with an untracked file).  

`git reset -- &lt;filePath&gt;` will <strong>unstage</strong> any staged changes for the given file(s).  

That said, if you used `git rm --cached` on a new file that is staged, it would basically look like you had just unstaged it since it had never been committed before.  

#### Answer 2 (score 326)
`git rm --cached` is used to remove a file from the index. In the case where the file is already in the repo, `git rm --cached` will remove the file from the index, leaving it in the working directory and a commit will now remove it from the repo as well. Basically, after the commit, you would have unversioned the file and kept a local copy.  

`git reset HEAD file` ( which by default is using the `--mixed` flag) is different in that in the case where the file is already in the repo, it replaces the index version of the file with the one from repo (HEAD), effectively unstaging the <strong>modifications</strong> to it.  

In the case of unversioned file, it is going to unstage the entire file as the file was not there in the HEAD. In this aspect `git reset HEAD file` and `git rm --cached` are same, but they are not same ( as explained in the case of files already in the repo)  

To the question of `Why are there 2 ways to unstage a file in git?` - there is never really only one way to do anything in git. that is the beauty of it :)  

#### Answer 3 (score 119)
Quite simply:   

<ul>
<li>`git rm --cached &lt;file&gt;` <strong>makes git stop tracking the file completely</strong> (leaving it in the filesystem, unlike plain `git rm`*)</li>
<li>`git reset HEAD &lt;file&gt;` <strong>unstages any modifications made to the file since the last commit</strong> (but doesn't revert them in the filesystem, contrary to what the command name might suggest**). The file remains under revision control.</li>
</ul>

If the file wasn't in revision control before (i.e. you're unstaging a file that you had just `git add`ed for the first time), then the two commands have the same effect, hence the appearance of these being "two ways of doing something".  

<sub>* Keep in mind the caveat @DrewT mentions in his answer, regarding `git rm --cached` of a file that was <em>previously committed</em> to the repository. In the context of this question, of a file just added and not committed yet, there's nothing to worry about.</sub>  

<sub>** I was scared for an embarrassingly long time to use the git reset command because of its name -- and still today I often look up the syntax to make sure I don't screw up. (<strong>update</strong>: I finally took the time to <a href="https://github.com/tldr-pages/tldr/blob/master/pages/common/git-reset.md" rel="noreferrer">summarize the usage of `git reset` in a tldr page</a>, so now I have a better mental model of how it works, and a quick reference for when I forget some detail.)</sub>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 54: How do you push a tag to a remote repository using Git? (score [983045](https://stackoverflow.com/q/5195859) in 2018)

#### Question
I have cloned a remote Git repository to my laptop, then I wanted to add a tag so I ran  

```sh
git tag mytag master
```

When I run `git tag` on my laptop the tag `mytag` is shown. I then want to push this to the remote repository so I have this tag on all my clients, so I run `git push` but I got the message:  

<blockquote>
  Everything up-to-date  
</blockquote>

And if I go to my desktop and run `git pull` and then `git tag` no tags are shown.   

I have also tried to do a minor change on a file in the project, then push it to the server. After that I could pull the change from the server to my Desktop computer, but there's still no tag when running `git tag` on my desktop computer.  

How can I push my tag to the remote repository so that all client computers can see it?  

#### Answer accepted (score 914)
<strong>`git push --follow-tags`</strong>  

This is a sane option introduced in Git 1.8.3:  

```sh
git push --follow-tags
```

It pushes both commits and only tags that are both:  

<ul>
<li>annotated</li>
<li>reachable (an ancestor) from the pushed commits</li>
</ul>

This is sane because:  

<ul>
<li>you should only push annotated tags to the remote, and keep lightweight tags for local development to avoid tag clashes. See also: <a href="https://stackoverflow.com/questions/11514075">What is the difference between an annotated and unannotated tag?</a></li>
<li>it won't push annotated tags on unrelated branches</li>
</ul>

It is for those reasons that `--tags` should be avoided.  

Git 2.4 <a href="https://github.com/git/git/commit/61ca378275e83c48343c74a849ff0dcdef9abc91" rel="noreferrer">has added</a> the `push.followTags` option to turn that flag on by default which you can set with:  

```sh
git config --global push.followTags true
```

#### Answer 2 (score 3406)
To push a <strong>single</strong> tag:  

```sh
git push origin <tag_name>
```

And the following command should push <strong>all</strong> tags (<strong>not recommended</strong>):  

```sh
git push --tags
```

#### Answer 3 (score 251)
<p>To push specific, one tag do following
`git push origin tag_name`</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 55: Getting git to work with a proxy server (score [982415](https://stackoverflow.com/q/783811) in 2017)

#### Question
How do I get git to use a proxy server?  

I need to check out code from a git server, it shows "Request timed out" every time. How do I get around this?   

Alternatively, how can I set a proxy server?  

#### Answer accepted (score 1575)
Command to use:  

```sh
git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080
```

<ul>
<li>change `proxyuser` to your proxy user</li>
<li>change `proxypwd` to your proxy password</li>
<li>change `proxy.server.com` to the URL of your proxy server</li>
<li>change `8080` to the proxy port configured on your proxy server</li>
</ul>

If you decide at any time to reset this proxy and work without proxy:  

Command to use:  

```sh
git config --global --unset http.proxy
```

Finally, to check the currently set proxy:  

```sh
git config --global --get http.proxy
```

#### Answer 2 (score 129)
This worked for me, in windows XP behind a corporate firewall.  

I didnt have to install any local proxy or any other software besides git v1.771  from <a href="http://code.google.com/p/msysgit/downloads/list?can=3" rel="noreferrer">http://code.google.com/p/msysgit/downloads/list?can=3</a>  

```sh
$ git config --global http.proxy http://proxyuser:proxypwd@proxy.server.com:8080
$ git config --system http.sslcainfo /bin/curl-ca-bundle.crt
$ git remote add origin https://mygithubuser:mygithubpwd@github.com/repoUser/repoName.git
$ git push origin master
```

<strong>proxyuser</strong>= the proxy user I was assigned by our IT dept, in my case it is the same windows user I use to log in to my PC, the Active Directory user  

<strong>proxypwd</strong>= the password of my proxy user  

<strong>proxy.server.com:8080</strong> = the proxy name and port, I got it from Control Panel, Internet Options, Connections, Lan Settings button, Advanced button inside the Proxy Server section, use the servername and port on the first (http) row.  

<strong>mygithubuser</strong> = the user I use to log in to github.com  

<strong>mygithubpwd</strong> = the password for my github.com user  

<strong>repoUser</strong> = the user owner of the repo  

<strong>repoName</strong> = the name of the repo  

#### Answer 3 (score 51)
<p>Set a system variable named `http_proxy` with the value of `ProxyServer:Port`.
That is the simplest solution. Respectively, use `https_proxy` as daefu pointed out in the comments.</p>

Setting gitproxy (as sleske mentions) is another option, but that requires a "command", which is not as straightforward as the above solution.  

<p>References:
<a href="http://bardofschool.blogspot.com/2008/11/use-git-behind-proxy.html" rel="noreferrer">http://bardofschool.blogspot.com/2008/11/use-git-behind-proxy.html</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 56: What does cherry-picking a commit with Git mean? (score [962343](https://stackoverflow.com/q/9339429) in 2019)

#### Question
Recently, I have been asked to `cherry-pick` a commit.   

<strong><em>So what does cherry-picking a commit in git mean? How do you do it?</em></strong>   

#### Answer accepted (score 2493)
Cherry picking in Git means to choose a commit from one branch and apply it onto another.   

This is in contrast with other ways such as `merge` and `rebase` which normally apply many commits onto another branch.  

<ol>
<li><p>Make sure you are on the branch you want to apply the commit to.</p>

```sh
git checkout master
```</li>
<li><p>Execute the following:</p>

```sh
git cherry-pick <commit-hash>
```</li>
</ol>

N.B.:  

<ol>
<li><p>If you cherry-pick from a public branch, you should consider using </p>

```sh
git cherry-pick -x <commit-hash>
```

This will generate a standardized commit message. This way, you (and your co-workers) can still keep track of the origin of the commit and may avoid merge conflicts in the future.  </li>
<li><p>If you have notes attached to the commit they do not follow the cherry-pick. To bring them over as well, You have to use:</p>

```sh
git notes copy <from> <to>
```</li>
</ol>

Additional links:  

<ul>
<li><a href="http://git-scm.com/docs/git-cherry-pick" rel="noreferrer">git official guide page</a></li>
</ul>

#### Answer 2 (score 279)
<p>This quote is taken from;
<a href="https://rads.stackoverflow.com/amzn/click/com/1449316387" rel="noreferrer" rel="nofollow noreferrer">Version Control with Git</a>
(Really great book, I encourage you to buy it if you are interested in git)</p>

Edit: Since this answer is still getting impression, I would like to add very nice in action video tutorial about it:  

<a href="https://www.youtube.com/watch?v=-ndmel-4wsk" rel="noreferrer">Youtube: Introduction to Git cherry-pick</a>  

<blockquote>
  <p>Using git cherry-pick The command  git cherry-pick commit applies the
  changes introduced by the named commit on the current branch. It will
  introduce a new, distinct commit. <strong>Strictly speaking, using  git
  cherry-pick doesn’t alter the existing history within a repository;
  instead, it adds to the history. As with other Git operations that
  introduce changes via the process of applying a diff, you may need to
  resolve conflicts to fully apply the changes from the given  commit</strong> .
  The command  git cherry-pick is typically used to introduce particular
  commits from one branch within a repository onto a different branch. A
  common use is to forward- or back-port commits from a maintenance
  branch to a development branch. </p>
</blockquote>

```sh
$ git checkout rel_2.3
$ git cherry-pick dev~2 # commit F, above
```

<p>before:
<img src="https://i.stack.imgur.com/R4nfN.png" alt="before"></p>

<p>after:
<img src="https://i.stack.imgur.com/23fCh.png" alt="after"></p>

#### Answer 3 (score 147)
Cherry picking in Git is designed to apply some commit from one branch into another branch. It can be done if you eg. made a mistake and committed a change into wrong branch, but do not want to merge the whole branch. You can just eg. revert the commit and cherry-pick it on another branch.  

To use it, you just need `git cherry-pick hash`, where `hash` is a commit hash from other branch.  

For full procedure see: <a href="http://technosophos.com/2009/12/04/git-cherry-picking-move-small-code-patches-across-branches.html">http://technosophos.com/2009/12/04/git-cherry-picking-move-small-code-patches-across-branches.html</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 57: Create a branch in Git from another branch (score [946581](https://stackoverflow.com/q/4470523) in 2017)

#### Question
I have two branches: <strong>master</strong> and <strong>dev</strong>  

I want to create a "feature branch" from the <strong>dev</strong> branch.  

Currently on the branch dev, I do:  

```sh
$ git checkout -b myfeature dev
```

... (some work)  

```sh
$ git commit -am "blablabla"
$ git push origin myfeature
```

But, after visualizing my branches, I got:  

```sh
--**master**
------0-----0-----0-----0-----0
------------------------**dev**----**myfeature**
```

I mean that the branch seems ff merged, and I don't understand why...  

What I'm doing wrong?  

Can you explain me please how you branch off from another branch and push back to the remote repository for the feature branch?  

All that in a branching model like <a href="http://nvie.com/posts/a-successful-git-branching-model/" rel="noreferrer">the one described here</a>.  

#### Answer accepted (score 1193)
If you like the method in the link you've posted, have a look at <a href="https://github.com/nvie/gitflow" rel="noreferrer">Git Flow</a>.  

It's a set of scripts he created for that workflow.  

But to answer your question:  

```sh
$ git checkout -b myFeature dev
```

Creates MyFeature branch off dev. Do your work and then  

```sh
$ git commit -am "Your message"
```

Now merge your changes to dev without a fast-forward  

```sh
$ git checkout dev
$ git merge --no-ff myFeature
```

Now push changes to the server  

```sh
$ git push origin dev
$ git push origin myFeature
```

And you'll see it how you want it.  

#### Answer 2 (score 332)
If you want create a new branch from any of the existing branches in Git, just follow the options.  

First change/checkout into the branch from where you want to create a new branch. For example, if you have the following branches like:  

<ul>
<li><strong>master</strong></li>
<li><strong>dev</strong></li>
<li><strong>branch1</strong></li>
</ul>

So if you want to create a new branch called <strong><em>"subbranch_of_b1"</em></strong> under the branch named <strong><em>"branch1"</em></strong> follow the steps:  

<ol>
<li><p>Checkout or change into <strong>"branch1"</strong></p>

```sh
git checkout branch1
```</li>
<li><p>Now create your new branch called <strong>"subbranch_of_b1"</strong> under the <strong>"branch1"</strong> using the following command.</p>

```sh
git checkout -b subbranch_of_b1 branch1
```

The above will create a new branch called <strong>subbranch_of_b1</strong> under the branch <strong>branch1</strong> (note that `branch1` in the above command isn't mandatory since the HEAD is currently pointing to it, you can precise it if you are on a different branch though).  </li>
<li><p>Now after working with the <strong>subbranch_of_b1</strong> you can commit and push or merge it locally or remotely.</p></li>
</ol>

<a href="https://i.stack.imgur.com/6qEWk.jpg" rel="noreferrer"><img src="https://i.stack.imgur.com/6qEWk.jpg" alt="A sample Graphical Illustration Of Creating Branches Under another Branch"></a>  

<em>push the subbranch_of_b1 to remote</em>  

```sh
 git push origin subbranch_of_b1 
```

#### Answer 3 (score 35)
<strong>Create a Branch</strong>  

<ul>
<li>Create branch when master branch is checked out. Here commits in master will be synced to the branch you created.

`$ git branch branch1`  </li>
<li>Create branch when branch1 is checked out . Here commits in branch1 will be synced to  branch2

`$ git branch branch2`  </li>
</ul>

<hr>

<strong>Checkout a Branch</strong>  

git checkout command switch branches or restore working tree files  

<ul>
<li>`$ git checkout branchname`</li>
</ul>

<hr>

<strong>Renaming a Branch</strong>  

<ul>
<li>`$ git branch -m branch1 newbranchname`</li>
</ul>

<hr>

<strong>Delete a Branch</strong>  

<ul>
<li>`$ git branch -d branch-to-delete`</li>
<li>`$ git branch -D branch-to-delete`
( <em>force deletion without checking the merged status</em> )</li>
</ul>

<hr>

<strong>Create and Switch Branch</strong>  

<ul>
<li>`$ git checkout -b branchname`</li>
</ul>

<hr>

<strong>Branches that are completely included</strong>  

<ul>
<li>`$ git branch --merged`</li>
</ul>

<hr>

<hr>

************************** <strong>Branch Differences</strong> [ git diff branch1..branch2 ] ************************  

<strong>Multiline difference</strong>

<ul>
<li>`$ git diff master..branch1`</li>
</ul>

<strong>Singleline difference</strong>

<ul>
<li>`$ git diff --color-words branch1..branch2`</li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 58: Is there a way to cache GitHub credentials for pushing commits? (score [938473](https://stackoverflow.com/q/5343068) in 2019)

#### Question
I recently switched to synchronizing my repositories to https:// on GitHub (due to firewall issues), and it asks for a password every time.  

Is there a way to cache the credentials, instead of authenticating every time that `git push`?  

#### Answer accepted (score 2309)
<h5>With Git version 1.7.9 and later</h3>

Since Git 1.7.9 (released in late January 2012), there is a neat mechanism in Git to avoid having to type your password all the time for HTTP / HTTPS, called <a href="http://www.kernel.org/pub/software/scm/git/docs/gitcredentials.html" rel="noreferrer">credential helpers</a>. (Thanks to <a href="https://stackoverflow.com/users/109707/dazonic">dazonic</a> for pointing out this new feature in the comments below.)  

With Git 1.7.9 or later, you can just use one of the following credential helpers:  

```sh
git config --global credential.helper cache
```

... which tells Git to keep your password cached in memory for (by default) 15 minutes. You can set a longer timeout with:  

```sh
git config --global credential.helper "cache --timeout=3600"
```

(That example was suggested in the <a href="https://help.github.com/articles/caching-your-github-password-in-git/" rel="noreferrer">GitHub help page for Linux</a>.) You can also store your credentials permanently if so desired, see the other answers below.  

GitHub's help <a href="https://help.github.com/articles/set-up-git#platform-mac" rel="noreferrer">also suggests</a> that if you're on Mac OS X and used <a href="https://en.wikipedia.org/wiki/Homebrew_%28package_management_software%29" rel="noreferrer">Homebrew</a> to install Git, you can use the native Mac&nbsp;OS&nbsp;X keystore with:  

```sh
git config --global credential.helper osxkeychain
```

For Windows, there is a helper called <a href="https://github.com/Microsoft/Git-Credential-Manager-for-Windows" rel="noreferrer">Git Credential Manager for Windows</a> or <a href="https://stackoverflow.com/questions/11693074/git-credential-cache-is-not-a-git-command">wincred in msysgit</a>.  

```sh
git config --global credential.helper wincred # obsolete
```

With <a href="https://github.com/git-for-windows/git/releases/tag/v2.7.3.windows.1" rel="noreferrer">Git for Windows 2.7.3+</a> (March 2016):  

```sh
git config --global credential.helper manager
```

For Linux, you can <a href="https://stackoverflow.com/questions/13385690/how-to-use-git-with-gnome-keyring-integration">use `gnome-keyring`</a>(or other keyring implementation such as KWallet).  

<h5>With Git versions before 1.7.9</h3>

With versions of Git before 1.7.9, this more secure option is not available, and you'll need to change the URL that your `origin` remote uses to include the password in this fashion:  

```sh
https://you:password@github.com/you/example.git
```

... in other words with `:password` after the username and before the `@`.  

You can set a new URL for your `origin` remote with:  

```sh
git config remote.origin.url https://you:password@github.com/you/example.git
```

Make sure that you use `https`, and you should be aware that if you do this, your GitHub password will be stored in plaintext in your `.git` directory, which is obviously undesirable.  

<h5>With any Git version (well, since version 0.99)</h3>

An alternative approach is to put your username and password in your `~/.netrc` file, although, as with keeping the password in the remote URL, this means that your password will be stored on the disk in plain text and is thus less secure and not recommended. However, if you want to take this approach, add the following line to your `~/.netrc`:  

```sh
machine <hostname> login <username> password <password>
```

... replacing `&lt;hostname&gt;` with the server's hostname, and `&lt;username&gt;` and `&lt;password&gt;` with your username and password. Also remember to set restrictive file system permissions on that file:  

```sh
chmod 600 ~/.netrc
```

Note that on Windows, this file should be called `_netrc`, and you may need to define the %HOME% environment variable - for more details see:  

<ul>
<li><em><a href="https://stackoverflow.com/questions/6031214/git-how-to-use-netrc-file-on-windows-to-save-user-and-password">Git - How to use .netrc file on Windows to save user and password</a></em></li>
</ul>

#### Answer 2 (score 701)
You can also have Git store your credentials permanently using the following:  

```sh
git config credential.helper store
```

<p>Note: While this is convenient, Git will store your credentials in clear text in
a local file (.git-credentials) under your project directory (see below for the "home" directory). If you don't like this, delete this file and switch to using the
cache option.</p>

<p>If you want Git to resume to asking you for credentials every time it needs to
connect to the remote repository, you can run this command:</p>

```sh
git config --unset credential.helper
```

To store the passwords in `.git-credentials` in your `%HOME%` directory as opposed to the project directory: use the `--global` flag  

```sh
git config --global credential.helper store
```

#### Answer 3 (score 95)
<h5>TLDR; Use an <strong>encrypted netrc file with Git 1.8.3+</strong>.</h3>



Saving a password for a Git repository HTTPS URL is possible with a `~/.netrc` (Unix) or `%HOME%/_netrc` (note the `_`) on Windows.  

<strong>But</strong>: That file would store your password in plain text.  

<strong>Solution</strong>: Encrypt that file with <a href="http://www.gnupg.org/" rel="noreferrer">GPG (GNU Privacy Guard)</a>, and make Git decrypt it each time it needs a password (for `push`/`pull`/`fetch`/`clone` operation).  

<hr>

Note: with Git 2.18 (Q2 2018), you now can customize the GPG used to decrypt the encrypted `.netrc` file.  

<p>See <a href="https://github.com/git/git/commit/786ef50a23cbd0e93d1e41982cfaba76801ed885" rel="noreferrer">commit 786ef50</a>, <a href="https://github.com/git/git/commit/f07eeed123b8880b1723b1ea9d6d6f41cfb34532" rel="noreferrer">commit f07eeed</a> (12 May 2018) by <a href="https://github.com/" rel="noreferrer">Luis Marsano (``)</a>.<br>
<sup>(Merged by <a href="https://github.com/gitster" rel="noreferrer">Junio C Hamano -- `gitster` --</a> in <a href="https://github.com/git/git/commit/017b7c52fc00897c72f6c4808ded43c4c5f9c5b8" rel="noreferrer">commit 017b7c5</a>, 30 May 2018)</sup>  </p>

<blockquote>
  <h5>`git-credential-netrc`: accept `gpg` option</h2>
  
  <p>`git-credential-netrc` was hardcoded to decrypt with '`gpg`' regardless of
  the gpg.program option.<br>
  This is a problem on distributions like Debian that call modern GnuPG something else, like '`gpg2`'</p>
</blockquote>

<hr>

<h5>Step-by-Step instructions for Windows</h3>

With Windows:  

(Git has a `gpg.exe` in its distribution, but using a full GPG installation includes a `gpg-agent.exe`, which will memorize your passphrase associated to your GPG key.)  

<ul>
<li><p>Install <strong>`gpg4Win Lite`</strong>, the minimum gnupg command-line interface (take the <a href="http://files.gpg4win.org/Beta/?C=M;O=D" rel="noreferrer">most recent <strong>`gpg4win-vanilla-2.X.Y-betaZZ.exe`</strong></a>), and complete your PATH with the GPG installation directory:</p>

```sh
set PATH=%PATH%:C:\path\to\gpg
copy C:\path\to\gpg\gpg2.exe C:\path\to\gpg\gpg.exe
```</li>
</ul>

(Note the '`copy`' command: Git will need a Bash script to execute the command '`gpg`'. Since `gpg4win-vanilla-2` comes with `gpg2.exe`, you need to duplicate it.)  

<ul>
<li><p>Create or import a GPG key, and trust it:</p>

```sh
gpgp --import aKey
# or
gpg --gen-key
```</li>
</ul>

(Make sure to put a passphrase to that key.)  

<ul>
<li><p><a href="https://stackoverflow.com/a/9466332/6309">Trust that key</a></p></li>
<li><p>Install the credential helper script in a directory within your `%PATH%`:</p>

```sh
cd c:\a\fodler\in\your\path
curl -o c:\prgs\bin\git-credential-netrc https://raw.githubusercontent.com/git/git/master/contrib/credential/netrc/git-credential-netrc
```</li>
</ul>

(Yes, this is a Bash script, but it will work on Windows since it will be called by Git.)  

<ul>
<li><p>Make a _netrc file in clear text</p>

```sh
machine a_server.corp.com
login a_login
password a_password
protocol https

machine a_server2.corp.com
login a_login2
password a_password2
protocol https
```</li>
</ul>

(Don't forget the '`protocol`' part: '`http`' or '`https`' depending on the URL you will use.)  

<ul>
<li><p>Encrypt that file:</p>

```sh
gpg -e -r a_recipient _netrc
```</li>
</ul>

(You now can <em>delete</em> the `_netrc` file, keeping only the `_netrc.gpg` encrypted one.)  

<ul>
<li><p>Use that encrypted file:</p>

```sh
git config --local credential.helper "netrc -f C:/path/to/_netrc.gpg -v"
```</li>
</ul>

(Note the '`/`': `C:\path\to...` wouldn't work at all.) (You can use at first `-v -d` to see what is going on.)  

<p>From now on, any Git command using an HTTP(S) URL which requires authentication will decrypt that `_netrc.gpg` file and use the login/password associated to the server you are contacting.
The first time, GPG will ask you for the passphrase of your GPG key, to decrypt the file.
The other times, the gpg-agent <strong>launched automatically</strong> by the first GPG call will provide that passphrase for you.</p>

<p>That way, you can memorize <strong>several</strong> URLs/logins/passwords in one file, and have it stored on your disk encrypted. <br/>
I find it more convenient than a "cache" helper", where you need to remember and type (once per session) a different password for each of your remote services, for said password to be cached in memory.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 59: Ignoring directories in Git repos on Windows (score [935943](https://stackoverflow.com/q/343646) in 2017)

#### Question
How can I ignore directories or folders in Git using msysgit on Windows?  

#### Answer accepted (score 1444)
Create a file named `.gitignore` in your project's directory. Ignore directories by entering the directory name into the file (with a slash appended):  

```sh
dir_to_ignore/
```

More info <a href="http://git-scm.com/docs/gitignore" rel="noreferrer">here</a>.  

#### Answer 2 (score 194)
By default windows explorer will display `.gitignore` when in-fact the file name is `.gitignore.txt`  

Git will not use `.gitignore.txt`  

And you can't rename the file to `.gitignore` because explorer thinks its a file of type gitignore with no name.  

Non command line solution:   

<pre>You can rename a file to <b>".gitignore."</b> and it will create <b>".gitignore"</b></pre>

#### Answer 3 (score 97)
It seems that for ignoring files and directories there are two main ways:  

<ol>
<li><p><strong>.gitignore</strong> </p>

<ul>
<li>Placing `.gitignore` file into the root of your repo besides `.git` folder (in Windows make sure you <a href="http://windows.microsoft.com/en-us/windows/show-hide-file-name-extensions#show-hide-file-name-extensions=windows-7" rel="noreferrer">see the true file extension</a> and then make `.gitignore.` (with the point at the end to make empty file extension) ) </li>
<li>Making global configuration `~/.gitignore_global` and running `git config --global core.excludesfile ~/.gitignore_global` to add this to your git config</li>
</ul>

note: files tracked before can be untracked by running `git rm --cached filename`  </li>
<li><p><strong>Repo exclude</strong> - For local files that do not need to be shared, you just add the file pattern or directory to the file `.git/info/exclude`. Theses rules are not commited, so <strong>are not seen by other users</strong> more info <a href="http://help.github.com/ignore-files/" rel="noreferrer">here</a></p></li>
</ol>

<p>[updated]
To make exceptions in list of ignored files, see <a href="https://stackoverflow.com/questions/2415873/exceptions-in-gitignore">this question</a>.</p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 60: How to specify the private SSH-key to use when executing shell command on Git? (score [927267](https://stackoverflow.com/q/4565700) in 2018)

#### Question
A rather unusual situation perhaps, but I want to specify a private SSH-key to use when executing a shell (git) command from the local computer.  

Basically like this:   

```sh
git clone git@github.com:TheUser/TheProject.git -key "/home/christoffer/ssh_keys/theuser"
```

Or even better (in Ruby):  

```sh
with_key("/home/christoffer/ssh_keys/theuser") do
  sh("git clone git@github.com:TheUser/TheProject.git")
end
```

I have seen examples of connecting to a remote server with Net::SSH that uses a specified private key, but this is a local command. Is it possible?  

#### Answer accepted (score 690)
Something like this should work (suggested by orip):  

```sh
ssh-agent bash -c 'ssh-add /somewhere/yourkey; git clone git@github.com:user/project.git'
```

if you prefer subshells, you could try the following (though it is more fragile):  

```sh
ssh-agent $(ssh-add /somewhere/yourkey; git clone git@github.com:user/project.git)
```

Git will invoke SSH which will find its agent by environment variable; this will, in turn, have the key loaded.  

Alternatively, setting `HOME` may also do the trick, provided you are willing to setup a directory that contains only a `.ssh` directory as `HOME`; this may either contain an identity.pub, or a <a href="http://linux.die.net/man/5/ssh_config" rel="noreferrer">config file</a> setting IdentityFile.  

#### Answer 2 (score 1075)
None of these solutions worked for me.   

Instead, I elaborate on @Martin v. Löwis  's mention of setting a `config` file for SSH.  

SSH will look for the user's `~/.ssh/config` file. I have mine setup as:  

```sh
Host gitserv
    Hostname remote.server.com
    IdentityFile ~/.ssh/id_rsa.github
    IdentitiesOnly yes # see NOTES below
```

And I add a remote git repository:  

```sh
git remote add origin git@gitserv:myrepo.git
```

And then git commands work normally for me.  

```sh
git push -v origin master
```

<strong>NOTES</strong>  

<ul>
<li>The `IdentitiesOnly yes` is required to <a href="https://serverfault.com/questions/450796/how-could-i-stop-ssh-offering-a-wrong-key/450807#450807" title="foo">prevent the SSH default behavior</a> of sending the identity file matching the default filename for each protocol. If you have a file named `~/.ssh/id_rsa` that will get tried BEFORE your `~/.ssh/id_rsa.github` without this option.</li>
</ul>

<strong>References</strong>  

<ul>
<li><a href="https://stackoverflow.com/questions/2419566/best-way-to-use-multiple-ssh-private-keys-on-one-client">Best way to use multiple SSH private keys on one client</a></li>
<li><a href="https://serverfault.com/questions/450796/how-could-i-stop-ssh-offering-a-wrong-key/450807#450807" title="foo">How could I stop ssh offering a wrong key</a></li>
</ul>

#### Answer 3 (score 390)
Other people's suggestions about `~/.ssh/config` are extra complicated. It can be as simple as:  

```sh
Host github.com
  IdentityFile ~/.ssh/github_rsa
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 61: Easy way to pull latest of all git submodules (score [926733](https://stackoverflow.com/q/1030169) in 2018)

#### Question
We're using git submodules to manage a couple of large projects that have dependencies on many other libraries we've developed. Each library is a separate repo brought into the dependent project as a submodule. During development, we often want to just go grab the latest version of every dependent submodule.  

Does git have a built in command to do this?  If not, how about a Windows batch file or similar that can do it?  

#### Answer accepted (score 2283)
If it's <strong>the first time</strong> you checkout a repo you need to use `--init` first:  

```sh
git submodule update --init --recursive
```

For <strong>git 1.8.2</strong> or above the option `--remote` was added to support updating to latest tips of remote branches:  

```sh
git submodule update --recursive --remote
```

This has the added benefit of respecting any "non default" branches specified in the `.gitmodules` or `.git/config` files (if you happen to have any, default is origin/master, in which case some of the other answers here would work as well).  

For <strong>git 1.7.3</strong> or above you can use (but the below gotchas around what update does still apply):  

```sh
git submodule update --recursive
```

or:  

```sh
git pull --recurse-submodules
```

if you want to pull your submodules to latest commits intead of what the repo points to.  

See <a href="https://www.kernel.org/pub/software/scm/git/docs/git-submodule.html" rel="noreferrer">git-submodule(1)</a> for details  

#### Answer 2 (score 614)
```sh
git pull --recurse-submodules --jobs=10
```

<blockquote>
  <strong>a feature git first learned in 1.8.5.</strong>  
</blockquote>

For the first time you do need to run   

<blockquote>
  git submodule update --init --recursive  
</blockquote>

#### Answer 3 (score 375)
<h5>On init running the following command:</h2>

```sh
git submodule update --init --recursive
```

from within the git repo directory, works best for me.  

This will pull all latest including submodules.  

<h5>Explained</h2>

```sh
git - the base command to perform any git command
    submodule - Inspects, updates and manages submodules.
        update - Update the registered submodules to match what the superproject
        expects by cloning missing submodules and updating the working tree of the
        submodules. The "updating" can be done in several ways depending on command
        line options and the value of submodule.<name>.update configuration variable.
            --init without the explicit init step if you do not intend to customize
            any submodule locations.
            --recursive is specified, this command will recurse into the registered
            submodules, and update any nested submodules within.
```

<hr>

<h5>After this you can just run:</h2>

```sh
git submodule update --recursive
```

from within the git repo directory, works best for me.  

This will pull all latest including submodules.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 62: Why do I need to do `--set-upstream` all the time? (score [918075](https://stackoverflow.com/q/6089294) in 2013)

#### Question
I create a new branch in Git:  

```sh
git branch my_branch
```

Push it:  

```sh
git push origin my_branch
```

Now say someone made some changes on the server and I want to pull from `origin/my_branch`. I do:  

```sh
git pull
```

But I get:  

```sh
You asked me to pull without telling me which branch you
want to merge with, and 'branch.my_branch.merge' in
your configuration file does not tell me, either. Please
specify which branch you want to use on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details.

If you often merge with the same branch, you may want to
use something like the following in your configuration file:

    [branch "my_branch"]
    remote = <nickname>
    merge = <remote-ref>

    [remote "<nickname>"]
    url = <url>
    fetch = <refspec>

See git-config(1) for details.
```

I learned that I can make it work with:  

```sh
git branch --set-upstream my_branch origin/my_branch
```

But why do I need to do this for every branch I create? Isn't it obvious that if I push `my_branch` into `origin/my_branch`, then I would want to pull `origin/my_branch` into `my_branch`? How can I make this the default behavior?  

#### Answer accepted (score 1437)
A shortcut, which doesn't depend on remembering the syntax for `git branch --set-upstream` <sup>1</sup> is to do:  

```sh
git push -u origin my_branch
```

... the first time that you push that branch. Or, to push to the current branch to a branch of the same name (handy for an alias):  

```sh
git push -u origin HEAD
```

You only need to use `-u` once, and that sets up the association between your branch and the one at `origin` in the same way as `git branch --set-upstream` does.  

Personally, I think it's a good thing to have to set up that association between your branch and one on the remote explicitly.  It's just a shame that the rules are <a href="http://longair.net/blog/2011/02/27/an-asymmetry-between-git-pull-and-git-push/" rel="noreferrer">different for `git push` and `git pull`</a>.  

<hr>

<sup>1</sup> It may sound silly, but I very frequently forget to specify the current branch, assuming that's the default - it's not, and the results are most confusing :)  

<em>Update 2012-10-11</em>: Apparently I'm not the only person who found it easy to get wrong! Thanks to <a href="https://stackoverflow.com/users/6309/vonc">VonC</a> for pointing out that git 1.8.0 introduces the more obvious `git branch --set-upstream-to`, which can be used as follows, if you're on the branch `my_branch`:  

```sh
git branch --set-upstream-to origin/my_branch
```

... or with the short option:  

```sh
git branch -u origin/my_branch
```

This change, and its reasoning, is described in <a href="http://git.661346.n2.nabble.com/ANNOUNCE-Git-v1-8-0-rc1-tc7568792.html" rel="noreferrer">the release notes for git 1.8.0, release candidate 1</a>:  

<blockquote>
  It was tempting to say `git branch --set-upstream origin/master`, but that tells Git to arrange the local branch `origin/master` to integrate with the currently checked out branch, which is highly unlikely what the user meant.  The option is deprecated; use the new `--set-upstream-to` (with a short-and-sweet `-u`) option instead.  
</blockquote>

#### Answer 2 (score 1217)
You can make this happen with less typing. First, change the way your push works:  

```sh
git config --global push.default current
```

This will infer the `origin my_branch` part, thus you can do:  

```sh
git push -u
```

Which will both create the remote branch with the same name and track it.  

#### Answer 3 (score 83)
You can simply  

```sh
git checkout -b my-branch origin/whatever
```

in the first place. If you set `branch.autosetupmerge` or `branch.autosetuprebase` (my favorite) to `always` (default is `true`), `my-branch` will automatically track `origin/whatever`.  

See `git help config`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 63: Find and restore a deleted file in a Git repository (score [914401](https://stackoverflow.com/q/953481) in 2016)

#### Question
Say I'm in a Git repository. I delete a file and commit that change. I continue working and make some more commits. Then, I find I need to restore that file.  

I know I can checkout a file using `git checkout HEAD^ foo.bar`, but I don't really know when that file was deleted.  

<ol>
<li>What would be the quickest way to find the commit that deleted a given filename?</li>
<li>What would be the easiest way to get that file back into my working copy?</li>
</ol>

I'm hoping I don't have to manually browse my logs, checkout the entire project for a given SHA and then manually copy that file into my original project checkout.  

#### Answer accepted (score 3029)
Find the last commit that affected the given path. As the file isn't in the HEAD commit, this commit must have deleted it.  

```sh
git rev-list -n 1 HEAD -- <file_path>
```

Then checkout the version at the commit before, using the caret (`^`) symbol:  

```sh
git checkout <deleting_commit>^ -- <file_path>
```

Or in one command, if `$file` is the file in question.  

```sh
git checkout $(git rev-list -n 1 HEAD -- "$file")^ -- "$file"
```

<hr>

If you are using zsh and have the EXTENDED_GLOB option enabled, the caret symbol won't work. You can use `~1` instead.  

```sh
git checkout $(git rev-list -n 1 HEAD -- "$file")~1 -- "$file"
```

#### Answer 2 (score 827)
<ol>
<li>Use `git log --diff-filter=D --summary` to get all the commits which have deleted files and the files deleted;</li>
<li>Use `git checkout $commit~1 path/to/file.ext` to restore the deleted file.</li>
</ol>

Where `$commit` is the value of the commit you've found at step 1, e.g. `e4cf499627`  

#### Answer 3 (score 311)
To restore all those deleted files in a folder enter the following command.  

```sh
git ls-files -d | xargs git checkout --
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 64: git: fatal: Could not read from remote repository (score [907938](https://stackoverflow.com/q/13509293) in 2014)

#### Question
I am trying to set git up with <a href="http://danielmiessler.com/study/git/#website">http://danielmiessler.com/study/git/#website</a> to manage my site.  

I have gotten to the last step in the instructions:  git push website +master:refs/heads/master  

I am working using the git ming32 command line in win7  

```sh
$ git push website +master:refs/heads/master
Bill@***.com's password:
Connection closed by 198.91.80.3
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

One problem here may be that the program is looking for Bill@***.com. when I connect via ssh to my site I have a different username( lets say 'abc'). so maybe this should be abc@***.com. If so I don't know how to change this or if I can push under an alias  

#### Answer accepted (score 115)
You can specify the username that SSH should send to the remote system as part of your remote's URL.  Put the username, followed by an `@`, before the remote hostname.  

```sh
git remote set-url website abc@***.com:path/to/repo
```

#### Answer 2 (score 127)
Your ssh key most likely had been removed from ssh agent  

```sh
ssh-add ~/.ssh/id_rsa
```

where id_rsa is a ssh key associated with git repo  

#### Answer 3 (score 111)
Make sure you have correct url in `.git/config`  

```sh
url = git@github.com:username/repo.git
```

If it's your first push, you'll need to set up correct upstream  

```sh
$ git push -u origin master
```

You can check which key is used by:  

```sh
$ ssh -vvv git@github.com
```

The reply should contain something like this:  

```sh
debug1: Next authentication method: publickey
debug1: Offering RSA public key: ~/.ssh/id_rsa
...
You've successfully authenticated, but GitHub does not provide shell access.
```

Also it's possible to define rules for ssh in `~/.ssh/config`, e.g. based on aliases:  

```sh
   Host github
      HostName github.com 
      User git
      IdentityFile "~/.ssh/id_rsa"

   Host git
      HostName github.com 
      User git
      IdentityFile "~/.ssh/some_other_id"
```

You can set connect to different ports, use different username etc. for each alias.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 65: Move the most recent commit(s) to a new branch with Git (score [904253](https://stackoverflow.com/q/1628563) in 2017)

#### Question
I'd like to move the last several commits I've committed to master to a new branch and take master back to before those commits were made. Unfortunately, my Git-fu is not strong enough yet, any help?  

I.e. How can I go from this  

```sh
master A - B - C - D - E
```

to this?  

```sh
newbranch     C - D - E
             /
master A - B 
```

#### Answer accepted (score 5815)
<h5>Moving to an existing branch</h2>

If you want to move your commits to an <strong>existing branch</strong>, it will look like this:  



```sh
git checkout existingbranch
git merge master         # Bring the commits here
git checkout master
git reset --keep HEAD~3  # Move master back by 3 commits.
git checkout existingbranch
```

The `--keep` option preserves any uncommitted changes that you might have in unrelated files, or aborts if those changes would have to be overwritten -- similarly to what `git checkout` does. If it aborts, `git stash` your changes and retry, or use `--hard` to lose the changes (even from files that didn't change between the commits!)  

<h5>Moving to a new branch</h2>

This method works by creating a new branch with the first command (`git branch newbranch`) but not switching to it. Then we roll back the current branch (master) and switch to the new branch to continue working.  



```sh
git branch newbranch      # Create a new branch, containing all current commits
git reset --keep HEAD~3   # Move master back by 3 commits (Make sure you know how many commits you need to go back)
git checkout newbranch    # Go to the new branch that still has the desired commits
# Warning: after this it's not safe to do a rebase in newbranch without extra care.
```

But do make sure how many commits to go back. Alternatively, instead of `HEAD~3`, you can simply provide the hash of the commit (or the reference like `origin/master`) you want to revert back to, e.g:  

```sh
git reset --keep a1b2c3d4
```

<strong>WARNING:</strong> With Git version 2.0 and later, if you later `git rebase` the new branch upon the original (`master`) branch, you may need an explicit `--no-fork-point` option during the rebase to avoid losing the commits you moved from the master branch.  Having `branch.autosetuprebase always` set makes this more likely.  See <a href="https://stackoverflow.com/a/36463546/1256452">John Mellor's answer</a> for details.  

#### Answer 2 (score 963)
For those wondering why it works (as I was at first):  

You want to go back to C, and move D and E to the new branch.  Here's what it looks like at first:  

```sh
A-B-C-D-E (HEAD)
        ↑
      master
```

After `git branch newBranch`:  

```sh
    newBranch
        ↓
A-B-C-D-E (HEAD)
        ↑
      master
```

After `git reset --hard HEAD~2`:  

```sh
    newBranch
        ↓
A-B-C-D-E (HEAD)
    ↑
  master
```

Since a branch is just a pointer, <em>master</em> pointed to the last commit.  When you made <em>newBranch</em>, you simply made a new pointer to the last commit.  Then using `git reset` you moved the <em>master</em> pointer back two commits.  But since you didn't move <em>newBranch</em>, it still points to the commit it originally did.  

#### Answer 3 (score 421)
<h5>In General...</h1>

The method exposed by sykora is the best option in this case. But sometimes is not the easiest and it's not a general method. For a general method use <em>git cherry-pick</em>:  

To achieve what OP wants, its a 2-step process:  

<h5>Step 1 - Note which commits from master you want on a `newbranch`</h1>

Execute  

```sh
git checkout master
git log
```

<p>Note the hashes of (say 3) commits you want on `newbranch`. Here I shall use:<br>
C commit: `9aa1233`<br>
D commit: `453ac3d`<br>
E commit: `612ecb3`  </p>

<blockquote>
  <p><strong>Note:</strong> You can use the first seven characters or
  the whole commit hash</p>
</blockquote>

<h5>Step 2 - Put them on the `newbranch`</h1>

```sh
git checkout newbranch
git cherry-pick 612ecb3
git cherry-pick 453ac3d
git cherry-pick 9aa1233
```

<h5>OR (on Git 1.7.2+, use ranges)</h1>

```sh
git checkout newbranch
git cherry-pick 612ecb3~1..9aa1233
```

<em>git cherry-pick</em> applies those three commits to newbranch.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 66: Undoing a git rebase (score [900162](https://stackoverflow.com/q/134882) in 2014)

#### Question
Does anybody know how to easily undo a git rebase?  

The only way that comes to mind is to go at it manually:  

<ul>
<li>git checkout the commit parent to both of the branches </li>
<li>then create a temp branch from there</li>
<li>cherry-pick all commits by hand</li>
<li>replace the branch in which I rebased by the manually-created branch</li>
</ul>

In my current situation this is gonna work because I can easily spot commits from both branches (one was my stuff, the other was my colleague's stuff).  

However my approach strikes me as suboptimal and error-prone (let's say I had just rebased with 2 of my own branches).  

Any ideas?  

Clarification: I'm talking about a rebase during which a bunch of commits were replayed. Not only one.  

#### Answer accepted (score 3982)
The easiest way would be to find the head commit of the branch as it was immediately before the rebase started in the <a href="https://git-scm.com/docs/git-reflog" rel="noreferrer">reflog</a>...  

```sh
git reflog
```

and to reset the current branch to it (with the usual caveats about being absolutely sure before reseting with the `--hard` option).  

Suppose the old commit was `HEAD@{5}` in the ref log:  

```sh
git reset --hard HEAD@{5}
```

<em>In Windows, you may need to quote the reference:</em>  

```sh
git reset --hard "HEAD@{5}"
```

You can check the history of the candidate old head by just doing a `git log HEAD@{5}` (<em>Windows:</em> `git log "HEAD@{5}"`).  

If you've not disabled per branch reflogs you should be able to simply do `git reflog branchname@{1}` as a rebase detaches the branch head before reattaching to the final head. I would double check this, though as I haven't verified this recently.  

Per default, all reflogs are activated for non-bare repositories:  

```sh
[core]
    logAllRefUpdates = true
```

#### Answer 2 (score 1402)
Actually, rebase saves your starting point to `ORIG_HEAD` so this is usually as simple as:  

```sh
git reset --hard ORIG_HEAD
```

However, the `reset`, `rebase` and `merge` all save your original `HEAD` pointer into `ORIG_HEAD` so, if you've done any of those commands since the rebase you're trying to undo then you'll have to use the reflog.  

#### Answer 3 (score 359)
Charles's answer works, but you may want to do this:  

```sh
git rebase --abort
```

to clean up after the `reset`.   

Otherwise, you may get the message “`Interactive rebase already started`”.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 67: How can I reconcile detached HEAD with master/origin? (score [897094](https://stackoverflow.com/q/5772192) in 2017)

#### Question
I'm new at the branching complexities of Git. I always work on a single branch and commit changes and then periodically push to my remote origin.  

Somewhere recently, I did a reset of some files to get them out of commit staging, and later did a `rebase -i` to get rid of a couple recent local commits. Now I'm in a state I don't quite understand.  

In my working area, `git log` shows exactly what I'd expect-- I'm on the right train with the commits I didn't want gone, and new ones there, etc.  

But I just pushed to the remote repository, and what's there is different-- a couple of the commits I'd killed in the rebase got pushed, and the new ones committed locally aren't there.   

I think "master/origin" is detached from HEAD, but I'm not 100% clear on what that means, how to visualize it with the command line tools, and how to fix it.  

#### Answer accepted (score 2430)
First, let’s clarify <a href="https://git-scm.com/book/en/v2/Git-Internals-Git-References" rel="noreferrer"><strong>what HEAD is</strong></a> and what it means when it is detached.    

HEAD is the symbolic name for the currently checked out commit. When HEAD is not detached (the “normal”<sup>1</sup> situation: you have a branch checked out), HEAD actually points to a branch’s “ref” and the branch points to the commit. HEAD is thus “attached” to a branch. When you make a new commit, the branch that HEAD points to is updated to point to the new commit. HEAD follows automatically since it just points to the branch.  

<ul>
<li>`git symbolic-ref HEAD` yields `refs/heads/master`<br>
The branch named “master” is checked out.</li>
<li>`git rev-parse refs/heads/master` yield `17a02998078923f2d62811326d130de991d1a95a`<br>
That commit is the current tip or “head” of the master branch.</li>
<li>`git rev-parse HEAD` also yields `17a02998078923f2d62811326d130de991d1a95a`<br>
This is what it means to be a “symbolic ref”. It points to an object through some other reference.<br>
(Symbolic refs were originally implemented as symbolic links, but later changed to plain files with extra interpretation so that they could be used on platforms that do not have symlinks.)</li>
</ul>

We have `HEAD` → `refs/heads/master` → `17a02998078923f2d62811326d130de991d1a95a`  

When HEAD is detached, it points directly to a commit—instead of indirectly pointing to one through a branch. You can think of a detached HEAD as being on an unnamed branch.   

<ul>
<li>`git symbolic-ref HEAD` fails with `fatal: ref HEAD is not a symbolic ref`</li>
<li>`git rev-parse HEAD` yields `17a02998078923f2d62811326d130de991d1a95a`<br>
Since it is not a symbolic ref, it must point directly to the commit itself.</li>
</ul>

We have `HEAD` → `17a02998078923f2d62811326d130de991d1a95a`  

The important thing to remember with a detached HEAD is that if the commit it points to is otherwise unreferenced (no other ref can reach it), then it will become “dangling” when you checkout some other commit. Eventually, such dangling commits will be pruned through the garbage collection process (by default, they are kept for at least 2 weeks and may be kept longer by being referenced by HEAD’s reflog).  

<p><sup>1</sup>
It is perfectly fine to do “normal” work with a detached HEAD, you just have to keep track of what you are doing to avoid having to fish dropped history out of the reflog.</p>

<hr>

The intermediate steps of an interactive rebase are done with a detached HEAD (partially to avoid polluting the active branch’s reflog). If you finish the full rebase operation, it will update your original branch with the cumulative result of the rebase operation and reattach HEAD to the original branch. My guess is that you never fully completed the rebase process; this will leave you with a detached HEAD pointing to the commit that was most recently processed by the rebase operation.  

To recover from your situation, you should create a branch that points to the commit currently pointed to by your detached HEAD:  

```sh
git branch temp
git checkout temp
```

<sub>(these two commands can be abbreviated as `git checkout -b temp`)</sub>  

This will reattach your HEAD to the new `temp` branch.  

Next, you should compare the current commit (and its history) with the normal branch on which you expected to be working:  

```sh
git log --graph --decorate --pretty=oneline --abbrev-commit master origin/master temp
git diff master temp
git diff origin/master temp
```

(You will probably want to experiment with the log options: add `-p`, leave off `--pretty=…` to see the whole log message, etc.)  

If your new `temp` branch looks good, you may want to update (e.g.) `master` to point to it:  

```sh
git branch -f master temp
git checkout master
```

<sub>(these two commands can be abbreviated as `git checkout -B master temp`)</sub>  

You can then delete the temporary branch:  

```sh
git branch -d temp
```

Finally, you will probably want to push the reestablished history:  

```sh
git push origin master
```

You may need to add `--force` to the end of this command to push if the remote branch can not be “fast-forwarded” to the new commit (i.e. you dropped, or rewrote some existing commit, or otherwise rewrote some bit of history).  

If you were in the middle of a rebase operation you should probably clean it up. You can check whether a rebase was in process by looking for the directory `.git/rebase-merge/`. You can manually clean up the in-progress rebase by just deleting that directory (e.g. if you no longer remember the purpose and context of the active rebase operation). Usually you would use `git rebase --abort`, but that does some extra resetting that you probably want to avoid (it moves HEAD back to the original branch and resets it back to the original commit, which will undo some of the work we did above).  

#### Answer 2 (score 611)
Just do this:  

```sh
git checkout master
```

Or, if you have changes that you want to keep, do this:  

```sh
git checkout -b temp
git checkout -B master temp
```

#### Answer 3 (score 120)
I ran into this issue and when I read in the top voted answer:  

<blockquote>
  HEAD is the symbolic name for the currently checked out commit.  
</blockquote>

I thought: Ah-ha! If `HEAD` is the symbolic name for the currenlty checkout commit, I can reconcile it against `master` by rebasing it against `master`:  

```sh
git rebase HEAD master
```

This command:  

<ol>
<li>checks out `master`</li>
<li>identifies the parent commits of `HEAD` back to the point `HEAD` diverged from `master`</li>
<li>plays those commits on top of `master`</li>
</ol>

The end result is that all commits that were in `HEAD` but not `master` are then also in `master`. `master` remains checked out.   

<hr>

Regarding the remote:  

<blockquote>
  a couple of the commits I'd killed in the rebase got pushed, and the new ones committed locally aren't there.  
</blockquote>

The remote history can no longer be fast-forwarded using your local history. You'll need to force-push (`git push -f`) to overwrite the remote history. If you have any collaborators, it usually makes sense to coordinate this with them so everyone is on the same page.  

After you push `master` to remote `origin`, your remote tracking branch `origin/master` will be updated to point to the same commit as `master`.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 68: How to ignore certain files in Git (score [883957](https://stackoverflow.com/q/4308610) in 2019)

#### Question
I have a repository with a file, `Hello.java`. When I compile it, an additional `Hello.class` file is generated.  

I created an entry for `Hello.class` in a `.gitignore` file. However, the file still appears to be tracked.  

How can I make Git ignore `Hello.class`?  

#### Answer accepted (score 761)
The problem is that `.gitignore` ignores just files that weren't tracked before (by `git add`). Run `git reset name_of_file` to unstage the file and keep it. In case you want to also remove the given file from the repository (after pushing), use `git rm --cached name_of_file`.  

#### Answer 2 (score 196)
<strong>How to ignore new files</strong>  

<em>Globally</em>  

Add the path(s) to your file(s) which you would like to ignore to your .gitignore file (and commit them). These file entries will also apply to others checking out the repo.  

<em>Locally</em>  

Add the path(s) to your file(s) which you would like to ignore to your .git/info/exclude file. These file entries will only apply to your local working copy.  

<strong>How to ignore changed files (temporarily)</strong>  

In order to ignore changed files to being listed as modified, you can use the following git command:  

```sh
git update-index --assume-unchanged <file>
```

To revert that ignorance use the following command:  

```sh
git update-index --no-assume-unchanged <file>
```

#### Answer 3 (score 148)
Add the following line to .gitignore:  

```sh
/Hello.class
```

This will exclude Hello.class from git.  If you have already committed it, run the following command:  

```sh
git rm Hello.class
```

If you want to exclude all class files from git, add the following line to .gitignore:  

```sh
*.class
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 69: How to see the changes in a Git commit? (score [879722](https://stackoverflow.com/q/17563726) in 2019)

#### Question
When I do `git diff COMMIT` I see the changes between that commit and HEAD (as far as I know), but I would like to see the changes that were made by that single commit.  

I haven't found any obvious options on `diff` / `log` that will give me that output.  

#### Answer accepted (score 1715)
To see the diff for a particular  `COMMIT` hash:  

`git diff COMMIT~ COMMIT` will show you the difference between that `COMMIT`'s ancestor and the `COMMIT`. See the man pages for <a href="http://jk.gs/git-diff.html" rel="noreferrer">git diff</a> for details about the command and <a href="http://jk.gs/gitrevisions.html" rel="noreferrer">gitrevisions</a> about the `~` notation and its friends.    

Alternatively, `git show COMMIT` will do something very similar. (The commit's data, including its diff - but not for merge commits.) See the <a href="http://jk.gs/git-show.html" rel="noreferrer">git show manpage</a>.  

#### Answer 2 (score 457)
As mentioned in "<a href="https://stackoverflow.com/a/449128/6309">Shorthand for diff of git commit with its parent?</a>", you can also use <a href="https://git-scm.com/docs/git-diff" rel="noreferrer">`git diff`</a> with:  

```sh
git diff COMMIT^!
```

or  

```sh
git diff-tree -p COMMIT
```

With git show, you would need (in order to focus on diff alone) to do:  

```sh
git show --color --pretty=format:%b $COMMIT
```

The `COMMIT` parameter is a <strong><a href="https://git-scm.com/docs/gitglossary#def_commit-ish" rel="noreferrer">commit-ish</a></strong>:  

<blockquote>
  A <a href="https://git-scm.com/docs/gitglossary#def_commit_object" rel="noreferrer">commit object</a> or an <a href="https://git-scm.com/docs/gitglossary#def_object" rel="noreferrer">object</a> that can be recursively dereferenced to a commit object. The following are all commit-ishes: a commit object, a <a href="https://git-scm.com/docs/gitglossary#def_tag_object" rel="noreferrer">tag object</a> that points to a commit object, a tag object that points to a tag object that points to a commit object, etc.  
</blockquote>

<p>See <a href="https://git-scm.com/docs/gitrevisions#_specifying_revisions" rel="noreferrer">gitrevision "SPECIFYING REVISIONS"</a> to reference a commit-ish.<br>
See also "<a href="https://stackoverflow.com/a/18605496/6309">What does tree-ish mean in Git?</a>".</p>

#### Answer 3 (score 300)
You can also try this easy way:  

```sh
git show <COMMIT>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 70: LF will be replaced by CRLF in git - What is that and is it important? (score [875112](https://stackoverflow.com/q/5834014) in 2017)

#### Question
<blockquote>
  <p><strong>Possible Duplicate:</strong><br>
  <a href="https://stackoverflow.com/questions/1967370/git-replacing-lf-with-crlf">git replacing LF with CRLF</a>  </p>
</blockquote>



<p>When I create a new rails application I'm seeing a warning in git about LF replacement. I do 
    git init
    git add .</p>

and then boom! I see this pop up for almost all files. I usually just keep going and build my application and it disappears after many changes to files.   

<strong>Example:</strong>  

<blockquote>
  <p>The file will have its original line endings in your working directory.
  warning: LF will be replaced by CRLF in Gemfile.</p>
  
  <p>The file will have its original line endings in your working directory.
  warning: LF will be replaced by CRLF in Gemfile.lock.</p>
  
  <p>The file will have its original line endings in your working directory.
  warning: LF will be replaced by CRLF in README.</p>
</blockquote>

What's the difference between LF and CRLF?  

Should I be concerned about this in the long run or just ignore it and keep going as I usually do?  

#### Answer accepted (score 1387)
In Unix systems the end of a line is represented with a line feed (LF). In windows a line is represented with a carriage return (CR) and a line feed (LF) thus (CRLF). when you get code from git that was uploaded from a unix system they will only have an LF.  

If you are a single developer working on a windows machine, and you don't care that git automatically replaces LFs to CRLFs, you can turn this warning off by typing the following in the git command line  

```sh
git config core.autocrlf true
```

If you want to make an intelligent decision how git should handle this, <a href="http://git-scm.com/book/en/v2/Customizing-Git-Git-Configuration#Formatting-and-Whitespace" rel="noreferrer">read the documentation</a>   

Here is a snippet  

<blockquote>
  <strong>Formatting and Whitespace</strong>  
  
  <p>Formatting and whitespace issues are some of the more frustrating and
  subtle problems that many developers encounter when collaborating,
  especially cross-platform. It’s very easy for patches or other
  collaborated work to introduce subtle whitespace changes because
  editors silently introduce them, and if your files ever touch a
  Windows system, their line endings might be replaced. Git has a few
  configuration options to help with these issues.</p>

```sh
core.autocrlf
```
  
  <p>If you’re programming on Windows and working with people who are not
  (or vice-versa), you’ll probably run into line-ending issues at some
  point. This is because Windows uses both a carriage-return character
  and a linefeed character for newlines in its files, whereas Mac and
  Linux systems use only the linefeed character. This is a subtle but
  incredibly annoying fact of cross-platform work; many editors on
  Windows silently replace existing LF-style line endings with CRLF, or
  insert both line-ending characters when the user hits the enter key.</p>
  
  <p>Git can handle this by auto-converting CRLF line endings into LF when
  you add a file to the index, and vice versa when it checks out code
  onto your filesystem. You can turn on this functionality with the
  core.autocrlf setting. If you’re on a Windows machine, set it to true
  – this converts LF endings into CRLF when you check out code:</p>

```sh
$ git config --global core.autocrlf true
```
  
  <p>If you’re on a Linux or Mac system that uses LF line endings, then you
  don’t want Git to automatically convert them when you check out files;
  however, if a file with CRLF endings accidentally gets introduced,
  then you may want Git to fix it. You can tell Git to convert CRLF to
  LF on commit but not the other way around by setting core.autocrlf to
  input:</p>

```sh
$ git config --global core.autocrlf input
```
  
  <p>This setup should leave you with CRLF endings in Windows checkouts,
  but LF endings on Mac and Linux systems and in the repository.</p>
  
  <p>If you’re a Windows programmer doing a Windows-only project, then you
  can turn off this functionality, recording the carriage returns in the
  repository by setting the config value to false:</p>

```sh
$ git config --global core.autocrlf false
```
</blockquote>

#### Answer 2 (score 337)
If you want, you can deactivate this feature in your git core config using  

```sh
git config core.autocrlf false
```

But it would be better to just get rid of the warnings using  

```sh
git config core.autocrlf true
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 71: Why is Git better than Subversion? (score [874452](https://stackoverflow.com/q/871) in 2010)

#### Question
I've been using <a href="http://en.wikipedia.org/wiki/Apache_Subversion" rel="nofollow noreferrer">Subversion</a> for a few years and after using <a href="http://en.wikipedia.org/wiki/Microsoft_Visual_SourceSafe" rel="nofollow noreferrer">SourceSafe</a>, I just love Subversion.  Combined with <a href="http://en.wikipedia.org/wiki/TortoiseSVN" rel="nofollow noreferrer">TortoiseSVN</a>, I can't really imagine how it could be any better.    

Yet there's a growing number of developers claiming that Subversion has problems and that we should be moving to the new breed of distributed version control systems, such as <a href="http://git.or.cz/" rel="nofollow noreferrer" title="Git Distributed Version Control System">Git</a>.    

How does Git improve upon Subversion?  

#### Answer accepted (score 548)
Git is not better than Subversion. But is also not worse. It's different.  

The key difference is that it is decentralized. Imagine you are a developer on the road, you develop on your laptop and you want to have source control so that you can go back 3 hours.  

With Subversion, you have a Problem: The SVN Repository may be in a location you can't reach (in your company, and you don't have internet at the moment), you cannot commit. If you want to make a copy of your code, you have to literally copy/paste it.  

With Git, you do not have this problem. Your local copy is a repository, and you can commit to it and get all benefits of source control. When you regain connectivity to the main repository, you can commit against it.  

This looks good at first, but just keep in mind the added complexity to this approach.  

Git seems to be the "new, shiny, cool" thing. It's by no means bad (there is a reason Linus wrote it for the Linux Kernel development after all), but I feel that many people jump on the "Distributed Source Control" train just because it's new and is written by Linus Torvalds, without actually knowing why/if it's better.  

Subversion has Problems, but so does Git, Mercurial, CVS, TFS or whatever.  

<strong>Edit:</strong> So this answer is now a year old and still generates many upvotes, so I thought I'll add some more explanations. In the last year since writing this, Git has gained a lot of momentum and support, particularly since sites like GitHub really took off. I'm using both Git and Subversion nowadays and I'd like to share some personal insight.  

First of all, Git can be really confusing at first when working decentralized. What is a remote? and How to properly set up the initial repository? are two questions that come up at the beginning, especially compared to SVN's simple "svnadmin create", Git's "git init" can take the parameters --bare and --shared which seems to be the "proper" way to set up a centralized repository. There are reasons for this, but it adds complexity. The documentation of the "checkout" command is very confusing to people changing over - the "proper" way seems to be "git clone", while "git checkout" seems to switch branches.  

Git REALLY shines when you are decentralized. I have a server at home and a Laptop on the road, and SVN simply doesn't work well here. With SVN, I can't have local source control if I'm not connected to the repository (Yes, I know about SVK or about ways to copy the repo). With Git, that's the default mode anyway. It's an extra command though (git commit commits locally, whereas git push origin master pushes the master branch to the remote named "origin").  

As said above: Git adds complexity. Two modes of creating repositories, checkout vs. clone, commit vs. push... You have to know which commands work locally and which work with "the server" (I'm assuming most people still like a central "master-repository").  

Also, the tooling is still insufficient, at least on Windows. Yes, there is a Visual Studio AddIn, but I still use git bash with msysgit.  

SVN has the advantage that it's MUCH simpler to learn: There is your repository, all changes to towards it, if you know how to create, commit and checkout and you're ready to go and can pickup stuff like branching, update etc. later on.  

Git has the advantage that it's MUCH better suited if some developers are not always connected to the master repository. Also, it's much faster than SVN. And from what I hear, branching and merging support is a lot better (which is to be expected, as these are the core reasons it was written).  

This also explains why it gains so much buzz on the Internet, as Git is perfectly suited for Open Source projects: Just Fork it, commit your changes to your own Fork, and then ask the original project maintainer to pull your changes. With Git, this just works. Really, try it on Github, it's magic.  

What I also see are Git-SVN Bridges: The central repository is a Subversion repo, but developers locally work with Git and the bridge then pushes their changes to SVN.  

But even with this lengthy addition, I still stand by my core message: Git is not better or worse, it's just different. If you have the need for "Offline Source Control" and the willingness to spend some extra time learning it, it's fantastic. But if you have a strictly centralized Source Control and/or are struggling to introduce Source Control in the first place because your co-workers are not interested, then the simplicity and excellent tooling (at least on Windows) of SVN shine.  

#### Answer 2 (score 145)
With Git, you can do practically anything offline, because everybody has their own repository.  

Making branches and merging between branches is really easy.  

Even if you don't have commit rights for a project, you can still have your own repository online, and publish "push requests" for your patches. Everybody who likes your patches can pull them into their project, including the official maintainers.  

It's trivial to fork a project, modify it, and still keep merging in the bugfixes from the HEAD branch.   

Git works for the Linux kernel developers. That means it is really fast (it has to be), and scales to thousands of contributors. Git also uses less space (up to 30 times less space for the Mozilla repository).  

Git is very flexible, very TIMTOWTDI (There is more than one way to do it). You can use whatever workflow you want, and Git will support it.  

Finally, there's <a href="http://en.wikipedia.org/wiki/GitHub" rel="nofollow noreferrer">GitHub</a>, a great site for hosting your Git repositories.  

Drawbacks of Git:   

<ul>
<li>it's much harder to learn, because Git has more concepts and more commands.</li>
<li>revisions don't have version numbers like in subversion</li>
<li>many Git commands are cryptic, and error messages are very user-unfriendly</li>
<li>it lacks a good GUI (such as the great <a href="http://en.wikipedia.org/wiki/TortoiseSVN" rel="nofollow noreferrer">TortoiseSVN</a>)</li>
</ul>

#### Answer 3 (score 110)
Other answers have done a good job of explaining the core features of Git (which are great). But there's also so many <em>little</em> ways that Git behaves better and helps keep my life more sane. Here are some of the little things:  

<ol>
<li>Git has a 'clean' command. SVN desperately needs this command, considering how frequently it will dump extra files on your disk.</li>
<li>Git has the 'bisect' command. It's nice.</li>
<li>SVN creates .svn directories in every single folder (Git only creates <em>one</em> .git directory). Every script you write, and every grep you do, will need to be written to ignore these .svn directories. You also need an entire command ("svn export") just to get a sane copy of your files.</li>
<li>In SVN, each file &amp; folder can come from a different revision or branch. At first, it sounds nice to have this freedom. But what this actually means is that there is a million different ways for your local checkout to be completely screwed up. (for example, if "svn switch" fails halfway through, or if you enter a command wrong). And the worst part is: if you ever get into a situation where some of your files are coming from one place, and some of them from another, the "svn status" will tell you that everything is normal. You'll need to do "svn info" on each file/directory to discover how weird things are. If "git status" tells you that things are normal, then you can trust that things really are normal.</li>
<li>You have to tell SVN whenever you move or delete something. Git will just figure it out.</li>
<li>Ignore semantics are easier in Git. If you ignore a pattern (such as *.pyc), it will be ignored for <em>all</em> subdirectories. (But if you really want to ignore something for just one directory, you can). With SVN, it seems that there is no easy way to ignore a pattern across all subdirectories.</li>
<li>Another item involving ignore files. Git makes it possible to have "private" ignore settings (using the file .git/info/exclude), which won't affect anyone else.</li>
</ol>

</b> </em> </i> </small> </strong> </sub> </sup>

### 72: How to solve Permission denied (publickey) error when using Git? (score [870971](https://stackoverflow.com/q/2643502) in 2018)

#### Question
I'm on Mac Snow Leopard and I just installed `git`.  

I just tried   

```sh
git clone git@thechaw.com:cakebook.git
```

but that gives me this error:  

```sh
Initialized empty Git repository in `/Users/username/Documents/cakebook/.git/`
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
```

<p>What am I missing?<br>
I've also tried doing `ssh-keygen` with no passphase but still same error.</p>

#### Answer accepted (score 684)
<strong>the user have not generated a ssh public/private key pair set before ?</strong>  

This info is working on theChaw but can be applied to all other git repositories which support SSH pubkey authentications. (See <a href="https://github.com/sitaramc/gitolite" rel="noreferrer">gitolite</a>, gitlab or github for example.)  

<blockquote>
  <p>First start by setting up your own public/private key pair set. This
  can use either DSA or RSA, so basically any key you setup will work.
  On most systems you can use ssh-keygen.</p>
  
  <ul>
  <li>First you'll want to cd into your .ssh directory. Open up the terminal and run:
  
  <blockquote>
    `cd ~/.ssh &amp;&amp; ssh-keygen`  
  </blockquote></li>
  <li>Next you need to copy this to your clipboard.
  
  <ul>
  <li>On OS X run: `cat id_rsa.pub | pbcopy` </li>
  <li>On Linux run: `cat id_rsa.pub | xclip`</li>
  <li>On Windows (via Cygwin/Git Bash) run: `cat id_rsa.pub | clip`</li>
  </ul></li>
  <li>Add your key to your account via the website.</li>
  <li>Finally setup your .gitconfig.
  
  <ul>
  <li>`git config --global user.name "bob"`</li>
  <li>`git config --global user.email bob@...`
  (don't forget to restart your command line to make sure the config is reloaded)</li>
  </ul></li>
  </ul>
  
  Thats it you should be good to clone and checkout.  
</blockquote>

<p>Further information can be found on <a href="https://help.github.com/articles/generating-ssh-keys" rel="noreferrer">https://help.github.com/articles/generating-ssh-keys</a> (thanks to @Lee Whitney)
 -</p>

<strong>the user have generated a ssh public/private key pair set before ?</strong>  

<ul>
<li>check which key have been authorized on your github or gitlab account settings</li>
<li>tells which corresponding private key must be associated from your local computer</li>
</ul>

`eval $(ssh-agent -s)`  

tell where the keys are located   

`ssh-add ~/.ssh/id_rsa`  

#### Answer 2 (score 199)
More extensive troubleshooting and even  automated fixing can be done with:   

```sh
ssh -vT git@github.com
```

Source: <a href="https://help.github.com/articles/error-permission-denied-publickey/" rel="noreferrer">https://help.github.com/articles/error-permission-denied-publickey/</a>  

#### Answer 3 (score 150)
This error can happen when you are accessing the SSH URL (Read/Write) instead of Git Read-Only URL but you have no write access to that repo.  

Sometimes you just want to clone your own repo, e.g. deploy to a server. In this case you actually only need READ-ONLY access. But since that's <em>your own</em> repo, GitHub may display SSH URL if that's your preference. In this situation, if your remote host's public key is not in your GitHub SSH Keys, your access will be denied, <strong>which is expected to happen</strong>.  

An equivalent case is when you try cloning someone else's repo to which you have no write access with SSH URL.  

In a word, <strong>if your intent is to clone-only a repo, use HTTPS URL</strong> (`https://github.com/{user_name}/{project_name}.git`) instead of SSH URL (`git@github.com:{user_name}/{project_name}.git`), which avoids (unnecessary) public key validation.  

<hr>

Update: GitHub is displaying HTTPS as the default protocol now and this move can probably reduce possible misuse of SSH URLs.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 73: How can I add an empty directory to a Git repository? (score [869097](https://stackoverflow.com/q/115983) in 2014)

#### Question
How can I add an empty directory (that contains no files) to a Git repository?  

#### Answer accepted (score 3857)
Another way to make a directory stay (almost) empty (in the repository) is to create a `.gitignore` file inside that directory that contains these four lines:  

```sh
# Ignore everything in this directory
*
# Except this file
!.gitignore
```

Then you don't have to get the order right the way that you have to do in m104's <a href="https://stackoverflow.com/a/180917/32453">solution</a>.  

This also gives the benefit that files in that directory won't show up as "untracked" when you do a git status.  

Making <a href="https://stackoverflow.com/users/554807/greenasjade">@GreenAsJade</a>'s comment persistent:  

<blockquote>
  I think it's worth noting that this solution does precisely what the question asked for, but is not perhaps what many people looking at this question will have been looking for. This solution guarantees that the directory remains empty. It says "I truly never want files checked in here". As opposed to "I don't have any files to check in here, yet, but I need the directory here, files may be coming later".  
</blockquote>

#### Answer 2 (score 1051)
You can't.  See the <a href="https://git.wiki.kernel.org/index.php/GitFaq#Can_I_add_empty_directories.3F" rel="noreferrer">Git FAQ</a>.  

<blockquote>
  <p>Currently the design of the git index
  (staging area) only permits files to
  be listed, and nobody competent enough
  to make the change to allow empty
  directories has cared enough about
  this situation to remedy it.</p>
  
  <p>Directories are added automatically
  when adding files inside them. That
  is, directories never have to be added
  to the repository, and are not tracked
  on their own.</p>
  
  <p>You can say "`git add &lt;dir&gt;`" and it
  will add files in there.</p>
  
  <p>If you really need a directory to
  exist in checkouts you should create a
  file in it. .gitignore works well for
  this purpose; you can leave it empty,
  or fill in the names of files you
  expect to show up in the directory.</p>
</blockquote>

#### Answer 3 (score 686)
Create an empty file called `.gitkeep` in the directory, and add that.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 74: Updating a local repository with changes from a GitHub repository (score [867048](https://stackoverflow.com/q/1443210) in 2019)

#### Question
I've got a project checked locally from GitHub, and that remote repository has since had changes made to it. What's the correct command to update my local copy with the latest changes?  

#### Answer accepted (score 730)
Probably:  

```sh
git pull origin master
```

#### Answer 2 (score 80)
This should work for every default repo:  

```sh
git pull origin master
```

If your default branch is different than `master`, you will need to specify the branch name:  

```sh
git pull origin my_default_branch_name
```

#### Answer 3 (score 61)
```sh
git fetch [remotename]
```

However you'll need to merge any changes into your local branches. If you're on a branch that's tracking a remote branch on Github, then  

```sh
git pull
```

will first do a fetch, and then merge in the tracked branch  

</b> </em> </i> </small> </strong> </sub> </sup>

### 75: Rollback to an old Git commit in a public repo (score [861582](https://stackoverflow.com/q/2007662) in 2015)

#### Question
How can I go about rolling back to a specific commit in git?  

The best answer someone could give me was to use `git revert` X times until I reach the desired commit.    

So let's say I want to revert back to a commit that's 20 commits old, I'd have to run it 20 times.    

Is there an easier way to do this?    

I can't use reset because this repository is public.  

#### Answer accepted (score 1124)
Try this:  

```sh
git checkout [revision] .
```

where `[revision]` is the commit hash (for example: `12345678901234567890123456789012345678ab`).   

Don't forget the `.` at the end, very important. This will apply changes to the whole tree. You should execute this command in the git project root. If you are in any sub directory, then this command only changes the files in the current directory. Then commit and you should be good.  

You can undo this by  

```sh
git reset --hard 
```

that will delete all modifications from the working directory and staging area.  

#### Answer 2 (score 184)
To rollback to a specific commit:  

```sh
git reset --hard commit_sha
```

To rollback 10 commits back:  

```sh
git reset --hard HEAD~10
```

You can use "git revert" as in the following post if you don't want to rewrite the history  

<a href="https://stackoverflow.com/questions/4114095/revert-git-repo-to-a-previous-commit/4114122#4114122">How to revert Git repository to a previous commit?</a>  

#### Answer 3 (score 86)
Well, I guess the question is, what do you mean by 'roll back'? If you can't `reset` because it's public and you want to keep the commit history intact, do you mean you just want your working copy to reflect a specific commit? Use `git checkout` and the commit hash.  

Edit: As was pointed out in the comments, using `git checkout` without specifying a branch will leave you in a "no branch" state. Use `git checkout &lt;commit&gt; -b &lt;branchname&gt;` to checkout into a branch, or `git checkout &lt;commit&gt; .` to checkout into the current branch.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 76: GitHub Error Message - Permission denied (publickey) (score [852612](https://stackoverflow.com/q/12940626) in 2016)

#### Question
Anybody seen this error and know what to do?  

I'm using the terminal, I'm in the root, the GitHub repository exists and I don't know what to do now.  

```sh
> git push -u origin master
Permission denied (publickey).
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
```

#### Answer accepted (score 637)
GitHub isn't able to authenticate you.  So, either you aren't setup with an SSH key, because you haven't <a href="https://help.github.com/articles/generating-ssh-keys">set one up on your machine</a>, or your key isn't associated with your GitHub account.  

You can also use the HTTPS URL instead of the SSH/git URL to avoid having to deal with SSH keys.  This is <a href="https://help.github.com/articles/set-up-git">GitHub's recommended method</a>.  

Further, GitHub has a <a href="https://help.github.com/articles/error-permission-denied-publickey">help page specifically for that error message</a>, and explains in more detail everything you could check.  

#### Answer 2 (score 69)
Did you create a <strong>config</strong> file in your ~/.ssh directory?  It should have contents like these:  

```sh
Host github.com 
 IdentityFile ~/.ssh/github_rsa
```

Assuming that you created an ssh key named <strong>github_rsa</strong>  

and uploaded it to GitHub...  

NOTE: You must follow this way of explicit configuration if you have more than 1 key (2 and more) in your ~/.ssh/ directory. If you don't specify key this way, then first key in order is taken and used for github authentication, so it depends on the key file name then.  

#### Answer 3 (score 59)
You need to generate an SSH key (if you don't have one) and associate the public key with your Github account.  See <a href="https://help.github.com/articles/generating-ssh-keys">Github's own documentation</a>.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 77: How do I resolve git saying "Commit your changes or stash them before you can merge"? (score [849978](https://stackoverflow.com/q/15745045) in 2019)

#### Question
I made some updates on my local machine, pushed them to a remote repository, and now I'm trying to pull the changes to the server and I get the message;  

<blockquote>
  error: Your local changes to the following files would be overwritten by merge:  
  
  wp-content/w3tc-config/master.php  
  
  Please, commit your changes or stash them before you can merge.  
</blockquote>

So I ran,  

```sh
git checkout -- wp-content/w3tc-config/master.php
```

and tried again and I get the same message. I'm assuming that `w3tc` changed something in the config file on the server. I don't care whether the local copy or remote copy goes on the server (I suppose the remote one is best), I just want to be able to merge the rest of my changes (plugin updates).  

Any ideas?  

#### Answer accepted (score 1158)
You can't merge with local modifications. Git protects you from losing potentially important changes.  

You have three options:   

<ul>
<li><h5>Commit the change using</h2>

```sh
git commit -m "My message"
```</li>
<li><h5>Stash it.</h2>

Stashing acts as a stack, where you can push changes, and you pop them in reverse order.  

To stash, type  

```sh
git stash
```

Do the merge, and then pull the stash:  

```sh
git stash pop
```</li>
<li><h5>Discard the local changes</h2>

<p>using `git reset --hard`<br>
or `git checkout -t -f remote/branch`</p>

<h5>Or: Discard local changes for a specific file</h2>

using `git checkout filename`  </li>
</ul>

#### Answer 2 (score 66)
```sh
git stash
git pull <remote name> <remote branch name> (or) switch branch
git stash apply --index
```

The first command stores your changes temporarily in <a href="https://git-scm.com/book/en/v1/Git-Tools-Stashing" rel="noreferrer">the stash</a> and removes them from the working directory.  

The second command switches branches.  

The third command restores the changes which you have stored in the stash (the `--index` option is useful to make sure that staged files are still staged).  

#### Answer 3 (score 21)
You can try one of the following methods:  

<h5>rebase</h3>

For simple changes try rebasing on top of it while pulling the changes, e.g.  

```sh
git pull origin master -r
```

So it'll apply your current branch on top of the upstream branch after fetching.  

This is equivalent to: `checkout master`, `fetch` and `rebase origin/master` git commands.  

<blockquote>
  This is a potentially dangerous mode of operation. It rewrites history, which does not bode well when you published that history already. Do not use this option unless you have read <a href="https://git-scm.com/docs/git-rebase" rel="noreferrer">`git-rebase(1)`</a> carefully.  
</blockquote>

<hr>

<h5>checkout</h3>

If you don't care about your local changes, you can switch to other branch temporary (with force), and switch it back, e.g.  

```sh
git checkout origin/master -f
git checkout master -f
```

<hr>

<h5>reset</h3>

If you don't care about your local changes, try to reset it to HEAD (original state), e.g.  

```sh
git reset HEAD --hard
```

If above won't help, it may be rules in your git normalization file (`.gitattributes`) so it's better to commit what it says. Or your file system doesn't support permissions, so you've to disable `filemode` in your git config.  

Related: <a href="https://stackoverflow.com/q/1125968/55075">How do I force &quot;git pull&quot; to overwrite local files?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 78: ignoring any 'bin' directory on a git project (score [846770](https://stackoverflow.com/q/1470572) in 2017)

#### Question
I have a directory structure like this:  

```sh
.git/
.gitignore
main/
  ...
tools/
  ...
...
```

Inside main and tools, and any other directory, at any level, there can be a 'bin' directory, which I want to ignore (and I want to ignore everything under it too). I've tried each of these patterns in .gitignore but none of them work:  

```sh
/**/bin/**/*
/./**/bin/**/*
./**/bin/**/*
**/bin/**/*
*/bin/**/*
bin/**/*
/**/bin/* #and the others with just * at the end too
```

Can anyone help me out? The first pattern (the one I think should be working) works just fine if I do this:  

```sh
/main/**/bin/**/*
```

But I don't want to have an entry for every top-level directory and I don't want to have to modify .gitignore every time I add a new one.  

This is on Windows using the latest msysgit.  

EDIT: <strong>one more thing, there are files and directories that have the substring 'bin' in their names, I don't want those to be ignored :)</strong>  

#### Answer accepted (score 1722)
Before version 1.8.2, `**` didn't have any special meaning in the `.gitignore`. As of 1.8.2 git supports `**` to mean zero or more sub-directories (see <a href="https://github.com/git/git/blob/master/Documentation/RelNotes/1.8.2.txt" rel="noreferrer">release notes</a>).  

The way to ignore all directories called bin anywhere below the current level in a directory tree is with a `.gitignore` file with the pattern:  

```sh
bin/
```

In the `man` page, there an example of ignoring a directory called `foo` using an analogous pattern.  

<p><strong>Edit:</strong> 
If you already have any bin folders in your git index which you no longer wish to track then you need to remove them explicitly. Git won't stop tracking paths that are already being tracked just because they now match a new `.gitignore` pattern. Execute a folder remove (<strong>rm</strong>) from index only (<strong>--cached</strong>) recursivelly (<strong>-r</strong>). Command line example for root bin folder:</p>

```sh
git rm -r --cached bin
```

#### Answer 2 (score 448)
The `.gitignore` of your dream seems to be:  

```sh
bin/
```

on the top level.  

#### Answer 3 (score 211)
I think it is worth to mention for git beginners:  

<blockquote>
  <p>If you already have a file checked in, and you want to ignore it, <strong>Git
  will not ignore the file if you add a rule later</strong>. In those cases, you
  must untrack the file first, by running the following command in your
  terminal:</p>
  
  `git rm --cached`  
</blockquote>

So if you want add to ignore some directories in your local repository (which already exist) after editing .gitignore you want to run this on your root dir  

```sh
git rm --cached -r .
git add .
```

It will basically 'refresh' your local repo and unstage ignored files.   

See:  

<a href="http://git-scm.com/docs/git-rm" rel="noreferrer">http://git-scm.com/docs/git-rm</a>,  

<a href="https://help.github.com/articles/ignoring-files/" rel="noreferrer">https://help.github.com/articles/ignoring-files/</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 79: How do I make Git use the editor of my choice for commits? (score [845181](https://stackoverflow.com/q/2596805) in 2017)

#### Question
I would prefer to write my commit messages in Vim, but it is opening them in Emacs.  

How do I configure Git to always use Vim?  Note that I want to do this globally, not just for a single project.  

#### Answer accepted (score 3207)
If you want to set the editor <em>only</em> for Git, do either (you don’t need both):  

<ul>
<li>Set <a href="http://git-scm.com/book/en/Customizing-Git-Git-Configuration#Basic-Client-Configuration" rel="noreferrer">`core.editor`</a> in your Git config: `git config --global core.editor "vim"`</li>
<li>Set the <a href="http://git-scm.com/docs/git-var#_variables" rel="noreferrer">`GIT_EDITOR`</a> environment variable: `export GIT_EDITOR=vim`</li>
</ul>

<hr>

If you want to set the editor for Git <em>and also other programs</em>, set the standardized `VISUAL` and `EDITOR` environment variables*:  

```sh
export VISUAL=vim
export EDITOR="$VISUAL"
```

<sub>* Setting both is not necessarily needed, but some programs may not use the more-correct `VISUAL`. See <a href="https://unix.stackexchange.com/questions/4859/visual-vs-editor-whats-the-difference">`VISUAL` vs. `EDITOR`</a>.</sub>  

<hr>

<p><strong>For Sublime Text</strong>:
Add this to the `.gitconfig`. The `--wait` is important. (it allows to type text in sublime and will wait for save/close event.</p>

```sh
[core]
    editor = 'subl' --wait
```

<em>'subl' can be replaced by the full path of the executable but is usually available when correctly installed.</em>  

#### Answer 2 (score 558)
Copy paste this:  

```sh
git config --global core.editor "vim"
```

In case you'd like to know what you're doing. From `man git-commit`:  

<blockquote>
  <h5>ENVIRONMENT AND CONFIGURATION VARIABLES</h2>
  
  The editor used to edit the commit log message will be chosen from the `GIT_EDITOR` environment variable, the `core.editor` configuration variable, the `VISUAL` environment variable, or the `EDITOR` environment variable (in that order).  
</blockquote>

#### Answer 3 (score 175)
On Ubuntu and also Debian (thanks @MichielB) changing the default editor is also possible by running:   

```sh
sudo update-alternatives --config editor
```

Which will prompt the following:  

```sh
There are 4 choices for the alternative editor (providing /usr/bin/editor).

  Selection    Path                Priority   Status
------------------------------------------------------------
  0            /bin/nano            40        auto mode
  1            /bin/ed             -100       manual mode
  2            /bin/nano            40        manual mode
* 3            /usr/bin/vim.basic   30        manual mode
  4            /usr/bin/vim.tiny    10        manual mode

Press enter to keep the current choice[*], or type selection number: 
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 80: How do I make Git ignore file mode (chmod) changes? (score [843774](https://stackoverflow.com/q/1580596) in 2014)

#### Question
I have a project in which I have to change the mode of files with `chmod` to 777 while developing, but which should not change in the main repo.   

Git picks up on `chmod -R 777 .` and marks all files as changed. Is there a way to make Git ignore mode changes that have been made to files?  

#### Answer accepted (score 3586)
Try:  

```sh
git config core.fileMode false
```

From <a href="https://www.kernel.org/pub/software/scm/git/docs/git-config.html" rel="noreferrer">git-config(1)</a>:  

<blockquote>
```sh
core.fileMode
    Tells Git if the executable bit of files in the working tree
    is to be honored.

    Some filesystems lose the executable bit when a file that is
    marked as executable is checked out, or checks out a
    non-executable file with executable bit on. git-clone(1)
    or git-init(1) probe the filesystem to see if it handles the 
    executable bit correctly and this variable is automatically
    set as necessary.

    A repository, however, may be on a filesystem that handles
    the filemode correctly, and this variable is set to true when
    created, but later may be made accessible from another
    environment that loses the filemode (e.g. exporting ext4
    via CIFS mount, visiting a Cygwin created repository with Git
    for Windows or Eclipse). In such a case it may be necessary
    to set this variable to false. See git-update-index(1).

    The default is true (when core.filemode is not specified
    in the config file).
```
</blockquote>

The `-c` flag can be used to set this option for one-off commands:  

```sh
git -c core.fileMode=false diff
```

And the `--global` flag will make it be the default behavior for the logged in user.  

```sh
git config --global core.fileMode false
```

<p>Changes of the global setting won't be applied to existing repositories. 
  Additionally, `git clone` and `git init` explicitly set `core.fileMode` to `true` in the repo config as discussed in <a href="https://stackoverflow.com/questions/30392318/git-global-core-filemode-false-overridden-locally-on-clone">Git global core.fileMode false overridden locally on clone</a></p>

<h5>Warning</h2>

`core.fileMode` is not the best practice and should be used carefully. This setting only covers the executable bit of mode and never the read/write bits. In many cases you think you need this setting because you did something like `chmod -R 777`, making all your files executable. But in most projects <strong>most files don't need and should not be executable for security reasons</strong>.  

The proper way to solve this kind of situation is to handle folder and file permission separately, with something like:  

```sh
find . -type d -exec chmod a+rwx {} \; # Make folders traversable and read/write
find . -type f -exec chmod a+rw {} \;  # Make files read/write
```

If you do that, you'll never need to use `core.fileMode`, except in very rare environment.  

#### Answer 2 (score 265)
undo mode change in working tree:  

```sh
git diff --summary | grep --color 'mode change 100755 => 100644' | cut -d' ' -f7- | xargs -d'\n' chmod +x
git diff --summary | grep --color 'mode change 100644 => 100755' | cut -d' ' -f7- | xargs -d'\n' chmod -x
```

Or in mingw-git  

```sh
git diff --summary | grep  'mode change 100755 => 100644' | cut -d' ' -f7- | xargs -e'\n' chmod +x
git diff --summary | grep  'mode change 100644 => 100755' | cut -d' ' -f7- | xargs -e'\n' chmod -x
```

#### Answer 3 (score 128)
If you want to set this option for all of your repos, use the `--global` option.  

```sh
git config --global core.filemode false
```

If this does not work you are probably using a newer version of git so try the `--add` option.  

```sh
git config --add --global core.filemode false
```

If you run it without the --global option and your working directory is not a repo, you'll get  

```sh
error: could not lock config file .git/config: No such file or directory
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 81: How to change the commit author for one specific commit? (score [841438](https://stackoverflow.com/q/3042437) in 2018)

#### Question
I want to change the author of one specific commit in the history. It's not the last commit.  

I know about this question - <a href="https://stackoverflow.com/questions/750172/how-do-i-change-the-author-of-a-commit-in-git">How do I change the author of a commit in git?</a>  

But I am thinking about something, where I identify the commit by hash or short-hash.  

#### Answer accepted (score 3184)
Interactive rebase off of a point earlier in the history than the commit you need to modify (`git rebase -i &lt;earliercommit&gt;`). In the list of commits being rebased, change the text from `pick` to `edit` next to the hash of the one you want to modify. Then when git prompts you to change the commit, use this:  

```sh
git commit --amend --author="Author Name <email@address.com>"
```

<hr>

For example, if your commit history is `A-B-C-D-E-F` with `F` as `HEAD`, and you want to change the author of `C` and `D`, then you would...  

<ol>
<li>Specify `git rebase -i B` (<a href="https://help.github.com/articles/about-git-rebase/#an-example-of-using-git-rebase" rel="noreferrer">here is an example of what you will see after executing the `git rebase -i B` command</a>)

<ul>
<li>if you need to edit `A`, use `git rebase -i --root`</li>
</ul></li>
<li>change the lines for both `C` and `D` from `pick` to `edit`</li>
<li>Once the rebase started, it would first pause at `C`</li>
<li>You would `git commit --amend --author="Author Name &lt;email@address.com&gt;"`</li>
<li>Then `git rebase --continue`</li>
<li>It would pause again at `D`</li>
<li>Then you would `git commit --amend --author="Author Name &lt;email@address.com&gt;"` again</li>
<li>`git rebase --continue`</li>
<li>The rebase would complete.</li>
<li>Use `git push -f` to update your origin with the updated commits.</li>
</ol>

#### Answer 2 (score 443)
The <a href="https://stackoverflow.com/a/3042512/3357935">accepted answer</a> to this question is a wonderfully clever use of interactive rebase, but it unfortunately exhibits conflicts if the commit we are trying to change the author of used to be on a branch which was subsequently merged in. More generally, it does not work when handling messy histories.  

Since I am apprehensive about running scripts which depend on setting and unsetting environment variables to rewrite git history, I am writing a new answer based on <a href="https://help.github.com/articles/changing-author-info/" rel="noreferrer">this post</a> which is similar to <a href="https://stackoverflow.com/a/3404304/391161">this answer</a> but is more complete.  

<p>The following is tested and working, unlike the linked answer.
Assume for clarity of exposition that `03f482d6` is the commit whose author we are trying to replace, and `42627abe` is the commit with the new author. </p>

<ol>
<li><p>Checkout the commit we are trying to modify. </p>

```sh
git checkout 03f482d6
```</li>
<li><p>Make the author change.</p>

```sh
git commit --amend --author "New Author Name <New Author Email>"
```

Now we have a new commit with hash assumed to be `42627abe`.  </li>
<li><p>Checkout the original branch.</p></li>
<li><p>Replace the old commit with the new one locally.</p>

```sh
git replace 03f482d6 42627abe
```</li>
<li><p>Rewrite all future commits based on the replacement.</p>

```sh
git filter-branch -- --all
```</li>
<li><p>Remove the replacement for cleanliness.</p>

```sh
git replace -d 03f482d6
```</li>
<li><p>Push the new history (only use --force if the below fails, and only after sanity checking with `git log` and/or `git diff`).</p>

```sh
git push --force-with-lease
```</li>
</ol>

Instead of 4-6 you can just rebase onto new commit:  

```sh
git rebase -i 42627abe
```

#### Answer 3 (score 196)
Github documentation contains <a href="https://help.github.com/articles/changing-author-info/" rel="noreferrer">a script that replaces the committer info for all commits in a branch</a>.  

```sh
#!/bin/sh

git filter-branch --env-filter '

OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 82: How can I remove a commit on GitHub? (score [840447](https://stackoverflow.com/q/448919) in 2018)

#### Question
I "accidentally" pushed a commit to GitHub.  

Is it possible to remove this commit?  

I want to revert my GitHub repository as it was before this commit.  

#### Answer accepted (score 1145)
<blockquote>
  <strong>Note:</strong> please see alternative to `git rebase -i` in the comments below—  
  
  `git reset --soft HEAD^`  
</blockquote>

First, remove the commit on your local repository. You can do this using `git rebase -i`. For example, if it's your last commit, you can do `git rebase -i HEAD~2` and delete the second line within the editor window that pops up.   

Then, force push to GitHub by using `git push origin +branchName --force`  

See <a href="http://www-cs-students.stanford.edu/~blynn/gitmagic/ch05.html#_8230_and_then_some" rel="noreferrer">Git Magic Chapter 5: Lessons of History - And Then Some</a> for more information (i.e. if you want to remove older commits).  

Oh, and if your working tree is dirty, you have to do a `git stash` first, and then a `git stash apply` after.  

#### Answer 2 (score 918)
```sh
git push -f origin HEAD^:master
```

That should "undo" the push.  

#### Answer 3 (score 330)
For an easy revert if it's just a mistake (perhaps you forked a repo, then ended up pushing to the original instead of to a new one) here's another possibility:  

```sh
git reset --hard 71c27777543ccfcb0376dcdd8f6777df055ef479
```

Obviously swap in that number for the number of the commit you want to return to.   

Everything since then will be deleted once you push again. To do that, the next step would be:  

```sh
git push --force
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 83: How do I remove a submodule? (score [815253](https://stackoverflow.com/q/1260748) in 2018)

#### Question
How do I remove a Git submodule?  

<p>By the way, is there a reason I can't simply do 
`git submodule rm whatever` ?</p>

#### Answer accepted (score 2039)
Since <a href="https://github.com/git/git/blob/v1.8.3-rc0/Documentation/RelNotes/1.8.3.txt#L135-L137" rel="noreferrer">git1.8.3 (April 22d, 2013)</a>:  

<blockquote>
  <p>There was no Porcelain way to say "I no longer am interested in this submodule", once you express your interest in a submodule with "`submodule init`".<br>
  "<strong>`submodule deinit`</strong>" is the way to do so. </p>
</blockquote>

The deletion process also uses `git rm` (since git1.8.5 October 2013).    

<h5>Summary</h2>

The 3-steps removal process would then be:  

```sh
0. mv a/submodule a/submodule_tmp

1. git submodule deinit -f -- a/submodule    
2. rm -rf .git/modules/a/submodule
3. git rm -f a/submodule
# Note: a/submodule (no trailing slash)

# or, if you want to leave it in your working tree and have done step 0
3.   git rm --cached a/submodule
3bis mv a/submodule_tmp a/submodule
```

<h5>Explanation</h2>

`rm -rf`: This is mentioned in <a href="https://stackoverflow.com/users/2753241/daniel-schroeder">Daniel Schroeder</a>'s <a href="https://stackoverflow.com/a/26505847/6309">answer</a>, and summarized by <a href="https://stackoverflow.com/users/246776/eonil">Eonil</a> in <a href="https://stackoverflow.com/questions/1260748/how-do-i-remove-a-git-submodule/16162000?noredirect=1#comment41729982_16162000">the comments</a>:  

<blockquote>
  <p>This leaves `.git/modules/&lt;path-to-submodule&gt;/` unchanged.<br>
  So if you once delete a submodule with this method and re-add them again, it will not be possible because repository already been corrupted.</p>
</blockquote>

<hr>

`git rm`: See <a href="https://github.com/git/git/commit/95c16418f0375e2fc325f32c3d7578fba9cfd7ef" rel="noreferrer">commit 95c16418</a>:  

<blockquote>
  <p>Currently using "`git rm`" on a submodule removes the submodule's work tree from that of the superproject and the gitlink from the index.<br>
  But the submodule's section in `.gitmodules` is left untouched, which is a leftover of the now removed submodule and might irritate users (as opposed to the setting in `.git/config`, this must stay as a reminder that the user showed interest in this submodule so it will be repopulated later when an older commit is checked out).</p>
  
  Let "`git rm`" help the user by not only removing the submodule from the work tree but by also removing the "`submodule.&lt;submodule name&gt;`" section from the `.gitmodules` file and stage both.  
</blockquote>

<hr>

`git submodule deinit`: It stems from <a href="http://git.661346.n2.nabble.com/PATCH-v3-submodule-add-deinit-command-td7576946.html" rel="noreferrer">this patch</a>:  

<blockquote>
  <p>With "`git submodule init`" the user is able to tell git they care about one or more submodules and wants to have it populated on the next call to "`git submodule update`".<br>
  But currently there is no easy way they can tell git they do not care about a submodule anymore and wants to get rid of the local work tree (unless the user knows a lot about submodule internals and removes the "`submodule.$name.url`" setting from `.git/config` together with the work tree himself).</p>
  
  <p>Help those users by providing a '<strong>`deinit`</strong>' command.<br>
  This <strong>removes the whole `submodule.&lt;name&gt;` section from `.git/config` either for the given
  submodule(s)</strong> (or for all those which have been initialized if '`.`' is given).<br>
  Fail if the current work tree contains modifications unless forced.<br>
  Complain when for a submodule given on the command line the url setting can't be found in `.git/config`, but nonetheless don't fail. </p>
</blockquote>

This takes care if the (de)initialization steps (`.git/config` and `.git/modules/xxx`)  

Since git1.8.5, the `git rm` takes <em>also</em> care of the:  

<ul>
<li>'`add`' step which records the url of a submodule in the `.gitmodules` file: it is need to removed for you.</li>
<li>the submodule <strong><a href="https://stackoverflow.com/questions/1992018/git-submodule-update-needed-only-initially/2227598#2227598">special entry</a></strong> (as illustrated by <a href="https://stackoverflow.com/q/16574625/6309">this question</a>): the git rm removes it from the index:<br>
`git rm --cached path_to_submodule` (no trailing slash)<br>
That will remove that directory stored in the index with a special mode "160000", marking it as a submodule root directory.</li>
</ul>

If you forget that last step, and try to add what was a submodule as a regular directory, you would get error message like:  

```sh
git add mysubmodule/file.txt 
Path 'mysubmodule/file.txt' is in submodule 'mysubmodule'
```

<hr>

<p>Note: since Git 2.17 (Q2 2018), git submodule deinit is no longer a shell script.<br>
It is a call to a C function.</p>

<p>See <a href="https://github.com/git/git/commit/2e612731b55f1a83fb5b7f4ecb9391f0cba63cb2" rel="noreferrer">commit 2e61273</a>, <a href="https://github.com/git/git/commit/13424764db3273091d136bd470cf14852255c98c" rel="noreferrer">commit 1342476</a> (14 Jan 2018) by <a href="https://github.com/pratham-pc" rel="noreferrer">Prathamesh Chavan (`pratham-pc`)</a>.<br>
<sup>(Merged by <a href="https://github.com/gitster" rel="noreferrer">Junio C Hamano -- `gitster` --</a> in <a href="https://github.com/git/git/commit/ead8dbe2e14ee9a2a18ccd0ad7bca806e1be0d54" rel="noreferrer">commit ead8dbe</a>, 13 Feb 2018)</sup>  </p>

```sh
git ${wt_prefix:+-C "$wt_prefix"} submodule--helper deinit \
  ${GIT_QUIET:+--quiet} \
  ${prefix:+--prefix "$prefix"} \
  ${force:+--force} \
  ${deinit_all:+--all} "$@"
```

#### Answer 2 (score 3346)
Via the page <em><a href="https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial#Removal" rel="noreferrer">Git Submodule Tutorial</a></em>:  

<strong>To remove a submodule you need to:</strong>  

<ol>
<li>Delete the relevant section from the `.gitmodules` file.</li>
<li>Stage the `.gitmodules` changes:<br/>`git add .gitmodules`</li>
<li>Delete the relevant section from `.git/config`.</li>
<li>Remove the submodule files from the working tree and index:<br/>`git rm --cached path_to_submodule` (no trailing slash).</li>
<li>Remove the submodule's `.git` directory:<br/>`rm -rf .git/modules/path_to_submodule`</li>
<li>Commit the changes:<br/>`git commit -m "Removed submodule &lt;name&gt;"`</li>
<li>Delete the now untracked submodule files:<br/>`rm -rf path_to_submodule`</li>
</ol>

<strong>See also</strong>: <a href="https://stackoverflow.com/a/7646931/5614968">alternative steps below</a>.  

#### Answer 3 (score 425)
Just a note. Since git 1.8.5.2, two commands will do:  

```sh
git rm the_submodule
rm -rf .git/modules/the_submodule
```

As @Mark Cheverton's answer correctly pointed out, if the second line isn't used, even if you removed the submodule for now, the remnant .git/modules/the_submodule folder will prevent the same submodule from being added back or replaced in the future. Also, as @VonC mentioned, `git rm` will do most of the job on a submodule.  

--Update (07/05/2017)--  

Just to clarify, `the_submodule` is the relative path of the submodule inside the project. For example, it's `subdir/my_submodule` if the submodule is inside a subdirectory `subdir`.  

As pointed out correctly in the comments and <a href="https://stackoverflow.com/a/44863971/683218">other answers</a>, the two commands (although functionally sufficient to remove a submodule), do leave a trace in the `[submodule "the_submodule"]` section of `.git/config` (as of July 2017), which can be removed using a third command:  

```sh
git config -f .git/config --remove-section submodule.the_submodule 2> /dev/null
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 84: You have not concluded your merge (MERGE_HEAD exists) (score [804474](https://stackoverflow.com/q/11646107) in 2016)

#### Question
I made a branch called 'f' and did a checkout to master. When I tried the `git pull` command I got this message:  

```sh
You have not concluded your merge (MERGE_HEAD exists).
Please, commit your changes before you can merge.
```

When I try the `git status`, it gave me the following:  

```sh
On branch master
# Your branch and 'origin/master' have diverged,
# and have 1 and 13 different commit(s) each, respectively.
#
# Changes to be committed:
#
#   modified:   app/assets/images/backward.png
#   modified:   app/assets/images/forward.png
#   new file:   app/assets/images/index_background.jpg
#   new file:   app/assets/images/loading.gif
#   modified:   app/assets/images/pause.png
#   modified:   app/assets/images/play.png
#   new file:   app/assets/javascripts/jquery-ui-bootstrap.js
#   new file:   app/assets/stylesheets/jquery-ui-bootstrap.css
#   modified:   app/controllers/friends_controller.rb
#   modified:   app/controllers/plays_controller.rb
#   modified:   app/mailers/invite_friends_mailer.rb
#   modified:   app/mailers/send_plays_mailer.rb
#   modified:   app/mailers/shot_chart_mailer.rb
#   modified:   app/views/friends/show_plays.html.erb
#   modified:   app/views/layouts/application.html.erb
#   modified:   app/views/plays/_inbox_table.html.erb
#   modified:   app/views/plays/show.html.erb
#   modified:   app/views/welcome/contact_form.html.erb
#   modified:   app/views/welcome/index.html.erb
#   modified:   log/development.log
#   modified:   log/restclient.log
#   new file:   tmp/cache/assets/C1A/C00/sprockets%2Fb7901e0813446f810e560158a1a97066
#   modified:   tmp/cache/assets/C64/930/sprockets%2F65aa1510292214f4fd1342280d521e4c
#   new file:   tmp/cache/assets/C73/C40/sprockets%2F96912377b93498914dd04bc69fa98585
#   new file:   tmp/cache/assets/CA9/090/sprockets%2Fa71992733a432421e67e03ff1bd441d8
#   new file:   tmp/cache/assets/CCD/7E0/sprockets%2F47125c2ebd0e8b29b6511b7b961152a1
#   modified:   tmp/cache/assets/CD5/DD0/sprockets%2F59d317902de6e0f68689899259caff26
#   modified:   tmp/cache/assets/CE3/080/sprockets%2F5c3b516e854760f14eda2395c4ff2581
#   new file:   tmp/cache/assets/CED/B20/sprockets%2F423772fde44ab6f6f861639ee71444c4
#   new file:   tmp/cache/assets/D0C/E10/sprockets%2F8d1f4b30c6be13017565fe1b697156ce
#   new file:   tmp/cache/assets/D12/290/sprockets%2F93ae21f3cdd5e24444ae4651913fd875
#   new file:   tmp/cache/assets/D13/FC0/sprockets%2F57aad34b9d3c9e225205237dac9b1999
#   new file:   tmp/cache/assets/D1D/DE0/sprockets%2F5840ff4283f6545f472be8e10ce67bb8
#   new file:   tmp/cache/assets/D23/BD0/sprockets%2F439d5dedcc8c54560881edb9f0456819
#   new file:   tmp/cache/assets/D24/570/sprockets%2Fb449db428fc674796e18b7a419924afe
#   new file:   tmp/cache/assets/D28/480/sprockets%2F9aeec798a04544e478806ffe57e66a51
#   new file:   tmp/cache/assets/D3A/ED0/sprockets%2Fcd959cbf710b366c145747eb3c062bb4
#   new file:   tmp/cache/assets/D3C/060/sprockets%2F363ac7c9208d3bb5d7047f11c159d7ce
#   new file:   tmp/cache/assets/D48/D00/sprockets%2Fe23c97b8996e7b5567a3080c285aaccb
#   new file:   tmp/cache/assets/D6A/900/sprockets%2Fa5cece9476b21aa4d5f46911ca96c450
#   new file:   tmp/cache/assets/D6C/510/sprockets%2Fb086a020de3c258cb1c67dfc9c67d546
#   new file:   tmp/cache/assets/D70/F30/sprockets%2Facf9a6348722adf1ee7abbb695603078
#   new file:   tmp/cache/assets/DA3/4A0/sprockets%2F69c26d0a9ca8ce383e20897cefe05aa4
#   new file:   tmp/cache/assets/DA7/2F0/sprockets%2F61da396fb86c5ecd844a2d83ac759b4b
#   new file:   tmp/cache/assets/DB9/C80/sprockets%2F876fbfb9685b2b8ea476fa3c67ae498b
#   new file:   tmp/cache/assets/DBD/7A0/sprockets%2F3640ea84a1dfaf6f91a01d1d6fbe223d
#   new file:   tmp/cache/assets/DC1/8D0/sprockets%2Fe5ee1f1cfba2144ec00b1dcd6773e691
#   new file:   tmp/cache/assets/DCC/E60/sprockets%2Fd6a95f601456c93ff9a1bb70dea3dfc0
#   new file:   tmp/cache/assets/DF1/130/sprockets%2Fcda4825bb42c91e2d1f1ea7b2b958bda
#   new file:   tmp/cache/assets/E23/DE0/sprockets%2Fb1acc25c28cd1fabafbec99d169163d3
#   new file:   tmp/cache/assets/E23/FD0/sprockets%2Fea3dbcd1f341008ef8be67b1ccc5a9c5
#   modified:   tmp/cache/assets/E4E/AD0/sprockets%2Fb930f45cfe7c6a8d0efcada3013cc4bc
#   new file:   tmp/cache/assets/E63/7D0/sprockets%2F77de495a665c3ebcb47befecd07baae6
#   modified:   tmp/pids/server.pid
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#   Coachbase/
#   log/development.log.orig
#   log/restclient.log.orig
```

What should I do?  

#### Answer accepted (score 1686)
OK. The problem is your previous pull failed to merge automatically and went to conflict state. And the conflict wasn't resolved properly before the next pull.   

<ol>
<li><p>Undo the merge and pull again.</p>

To undo a merge:  

`git merge --abort`  [Since git version 1.7.4]   

`git reset --merge`  [prior git versions]  </li>
<li><p>Resolve the conflict.</p></li>
<li><p><strong>Don't forget to add and commit the merge.</strong></p></li>
<li><p>`git pull` now should work fine.</p></li>
</ol>

#### Answer 2 (score 84)
If you are sure that you already resolved all merge conflicts:  

```sh
rm -rf .git/MERGE*
```

And the error will disappear.  

#### Answer 3 (score 63)
I think it's worth mentioning that there are numerous scenarios in which the message `You have not concluded your merge (MERGE_HEAD exists)` could occur, because many people have probably arrived at this page after searching for said message. The resolution will depend on how you got there.  

`git status` is always a useful starting point.  

If you've already merged the contents to your satisfaction and are still getting this message, it could be as simple as doing  

```sh
git add file
git commit
```

<p>But again, it really depends on the situation. It's a good idea to understand the basics before attempting anything (same link Terence posted):
<a href="http://git-scm.com/book/en/Git-Branching-Basic-Branching-and-Merging#Basic-Merge-Conflicts" rel="noreferrer">Git - Basic Merge Conflicts</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 85: Git: cannot checkout branch - error: pathspec '...' did not match any file(s) known to git (score [794843](https://stackoverflow.com/q/5989592) in 2017)

#### Question
I'm not sure why I'm <strong>unable to checkout</strong> a branch that I had worked on earlier. See the commands below (note: `co` is an alias for `checkout`):  

```sh
ramon@ramon-desktop:~/source/unstilted$ git branch -a
* develop
  feature/datts_right
  feature/user_controlled_menu
  feature/user_controlled_site_layouts
  master
  remotes/origin/HEAD -> origin/master
  remotes/origin/develop
  remotes/origin/feature/datts_right
  remotes/origin/master
ramon@ramon-desktop:~/source/unstilted$ git co feature/user_controlled_site_layouts 
error: pathspec 'feature/user_controlled_site_layouts' did not match any file(s) known to git.
```

I'm not sure what it means, and I can't seem to find anything I can understand on Google.   

<strong>How do I checkout that branch, and what may I have done to break this?</strong>  

<strong>UPDATE</strong>:  

I found <a href="https://stackoverflow.com/questions/4181861/git-error-src-refspec-master-does-not-match-any">this post</a>, and running `git show-ref` gives me:  

```sh
97e2cb33914e763ff92bbe38531d3fd02408da46 refs/heads/develop
c438c439c66da3f2356d2449505c073549b221c1 refs/heads/feature/datts_right
11a90dae8897ceed318700b9af3019f4b4dceb1e refs/heads/feature/user_controlled_menu
c889b37a5ee690986935c9c74b71999e2cf3c6d7 refs/heads/master
c889b37a5ee690986935c9c74b71999e2cf3c6d7 refs/remotes/origin/HEAD
e7c17eb40610505eea4e6687e4572191216ad4c6 refs/remotes/origin/develop
c438c439c66da3f2356d2449505c073549b221c1 refs/remotes/origin/feature/datts_right
c889b37a5ee690986935c9c74b71999e2cf3c6d7 refs/remotes/origin/master
23768aa5425cbf29d10ff24274adad42d90d15cc refs/stash
e572cf91e95da03f04a5e51820f58a7306ce01de refs/tags/menu_shows_published_only
429ebaa895d9d41d835a34da72676caa75902e3d refs/tags/slow_dev
```

<strong>UPDATE on `.git` directory</strong> (`user_controlled_site_layouts` is in the `refs/heads/feature folder`):  

```sh
$ ls .git/refs/heads/feature/
datts_right  user_controlled_menu  user_controlled_site_layouts
$ cat .git/refs/heads/feature/user_controlled_site_layouts
3af84fcf1508c44013844dcd0998a14e61455034
```

<strong>UPDATE on `git show 3af84fcf1508c44013844dcd0998a14e61455034`</strong>  

```sh
$ git show 3af84fcf1508c44013844dcd0998a14e61455034
commit 3af84fcf1508c44013844dcd0998a14e61455034
Author: Ramon Tayag <xxx@xxxxx.xxx>
Date:   Thu May 12 19:00:03 2011 +0800

    Removed site layouts migration

diff --git a/db/schema.rb b/db/schema.rb
index 1218fc8..2040b9f 100755
--- a/db/schema.rb
+++ b/db/schema.rb
@@ -10,7 +10,7 @@
 #
 # It's strongly recommended to check this file into your version control system.

-ActiveRecord::Schema.define(:version => 20110511012647) do
+ActiveRecord::Schema.define(:version => 20110503040056) do

   create_table "attachments", :force => true do |t|
     t.string   "name"
@@ -205,15 +205,6 @@ ActiveRecord::Schema.define(:version => 20110511012647) do
     t.integer  "old_id"
   end

-  create_table "site_layouts", :force => true do |t|
-    t.string   "name"
-    t.text     "description"
-    t.text     "content"
-    t.integer  "site_id"
-    t.datetime "created_at"
-    t.datetime "updated_at"
-  end
-
   create_table "site_styles", :force => true do |t|
     t.text     "published"
     t.datetime "created_at"
```

#### Answer 2 (score 828)
Try `git fetch` so that your local repository gets all the new info from github. It just takes the information about new branches and no actual code. After that the `git checkout` should work fine.  

#### Answer 3 (score 316)
I was getting this error when I tried to checkout new branch:  

<blockquote>
  error: pathspec 'BRANCH-NAME' did not match any file(s) known to git.  
</blockquote>

When I tried `git checkout origin/&lt;BRANCH-NAME&gt;`, I got the detached HEAD:   

<blockquote>
  (detached from origin/)  
</blockquote>

<strong>Finally, I did the following to resolve the issue</strong>:  

```sh
git remote update
git fetch 
git checkout --track origin/<BRANCH-NAME>
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 86: How to retrieve the hash for the current commit in Git? (score [792346](https://stackoverflow.com/q/949314) in 2017)

#### Question
I would like to retain (for now) the ability to link Git changesets to workitems stored in TFS.  

I already wrote a tool (using a hook from Git) in which I can inject workitemidentifiers into the message of a Git changeset.   

However, I would also like to store the identifier of the Git commit (the hash) into a custom TFS workitem field. This way I can examine a workitem in TFS and see what Git changesets are associated with the workitem.  

How can I easily retrieve the hash from the current commit from Git?  

#### Answer accepted (score 2565)
To turn arbitrary extended object reference into SHA-1, use simply <strong><a href="http://git-scm.com/docs/git-rev-parse" rel="noreferrer" title="git-rev-parse - Pick out and massage parameters">git-rev-parse</a></strong>, for example  

```sh
git rev-parse HEAD
```

or  

```sh
git rev-parse --verify HEAD
```

<strong><em>Sidenote:</em></strong> If you want to turn <em>references</em> (<strong>branches</strong> and <strong>tags</strong>) into SHA-1, there is `git show-ref` and `git for-each-ref`.  

#### Answer 2 (score 396)
If you only want the shortened hash:  

```sh
git log --pretty=format:'%h' -n 1
```

Further, using %H is another way to get the long hash.  

#### Answer 3 (score 140)
Another one, using git log:  

```sh
git log -1 --format="%H"
```

It's very similar to the of @outofculture though a bit shorter.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 87: How to change the author and committer name and e-mail of multiple commits in Git? (score [789248](https://stackoverflow.com/q/750172) in 2018)

#### Question
I was writing a simple script in the school computer, and committing the changes to Git (in a repo that was in my pendrive, cloned from my computer at home). After several commits I realized I was committing stuff as the root user.  

Is there any way to change the author of these commits to my name?  

#### Answer accepted (score 1075)
Changing the author (or committer) would require re-writing all of the history.  If you're okay with that and think it's worth it then you should check out <a href="http://schacon.github.com/git/git-filter-branch.html" rel="noreferrer">git filter-branch</a>.  The man page includes several examples to get you started.  Also note that you can use environment variables to change the name of the author, committer, dates, etc. -- see the "Environment Variables" section of the <a href="http://schacon.github.com/git/git.html" rel="noreferrer">git man page</a>.  

Specifically, you can fix all the wrong author names and emails <strong>for all branches and tags</strong> with this command (source: <a href="https://help.github.com/articles/changing-author-info/" rel="noreferrer">GitHub help</a>):  

```sh
#!/bin/sh

git filter-branch --env-filter '
OLD_EMAIL="your-old-email@example.com"
CORRECT_NAME="Your Correct Name"
CORRECT_EMAIL="your-correct-email@example.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

#### Answer 2 (score 1530)
<h5>Using Interactive Rebase</h3>

You could do  

```sh
git rebase -i -p <some HEAD before all of your bad commits>
```

Then mark all of your bad commits as "edit" in the rebase file. If you also want to change your first commit, you have to manually add it as first line in the rebase file (follow the format of the other lines). Then, when git asks you to amend each commit, do   

```sh
 git commit --amend --author "New Author Name <email@address.com>" 
```

edit or just close the editor that opens, and then do  

```sh
git rebase --continue
```

to continue the rebase.  

<p>You could skip opening the editor altogether here by appending `--no-edit`
so that the command will be:</p>

```sh
git commit --amend --author "New Author Name <email@address.com>" --no-edit && \
git rebase --continue
```

<h5>Single Commit</h3>

As some of the commenters have noted, if you just want to change the most recent commit, the rebase command is not necessary. Just do   

```sh
 git commit --amend --author "New Author Name <email@address.com>"
```

This will change the author to the name specified, but the committer will be set to your configured user in `git config user.name` and `git config user.email`. If you want to set the committer to something you specify, this will set both the author and the committer:  

```sh
 git -c user.name="New Author Name" -c user.email=email@address.com commit --amend --reset-author
```

<h5>Note on Merge Commits</h3>

There was a slight flaw in my original response. If there are any merge commits between the current `HEAD` and your `&lt;some HEAD before all your bad commits&gt;`, then `git rebase` will flatten them (and by the way, if you use GitHub pull requests, there are going to be a ton of merge commits in your history). This can very often lead to very different history (as duplicate changes may be "rebased out"), and in the worst case, it can lead to `git rebase` asking you to resolve difficult merge conflicts (which were likely already resolved in the merge commits). The solution is to use the `-p` flag to `git rebase`, which will preserve the merge structure of your history. The manpage for `git rebase` warns that using `-p` and `-i` can lead to issues, but in the `BUGS` section it says "Editing commits and rewording their commit messages should work fine."  

I've added `-p` to the above command. For the case where you're just changing the most recent commit, this is not an issue.  

#### Answer 3 (score 582)
You can also do:  

```sh
git filter-branch --commit-filter '
        if [ "$GIT_COMMITTER_NAME" = "<Old Name>" ];
        then
                GIT_COMMITTER_NAME="<New Name>";
                GIT_AUTHOR_NAME="<New Name>";
                GIT_COMMITTER_EMAIL="<New Email>";
                GIT_AUTHOR_EMAIL="<New Email>";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi' HEAD
```

Note, if you are using this command in the Windows command prompt, then you need to use `"` instead of `'`:  

```sh
git filter-branch --commit-filter "
        if [ "$GIT_COMMITTER_NAME" = "<Old Name>" ];
        then
                GIT_COMMITTER_NAME="<New Name>";
                GIT_AUTHOR_NAME="<New Name>";
                GIT_COMMITTER_EMAIL="<New Email>";
                GIT_AUTHOR_EMAIL="<New Email>";
                git commit-tree "$@";
        else
                git commit-tree "$@";
        fi" HEAD
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 88: Receiving "fatal: Not a git repository" when attempting to remote add a Git repo (score [783501](https://stackoverflow.com/q/4630704) in 2014)

#### Question
I am introducing myself to Git by following this tutorial:  

<ul>
<li><a href="http://hayley.ws/2010/12/04/getting-jekyll-running.html" rel="noreferrer">getting jekyll running on nearlyfreespeech.net</a></li>
</ul>

Everything works fine up until the part where the repo is added to my local machine:  

```sh
git remote add nfsn ssh://USERNAME@NFSNSERVER/home/private/git/REPONAME.git
```

(After replacing USERNAME, NFSNSERVER, and REPOAME with the correct names) I receive the error:  

```sh
fatal: Not a git repository (or any of the parent directories): .git
```

Can you help me get past this step?  

#### Answer accepted (score 835)
Did you init a local Git repository, into which this remote is supposed to be added?  

Does your local directory have a `.git` folder?  

Try `git init`.  

#### Answer 2 (score 79)
You'll get this error if you try to use a Git command when your current working directory is not within a Git repository. That is because, by default, Git will look for a `.git` repository directory (inside of the project root?), as pointed out by <a href="https://stackoverflow.com/a/24076407/456814">my answer to "Git won't show log unless I am in the project directory"</a>:  

<blockquote>
  <p>According to the <a href="https://www.kernel.org/pub/software/scm/git/docs/git.html" rel="noreferrer">official Linux Kernel Git documentation</a>,
  `GIT_DIR` is [an environment variable] set to look for a `.git` directory (in the current
  working directory?) by default:</p>
  
  <blockquote>
    <p>If the `GIT_DIR` environment variable is set then it specifies a path to use instead of the default `.git` for the base of the
    repository.</p>
  </blockquote>
</blockquote>

You'll either need to `cd` into the repository/working copy, or you didn't initialize or clone a repository in the first place, in which case you need to initialize a repo in the directory where you want to place the repo:  

```sh
git init
```

or clone a repository  

```sh
git clone <remote-url>
cd <repository>
```

#### Answer 3 (score 24)
My problem was that for some hiccups with my OS any command on my local repository ended with "fatal: Not a git repository (or any of the parent directories): .git", with fsck command included.  

The problem was <strong>empty HEAD file</strong>.  

I was able to find actual branch name I've worked on in .git/refs/heads and then I did this:  

```sh
echo 'ref: refs/heads/ML_#94_FILTER_TYPES_AND_SPECIAL_CHARS' > .git/HEAD
```

It worked.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 89: Cannot push to GitHub - keeps saying need merge (score [779252](https://stackoverflow.com/q/10298291) in 2016)

#### Question
I'm new to <a href="http://en.wikipedia.org/wiki/GitHub">GitHub</a>. Today I met some issue when I was trying to push my code to GitHub.  

```sh
Pushing to git@github.com:519ebayproject/519ebayproject.git
To git@github.com:519ebayproject/519ebayproject.git
 ! [rejected]        master -> master (non-fast-forward)
error: failed to push some refs to 'git@github.com:519ebayproject/519ebayproject.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Merge the remote changes (e.g. 'git pull')
hint: before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

I have not pushed anything in the repository yet, so why do I need to pull something?  

#### Answer 2 (score 742)
<blockquote>
  <h5>This can cause the remote repository to lose commits; use it with care.</h3>
</blockquote>

If you do not wish to merge the remote branch into your local branch (see differences with <a href="https://www.kernel.org/pub/software/scm/git/docs/git-diff.html">git diff</a>), and want to do a force push, use the <a href="https://www.kernel.org/pub/software/scm/git/docs/git-push.html">push command with -f</a>  

```sh
git push -f origin <branch>
```

where `origin` is the name of your <a href="https://www.kernel.org/pub/software/scm/git/docs/git-remote.html">remote</a> repo.  

<blockquote>
  Usually, the command refuses to update a remote ref that is not an ancestor of the local ref used to overwrite it. This flag disables the check. This can cause the remote repository to lose commits; use it with care.  
</blockquote>

#### Answer 3 (score 237)
As the message tells you,  

<blockquote>
  Merge the remote changes (e.g. 'git pull')  
</blockquote>

Use `git pull` to pull the latest changes from the remote repository to your local repository. In this case, pulling changes will require a merge because you have made changes to your local repository.   

I'll provide an example and a picture to explain. Let's assume your last pull from origin/branch was at Commit B. You have completed and committed some work (Commit C). At the same time, someone else has completed their work and pushed it to origin/branch (Commit D). There will need to be a merge between these two branches.  

<blockquote>
```sh
local branch:                         --- Commit C 
                                    /
                                   /
                                  /
origin/branch: Commit A ------ Commit B ---- Commit D
```
</blockquote>

Because you are the one that wants to push, Git forces you to perform the merge. To do so, you must first pull the changes from origin/branch.  

<blockquote>
```sh
local branch:                         --- Commit C -- Commit E
                                    /               /           
                                   /               /             
                                  /               /               
origin/branch: Commit A ------ Commit B ---- Commit D 
```
</blockquote>

After completing the merge, you will now be allowed to fast-forward origin/branch to Commit E by pushing your changes.           

Git requires that you handle merges yourself, because a merge may lead to conflicts.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 90: Download single files from GitHub (score [775547](https://stackoverflow.com/q/4604663) in 2015)

#### Question
I guess most of you, developers, use any <a href="https://en.wikipedia.org/wiki/Revision_control" rel="noreferrer">VCS</a>, and I hope some of you use Git. Do you have any tip or trick how to get a download URL for a single file in a repository?  

I don't want the URL for displaying the raw file; in case of binaries it's for nothing.  

<a href="http://support.github.com/discussions/feature-requests/41-download-single-file" rel="noreferrer">http://support.github.com/discussions/feature-requests/41-download-single-file</a>  

Is it even possible to use GitHub as a "download server"?  

If we decide to switch to Google Code, is the mentioned functionality presented here?  

Or is there any free-of-charge hosting and VCS for open-source projects?  

#### Answer accepted (score 513)
Git does not support downloading parts of the repository. You have to download all of it. But you should be able to do this with GitHub.  

When you view a file it has a link to the "raw" version. The <a href="http://en.wikipedia.org/wiki/Uniform_resource_locator" rel="noreferrer">URL</a> is constructed like so  

```sh
https://raw.githubusercontent.com/user/repository/branch/filename
```

By filling in the blanks in the URL, you can use <a href="http://en.wikipedia.org/wiki/Wget" rel="noreferrer">Wget</a> or <a href="http://en.wikipedia.org/wiki/CURL" rel="noreferrer">cURL</a> (with the `-L` option, see below) or whatever to download a single file. Again, you won't get any of the nice version control features used by Git by doing this.  

<p>Update: I noticed you mention this doesn't work for binary files. You probably shouldn't use binary files in your Git repository, but GitHub has a download section for each repository that you can use to upload files.  If you need more than one binary, you can use a .zip file.
The URL to download an uploaded file is:</p>

```sh
https://github.com/downloads/user/repository/filename
```

Note that the URLs given above, from the links on `github.com`, will redirect to `raw.githubusercontent.com`. You should not directly use the URL given by this HTTP 302 redirect because, per <a href="https://tools.ietf.org/html/rfc2616#section-10.3.3" rel="noreferrer">RFC 2616</a>: "Since the redirection might be altered on occasion, the client SHOULD continue to use the Request-URI for future requests."  

#### Answer 2 (score 490)
<ol>
<li>Go to the file you want to download.</li>
<li>Click it to view the contents within the GitHub UI.</li>
<li>In the top right, <strong>right click</strong> the `Raw` button.</li>
<li>Save as...</li>
</ol>

#### Answer 3 (score 38)
You can use the V3 API to get a raw file like this (you'll need an OAuth token):  

`curl -H 'Authorization: token INSERTACCESSTOKENHERE' -H 'Accept: application/vnd.github.v3.raw' -O -L https://api.github.com/repos/owner/repo/contents/path`  

All of this has to go on one line. The `-O` option saves the file in the current directory. You can use `-o filename` to specify a different filename.  

<p>To get the OAuth token follow the instructions here:
<a href="https://help.github.com/articles/creating-an-access-token-for-command-line-use" rel="noreferrer">https://help.github.com/articles/creating-an-access-token-for-command-line-use</a></p>

<p>I've written this up as a gist as well:
<a href="https://gist.github.com/madrobby/9476733" rel="noreferrer">https://gist.github.com/madrobby/9476733</a></p>

</b> </em> </i> </small> </strong> </sub> </sup>

### 91: How do I show the changes which have been staged? (score [772216](https://stackoverflow.com/q/1587846) in 2018)

#### Question
I staged a few changes to be committed; how can I see the diff of all files which are staged for the next commit? I'm aware of <a href="http://git-scm.com/docs/git-status" rel="noreferrer">git status</a>, but I'd like to see the actual diffs - not just the names of files which are staged.  

I saw that the <a href="http://git-scm.com/docs/git-diff" rel="noreferrer">git-diff(1)</a> man page says  

<blockquote>
  git diff [--options] [--] […]  
  
  This form is to view the changes you made relative to the index (staging area for the next commit). In other words, the differences are what you <em>could</em> tell git to further add to the index but you still haven't. You can stage these changes by using git-add(1).   
</blockquote>

Unfortunately, I can't quite make sense of this. There must be some handy one-liner which I could create an alias for, right?  

#### Answer accepted (score 2456)
It should just be:  

```sh
git diff --cached
```

`--cached` means show the changes in the cache/index (i.e. staged changes) against the current `HEAD`. `--staged` is a synonym for `--cached`.  

`--staged` and `--cached` does not point to `HEAD`, just difference with respect to `HEAD`. If you cherry pick what to commit using `git add --patch` (or `git add -p`), `--staged` will return what is staged.  

#### Answer 2 (score 1541)
A simple graphic makes this clearer:  

<img src="https://i.stack.imgur.com/tVHYO.png" alt="Simple Git diffs">  

<strong>git diff</strong>  

Shows the changes between the working directory and the index. This shows what has been changed, but is not staged for a commit.  

<strong>git diff --cached</strong>  

Shows the changes between the index and the HEAD (which is the last commit on this branch). This shows what has been added to the index and staged for a commit.  

<strong>git diff HEAD</strong>  

Shows all the changes between the working directory and HEAD (which includes changes in the index). This shows all the changes since the last commit, whether or not they have been staged for commit or not.  

<strong>Also</strong>:  

There is a bit more detail on <a href="http://365git.tumblr.com/post/474079664/whats-the-difference-part-1" rel="noreferrer">365Git.</a>  

#### Answer 3 (score 52)
If you'd be interested in a visual side-by-side view, the <a href="http://diffuse.sourceforge.net/" rel="noreferrer">diffuse</a> visual diff tool can do that. It will even show three panes if some but not all changes are staged. In the case of conflicts, there will even be four panes.  

<img src="https://i.stack.imgur.com/8Z6MO.png" alt="Screenshot of diffuse with staged and unstaged edits">  

Invoke it with  

```sh
diffuse -m
```

in your Git working copy.  

If you ask me, the best visual differ I've seen for a decade. Also, it is not specific to Git: It interoperates with a plethora of other VCS, including SVN, Mercurial, Bazaar, ...  

See also: <a href="https://stackoverflow.com/q/13057457/946850">Show both staged &amp; working tree in git diff?</a>  

</b> </em> </i> </small> </strong> </sub> </sup>

### 92: Remove a file from a Git repository without deleting it from the local filesystem (score [768277](https://stackoverflow.com/q/1143796) in 2015)

#### Question
My initial commit contained some log files. I've added `*log` to my `.gitignore`, and now I want to remove the log files from my repository.  

```sh
git rm mylogfile.log
```

will remove a file from the repository, but will also remove it from the local file system.  

How can I remove this file from the repo <strong>without</strong> deleting my local copy of the file?  

#### Answer accepted (score 4086)
From the <a href="https://git-scm.com/docs/git-rm" rel="noreferrer">man file</a>:  

<blockquote>
  When `--cached` is given, the staged content has to match either the tip of the branch or the file on disk, allowing the file to be removed from just the index.  
</blockquote>

So, for a single file:  

```sh
git rm --cached mylogfile.log
```

and for a single directory:  

```sh
git rm --cached -r mydirectory
```

#### Answer 2 (score 265)
To remove an entire folder from the repo (like Resharper files), do this:  

```sh
git rm -r --cached folderName
```

I had committed some resharper files, and did not want those to persist for other project users.  

#### Answer 3 (score 190)
You can also remove files from the repository based on your .gitignore without deleting them from the local file system :  

```sh
git rm --cached `git ls-files -i -X .gitignore`
```

Or, alternatively, on Windows Powershell:  

```sh
git rm --cached $(git ls-files -i -X .gitignore)
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 93: How to "git clone" including submodules? (score [763224](https://stackoverflow.com/q/3796927) in 2019)

#### Question
I'm trying to put a submodule into a repo. The problem is that when I clone the parent repo, the submodule folder is entirely empty.  

Is there any way to make it so that `git clone parent_repo` actually puts data in the submodule folder?  

For example, <a href="http://github.com/cwolves/sequelize/tree/master/lib/" rel="noreferrer">http://github.com/cwolves/sequelize/tree/master/lib/</a>, `nodejs-mysql-native` is pointing at an external git submodule, but when I checkout the `sequelize` project, that folder is empty.  

#### Answer 2 (score 2802)
With version 2.13 of Git and later, `--recurse-submodules` can be used instead of `--recursive`:  

```sh
git clone --recurse-submodules -j8 git://github.com/foo/bar.git
cd bar
```

<sup>Editor’s note: `-j8` is an optional performance optimization that became available in version 2.8, and fetches up to 8 submodules at a time in parallel — see `man git-clone`.</sup>  

With version 1.9 of Git up until version 2.12 (`-j` flag only available in version 2.8+):  

```sh
git clone --recursive -j8 git://github.com/foo/bar.git
cd bar
```

With version 1.6.5 of Git and later, you can use:  

```sh
git clone --recursive git://github.com/foo/bar.git
cd bar
```

For already cloned repos, or older Git versions, use:  

```sh
git clone git://github.com/foo/bar.git
cd bar
git submodule update --init --recursive
```

#### Answer 3 (score 452)
You have to do two things before a submodule will be filled:  

```sh
git submodule init 
git submodule update
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 94: Throw away local commits in Git (score [758261](https://stackoverflow.com/q/5097456) in 2019)

#### Question
Due to some bad cherry-picking, my local Git repository is currently five commits ahead of the origin, and not in a good state. I want to get rid of all these commits and start over again.  

Obviously, deleting my working directory and re-cloning would do it, but downloading everything from GitHub again seems like overkill, and not a good use of my time.  

Maybe `git revert` is what I need, but I don't want to end up <em>10</em> commits ahead of the origin (or even six), even if it does get the code itself back to the right state. I just want to pretend the last half-hour never happened.  

Is there a simple command that will do this? It seems like an obvious use case, but I'm not finding any examples of it.  

<hr>

Note that this question is specifically about <em>commits</em>, <em>not</em> about:  

<ul>
<li>untracked files</li>
<li>unstaged changes</li>
<li>staged, but uncommitted changes</li>
</ul>

#### Answer accepted (score 2206)
<p>If your excess commits are only visible to you, you can just do 
`git reset --hard origin/&lt;branch_name&gt;` 
to move back to where the origin is. This will reset the state of the repository to the previous commit, and it will discard all local changes.</p>

Doing a `git revert` makes <em>new</em> commits to remove <em>old</em> commits in a way that keeps everyone's history sane.  

#### Answer 2 (score 239)
Simply delete your local master branch and recreate it like so:  

```sh
git branch -D master
git checkout origin/master -b master
```

#### Answer 3 (score 176)
Try:  

```sh
git reset --hard <the sha1 hash>
```

to reset your head to wherever you want to be. Use gitk to see which commit you want to be at. You can do reset within gitk as well.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 95: Pushing to Git returning Error Code 403 fatal: HTTP request failed (score [740028](https://stackoverflow.com/q/7438313) in 2014)

#### Question
I was able to clone a copy of this repo over HTTPS authenticated. I've made some commits and want to push back out to the GitHub server. Using Cygwin on Windows 7 x64.  

```sh
C:\cygwin\home\XPherior\Code\lunch_call>git push
Password:
error: The requested URL returned error: 403 while accessing https://MichaelDrog
alis@github.com/derekerdmann/lunch_call.git/info/refs

fatal: HTTP request failed
```

Also set it up with verbose mode. I'm still pretty baffled.  

```sh
C:\cygwin\home\XPherior\Code\lunch_call>set GIT_CURL_VERBOSE=1

C:\cygwin\home\XPherior\Code\lunch_call>git push
Password:
* Couldn't find host github.com in the _netrc file; using defaults
* About to connect() to github.com port 443 (#0)
*   Trying 207.97.227.239... * 0x23cb740 is at send pipe head!
* Connected to github.com (207.97.227.239) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: C:\Program Files (x86)\Git/bin/curl-ca-bundle.crt
  CApath: none
* SSL connection using AES256-SHA
* Server certificate:
*        subject: 2.5.4.15=Private Organization; 1.3.6.1.4.1.311.60.2.1.3=US; 1.
3.6.1.4.1.311.60.2.1.2=California; serialNumber=C3268102; C=US; ST=California; L
=San Francisco; O=GitHub, Inc.; CN=github.com
*        start date: 2011-05-27 00:00:00 GMT
*        expire date: 2013-07-29 12:00:00 GMT
*        subjectAltName: github.com matched
*        issuer: C=US; O=DigiCert Inc; OU=www.digicert.com; CN=DigiCert High Ass
urance EV CA-1
*        SSL certificate verify ok.
> GET /derekerdmann/lunch_call.git/info/refs?service=git-receive-pack HTTP/1.1
User-Agent: git/1.7.4.3282.g844cb
Host: github.com
Accept: */*
Pragma: no-cache

< HTTP/1.1 401 Authorization Required
< Server: nginx/1.0.4
< Date: Thu, 15 Sep 2011 22:44:41 GMT
< Content-Type: text/plain
< Connection: keep-alive
< Content-Length: 55
< WWW-Authenticate: Basic realm="GitHub"
<
* Ignoring the response-body
* Expire cleared
* Connection #0 to host github.com left intact
* Issue another request to this URL: 'https://MichaelDrogalis@github.com/dereker
dmann/lunch_call.git/info/refs?service=git-receive-pack'
* Couldn't find host github.com in the _netrc file; using defaults
* Re-using existing connection! (#0) with host github.com
* Connected to github.com (207.97.227.239) port 443 (#0)
* 0x23cb740 is at send pipe head!
* Server auth using Basic with user 'MichaelDrogalis'
> GET /derekerdmann/lunch_call.git/info/refs?service=git-receive-pack HTTP/1.1
Authorization: Basic XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
User-Agent: git/1.7.4.3282.g844cb
Host: github.com
Accept: */*
Pragma: no-cache

< HTTP/1.1 401 Authorization Required
< Server: nginx/1.0.4
< Date: Thu, 15 Sep 2011 22:44:41 GMT
< Content-Type: text/plain
< Connection: keep-alive
< Content-Length: 55
* Authentication problem. Ignoring this.
< WWW-Authenticate: Basic realm="GitHub"
* The requested URL returned error: 401
* Closing connection #0
* Couldn't find host github.com in the _netrc file; using defaults
* About to connect() to github.com port 443 (#0)
*   Trying 207.97.227.239... * 0x23cb740 is at send pipe head!
* Connected to github.com (207.97.227.239) port 443 (#0)
* successfully set certificate verify locations:
*   CAfile: C:\Program Files (x86)\Git/bin/curl-ca-bundle.crt
  CApath: none
* SSL re-using session ID
* SSL connection using AES256-SHA
* old SSL session ID is stale, removing
* Server certificate:
*        subject: 2.5.4.15=Private Organization; 1.3.6.1.4.1.311.60.2.1.3=US; 1.
3.6.1.4.1.311.60.2.1.2=California; serialNumber=C3268102; C=US; ST=California; L
=San Francisco; O=GitHub, Inc.; CN=github.com
*        start date: 2011-05-27 00:00:00 GMT
*        expire date: 2013-07-29 12:00:00 GMT
*        subjectAltName: github.com matched
*        issuer: C=US; O=DigiCert Inc; OU=www.digicert.com; CN=DigiCert High Ass
urance EV CA-1
*        SSL certificate verify ok.
* Server auth using Basic with user 'MichaelDrogalis'
> GET /derekerdmann/lunch_call.git/info/refs HTTP/1.1
Authorization: Basic xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
User-Agent: git/1.7.4.3282.g844cb
Host: github.com
Accept: */*
Pragma: no-cache

* The requested URL returned error: 403
* Expire cleared
* Closing connection #0
error: The requested URL returned error: 403 while accessing https://MichaelDrog
alis@github.com/derekerdmann/lunch_call.git/info/refs

fatal: HTTP request failed
```

These are the versions of git and curl that I have:  

```sh
C:\Users\XPherior>git --version
git version 1.7.4.msysgit.0

C:\Users\XPherior>curl --version
curl 7.21.7 (amd64-pc-win32) libcurl/7.21.7 OpenSSL/0.9.8r zlib/1.2.5
Protocols: dict file ftp ftps gopher http https imap imaps ldap pop3 pop3s rtsp
smtp smtps telnet tftp
Features: AsynchDNS GSS-Negotiate Largefile NTLM SSL SSPI libz
```

#### Answer accepted (score 809)
I just got the same problem and just figured out what's cause.  

Github seems only supports ssh way to read&amp;write the repo, although https way also displayed 'Read&amp;Write'.  

So you need to change your repo config on your PC to ssh way:  

<ol>
<li>edit `.git/config` file under your repo directory</li>
<li>find `url=`entry under section `[remote "origin"]`</li>
<li>change it from `url=https://MichaelDrogalis@github.com/derekerdmann/lunch_call.git` to    `url=ssh://git@github.com/derekerdmann/lunch_call.git`. that is, change all the texts before `@` symbol to `ssh://git`</li>
<li>Save `config` file and quit. now you could use `git push origin master` to sync your repo on GitHub</li>
</ol>

#### Answer 2 (score 412)
To definitely be able to login using `https` protocol, you should first set your <em>authentication credential</em> to the git <strong>Remote URI</strong>:  

```sh
git remote set-url origin https://yourusername@github.com/user/repo.git
```

Then you'll be asked for a password when trying to `git push`.  

In fact, this is on the http authentication format. You could set a password too:  

```sh
https://youruser:password@github.com/user/repo.git
```

You should be aware that if you do this, your github password will be stored in plaintext in your .git directory, which is obviously undesirable.  

#### Answer 3 (score 110)
One small addition to <a href="https://stackoverflow.com/a/7771927/3472757">Sean's answer</a>.  

Instead of editing `.git/config` file manually, you can use `git remote set-url` command.  

In your case it should be:  

```sh
git remote set-url origin ssh://git@github.com/derekerdmann/lunch_call.git
```

I find it easier and cleaner, than messing around with dot-files.  

<ul>
<li><a href="https://help.github.com/articles/changing-a-remote-s-url" rel="noreferrer">help.github.com: Changing a remote's URL</a></li>
</ul>

</b> </em> </i> </small> </strong> </sub> </sup>

### 96: git error: failed to push some refs to (score [736623](https://stackoverflow.com/q/24114676) in 2015)

#### Question
<p>For some reason, I can't push now, whereas I could do it yesterday.
Maybe I messed up with configs or something.</p>

This is what happens:  

When I use the git push origin master  

<img src="https://i.stack.imgur.com/hOuSj.png" alt="gitbashscr">  

What my working directory and remote repository looks like:  

<img src="https://i.stack.imgur.com/Sz17u.png" alt="enter image description here">  

#### Answer accepted (score 476)
If the GitHub repo has seen new commits pushed to it, while you were working locally, I would advise using:  

```sh
git pull --rebase
git push
```

The full syntax is:  

```sh
git pull --rebase origin master
git push origin master
```

That way, you would replay (the `--rebase` part) your local commits on top of the newly updated `origin/master` (or `origin/yourBranch`: `git pull origin yourBranch`).  

See a more complete example in the <a href="http://chimera.labs.oreilly.com/books/1230000000561/ch06.html#pull-rebase" rel="noreferrer">chapter 6 Pull with rebase</a> of the <a href="http://chimera.labs.oreilly.com/books/1230000000561" rel="noreferrer">Git Pocket Book</a>.  

I would recommend a:  

```sh
git push -u origin master
```

<p>That would establish a tracking relationship between your local master branch and its upstream branch.<br>
After that, any future push for that branch can be done with a simple:</p>

```sh
git push
```

See "<a href="https://stackoverflow.com/a/17096880/6309">Why do I need to explicitly push a new branch?</a>".  

<hr>

Since the OP already <a href="https://stackoverflow.com/a/18589043/6309">reset and redone its commit</a> on top of `origin/master`:  

```sh
git reset --mixed origin/master
git add .
git commit -m "This is a new commit for what I originally planned to be amended"
git push origin master
```

There is no need to `pull --rebase`.  

Note: `git reset --mixed origin/master` can also be written `git reset origin/master`, since the `--mixed` option is the default one when using <a href="http://git-scm.com/docs/git-reset" rel="noreferrer">`git reset`</a>.  

#### Answer 2 (score 66)
Did anyone try:  

```sh
git push -f origin master
```

That should solve the problem.  

<blockquote>
  <strong>EDIT:</strong> Based on @Mehdi ‘s comment below I need to clarify something about `—force pushing`. The git command above works safely only for the first commit. If there were already commits, pull requests or branches in previous, this resets all of it and set it from zero. If so, please refer @VonC ‘s detailed answer for better solution.  
</blockquote>

#### Answer 3 (score 43)
If you just used `git init` and have added your files with `git add .` or something similar and have added your remote branch it might be that you just haven't committed (`git commit -m 'commit message'`) anything locally to push to the remote... I just had this error and that was my issue.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 97: How do I access my SSH public key? (score [735775](https://stackoverflow.com/q/3828164) in 2018)

#### Question
I've just generated my RSA key pair, and I wanted to add that key to GitHub.  

I tried `cd id_rsa.pub` and `id_rsa.pub`, but no luck. How can I access my SSH public key?  

#### Answer accepted (score 836)
`cat ~/.ssh/id_rsa.pub` or `cat ~/.ssh/id_dsa.pub`  

You can list all the public keys you have by doing:  

`$ ls ~/.ssh/*.pub`  

#### Answer 2 (score 172)
Copy the key to your clipboard.  

```sh
$ pbcopy < ~/.ssh/id_rsa.pub
# Copies the contents of the id_rsa.pub file to your clipboard
```

<blockquote>
  <p>Warning: it's important to copy the key exactly without adding
  newlines or whitespace. Thankfully the pbcopy command makes it easy to
  perform this setup perfectly.</p>
</blockquote>

And you can paste it wherever you need.  

To get a better idea of the whole process, check this: <a href="https://help.github.com/articles/generating-ssh-keys" rel="noreferrer"><strong>Generating SSH Keys</strong></a>.  

#### Answer 3 (score 38)
You may try to run the following command to show your RSA fingerprint:  

```sh
ssh-agent sh -c 'ssh-add; ssh-add -l'
```

or public key:  

```sh
ssh-agent sh -c 'ssh-add; ssh-add -L'
```

If you've the message: 'The agent has no identities.', then you've to generate your RSA key by `ssh-keygen` first.  

</b> </em> </i> </small> </strong> </sub> </sup>

### 98: Viewing unpushed Git commits (score [730034](https://stackoverflow.com/q/2016901) in 2019)

#### Question
How can I view any local commits I've made, that haven't yet been pushed to the remote repository? Occasionally, `git status` will print out that my branch is X commits ahead of `origin/master`, but not always.  

Is this a bug with my install of Git, or am I missing something?  

#### Answer accepted (score 1686)
```sh
git log origin/master..HEAD
```

You can also view the diff using the same syntax  

```sh
git diff origin/master..HEAD
```

#### Answer 2 (score 661)
If you want to see all commits on all branches that aren't pushed yet, you might be looking for something like this:  

```sh
git log --branches --not --remotes
```

And if you only want to see the most recent commit on each branch, and the branch names, this:  

```sh
git log --branches --not --remotes --simplify-by-decoration --decorate --oneline
```

#### Answer 3 (score 302)
You can show all commits that you have locally but not upstream with  

```sh
git log @{u}..
```

`@{u}` or `@{upstream}` means the upstream branch of the current branch (see <a href="https://www.kernel.org/pub/software/scm/git/docs/git-rev-parse.html" rel="noreferrer">`git rev-parse --help`</a> or <a href="https://www.kernel.org/pub/software/scm/git/docs/gitrevisions.html" rel="noreferrer">`git help revisions`</a> for details).  

</b> </em> </i> </small> </strong> </sub> </sup>

### 99: How to uncommit my last commit in Git (score [725603](https://stackoverflow.com/q/2845731) in 2018)

#### Question
How can I uncommit my last commit in git?  

Is it  

```sh
git reset --hard HEAD
```

or  

```sh
git reset --hard HEAD^
```

?  

#### Answer 2 (score 1272)
If you aren't totally sure what you mean by "uncommit" and don't know if you want to use `git reset`, please see "<a href="https://stackoverflow.com/q/4114095/119963">Revert to a previous Git commit</a>".  

If you're trying to understand `git reset` better, please see "<a href="https://stackoverflow.com/questions/2530060/can-you-explain-what-git-reset-does-in-plain-english">Can you explain what "git reset" does in plain English?</a>".  

<hr>

If you know you want to use `git reset`, it still depends what you mean by "uncommit". If all you want to do is undo the act of committing, leaving everything else intact, use:  

```sh
git reset --soft HEAD^
```

If you want to undo the act of committing and everything you'd staged, but leave the work tree (your files intact):  

```sh
git reset HEAD^
```

And if you actually want to <em>completely</em> undo it, <strong><em>throwing away all uncommitted changes, resetting everything to the previous commit</em></strong> (as the original question asked):  

```sh
git reset --hard HEAD^
```

<hr>

The original question also asked it's `HEAD^` not `HEAD`. `HEAD` refers to the current commit - generally, the tip of the currently checked-out branch. The `^` is a notation which can be attached to <em>any</em> commit specifier, and means "the commit before". So, `HEAD^` is the commit before the current one, just as `master^` is the commit before the tip of the master branch.  

Here's the portion of the <a href="http://linux.die.net/man/1/git-rev-parse" rel="noreferrer">git-rev-parse documentation</a> describing all of the ways to specify commits (`^` is just a basic one among many).  

#### Answer 3 (score 291)
To keep the changes from the commit you want to undo  

```sh
git reset --soft HEAD^
```

To destroy the changes from the commit you want to undo  

```sh
git reset --hard HEAD^
```

You can also say  

```sh
git reset --soft HEAD~2
```

to go back 2 commits.  

Edit: As charsi mentioned, if you are on Windows you will need to put HEAD or commit hash in quotes.  

```sh
git reset --soft "HEAD^"
git reset --soft "asdf"
```

</b> </em> </i> </small> </strong> </sub> </sup>

### 100: Stash only one file out of multiple files that have changed with Git? (score [720799](https://stackoverflow.com/q/3040833) in 2019)

#### Question
How can I stash only one of multiple changed files on my branch?  

#### Answer accepted (score 1315)
<strong>Update</strong>: the following answer is for git before git 2.13. For git 2.13 and over, check out <a href="https://stackoverflow.com/a/3041055">another answer further down</a>.  

<hr>

<strong>Warning</strong>  

As noted in the comments, this puts everything into the stash, both staged and unstaged. The --keep-index just leaves the index alone after the stash is done. This can cause merge conflicts when you later pop the stash.  

<hr>

This will stash everything that you haven't previously added. Just `git add` the things you want to keep, then run it.  

```sh
git stash --keep-index
```

For example, if you want to split an old commit into more than one changeset, you can use this procedure:  

<ol>
<li>`git rebase -i &lt;last good commit&gt;`</li>
<li>Mark some changes as `edit`.</li>
<li>`git reset HEAD^`</li>
<li>`git add &lt;files you want to keep in this change&gt;`</li>
<li>`git stash --keep-index`</li>
<li>Fix things up as necessary. Don't forget to `git add` any changes.</li>
<li>`git commit`</li>
<li>`git stash pop`</li>
<li>Repeat, from #5, as necessary.</li>
<li>`git rebase --continue`</li>
</ol>

#### Answer 2 (score 2931)
You can also use `git stash save -p "my commit message"`. This way you can select which hunks should be added to stash, whole files can be selected as well.   

You'll be prompted with a few actions for each hunk:  

```sh
   y - stash this hunk
   n - do not stash this hunk
   q - quit; do not stash this hunk or any of the remaining ones
   a - stash this hunk and all later hunks in the file
   d - do not stash this hunk or any of the later hunks in the file
   g - select a hunk to go to
   / - search for a hunk matching the given regex
   j - leave this hunk undecided, see next undecided hunk
   J - leave this hunk undecided, see next hunk
   k - leave this hunk undecided, see previous undecided hunk
   K - leave this hunk undecided, see previous hunk
   s - split the current hunk into smaller hunks
   e - manually edit the current hunk
   ? - print help
```

#### Answer 3 (score 384)
Since git is fundamentally about managing a all repository <em>content</em> and index (and not one or several files), `git stash` deals, not surprisingly, <del>with the all working directory</del>.  

Actually, since Git 2.13 (Q2 2017), you can stash individual files, with <a href="https://git-scm.com/docs/git-stash#git-stash-push-p--patch-k--no-keep-index-u--include-untracked-a--all-q--quiet-m--messageltmessagegt--ltpathspecgt82308203" rel="noreferrer">`git stash push`</a>:  

```sh
git stash push [--] [<pathspec>...]
```

<blockquote>
  When `pathspec` is given to '`git stash push`', the new stash records the modified states only for the files that match the pathspec  
</blockquote>

See "<a href="https://stackoverflow.com/a/42963606/6309">Stash changes to specific files</a>" for more.  

<a href="https://github.com/git/git/blob/44c3f09fa501ccd83e3362080a99ad4b46cda127/t/t3903-stash.sh#L815-L827" rel="noreferrer">The test case</a> is self-explanatory:  

```sh
test_expect_success 'stash with multiple pathspec arguments' '
    >foo &&
    >bar &&
    >extra &&
    git add foo bar extra &&

    git stash push -- foo bar &&   

    test_path_is_missing bar &&
    test_path_is_missing foo &&
    test_path_is_file extra &&

    git stash pop &&
    test_path_is_file foo &&
    test_path_is_file bar &&
    test_path_is_file extra
```

<hr>

The original answer (below, June 2010) was about manually selecting what you want to stash.    

<a href="https://stackoverflow.com/users/165495/casebash">Casebash</a> comments:  

<blockquote>
  This (the `stash --patch` original solution) is nice, but often I've modified a lot of files so using patch is annoying  
</blockquote>

<p><a href="https://stackoverflow.com/users/146821/bukzor">bukzor</a>'s <a href="https://stackoverflow.com/a/8333163/6309">answer</a> (upvoted, November 2011) suggests a more practical solution, based on<br>
<strong>`git add` + `git stash --keep-index`</strong>.<br>
Go see and upvote his answer, which should be the official one (instead of mine).</p>

About that option, <a href="https://stackoverflow.com/users/88814/chhh">chhh</a> points out an alternative workflow in the comments:  

<blockquote>
  <p>you should "`git reset --soft`" after such a stash to get your clear staging back:<br>
  In order to get to the original state - which is a clear staging area and with only some select un-staged modifications, one could softly reset the index to get (without committing anything like you - bukzor - did).</p>
</blockquote>

<hr>

(Original answer June 2010: manual stash)  

Yet, `git stash save --patch` could allows you to achieve the partial stashing you are after:  

<blockquote>
  <p>With `--patch`, you can interactively select hunks from in the diff between HEAD and the working tree to be stashed.<br>
  The stash entry is constructed such that its index state is the same as the index state of your repository, and its worktree contains only the changes you selected interactively. The selected changes are then rolled back from your worktree.</p>
</blockquote>

However that will save the full index (which may not be what you want since it might include other files already indexed),  and a partial worktree (which could look like the one you want to stash).  

```sh
git stash --patch --no-keep-index
```

might be a better fit.  

<hr>

If `--patch` doesn't work, a manual process might:  

For one or several files, an intermediate solution would be to:  

<ul>
<li>copy them outside the Git repo<br>
(Actually, <a href="https://stackoverflow.com/users/578435/eleotlecram">eleotlecram</a> proposes an <a href="https://stackoverflow.com/a/7569847/6309">interesting alternative</a>)</li>
<li>`git stash`</li>
<li>copy them back</li>
<li>`git stash` # this time, only the files you want are stashed</li>
<li>`git stash pop stash@{1}` # re-apply all your files modifications</li>
<li>`git checkout -- afile` # reset the file to the HEAD content, before any local modifications</li>
</ul>

At the end of that rather cumbersome process, you will have only one or several files stashed.  
</section>

