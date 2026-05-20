# Module 06: Ops Power Tools

Advanced commands that help solve common day-to-day Operations problems.

## 1. Git Stash: The Git "Pause" Button

Imagine you are in the middle of a complex change in an Ansible playbook, but you urgently need to switch branches to fix a production error.
- `git stash`: Saves current changes in a "trunk" and cleans your working directory.
- `git checkout production`: Switch branches freely.
- `git checkout my-work` and `git stash pop`: Recovers changes from the trunk.

## 2. Git Cherry-pick: Surgical Selection

You need a specific commit (e.g., a security fix) that is in an experimental branch, but you don't want to merge the entire branch.
- `git log` (to find the commit hash).
- `git cherry-pick <commit-hash>`.

## 3. Git Rebase: Clean History

Instead of creating "merge commits" that clutter history, rebase places your commits on top of the main branch, as if you had started working today.
- **Caution:** Never rebase branches that have already been pushed to the server and that others are using!

## 4. Git Reset and Revert: Undoing Changes

- `git revert <hash>`: Creates a new commit that undoes the changes of a previous commit (Safe, maintains history).
- `git reset --hard <hash>`: Erases everything that happened after that commit (Dangerous, use only locally).

## Practical Exercise

1.  Make any change to a file.
2.  Use `git stash` and verify that the change disappeared (`cat` the file).
3.  Use `git stash list`.
4.  Use `git stash pop` and see the change return.
5.  Create a commit, then use `git reset --soft HEAD~1` to undo it while keeping the files intact.
6.  Create an experimental branch with a commit, switch to main to make another commit, then rebase the experimental branch onto main to achieve a linear history.

---
[Back to Home](../README.md)
