# Module 04: Branching and Merging

Branches are fundamental for working in teams or for testing changes without "breaking" the main code.

## What is a Branch?

In Git, a branch is simply a movable pointer to a commit. The default branch is usually named `main` (or `master`).

## Main Commands

- `git branch <name>`: Creates a new branch.
- `git checkout <name>` (or `git switch <name>`): Switches to the specified branch.
- `git checkout -b <name>`: Creates and switches to the branch at the same time.
- `git merge <name>`: Joins the history of the specified branch into the current branch.

## Branching Strategies in Ops

1.  **GitHub Flow:** A main branch (`main`) that is always stable. A branch is created for each task, work is done, and then a Merge/Pull Request is made.
2.  **GitFlow:** More complex, with `develop`, `release`, `hotfix` branches. Common in projects with rigid release cycles.
3.  **Trunk-Based Development:** Everyone works on a single branch (or very short-lived branches). Ideal for continuous CI/CD.

## Practical Exercise: Resolving a Conflict

1.  Create an `adjust-servers` branch and switch to it:
    ```bash
    git checkout -b adjust-servers
    ```
2.  Change `inventory.ini` by changing `server1`'s IP to `10.0.0.100`. Commit.
3.  Back to `main` branch: `git checkout main`.
4.  Change the **same line** in `inventory.ini` to `10.0.0.200`. Commit.
5.  Try to join the branches: `git merge adjust-servers`.
6.  Git will say "CONFLICT". Open the file, choose the correct version, remove the markers (`<<<<`, `====`, `>>>>`), `git add`, and finalize the commit.

---
[Back to Home](../README.md)
