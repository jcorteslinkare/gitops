# Module 05: Collaboration and Remote Repositories

Git is a distributed system, which means your local repository needs to communicate with a server (GitHub, GitLab, Bitbucket).

## Remotes

A "remote" is a URL pointing to the server where code is shared. The default name for the main server is `origin`.

## Main Commands

- `git clone <url>`: Copies a remote repository to your machine.
- `git remote -v`: Lists configured servers.
- `git fetch`: Gets updates from the server but doesn't apply them to your code (it's safe).
- `git pull`: Gets updates and tries to apply them to your current branch (Fetch + Merge).
- `git push`: Sends your local commits to the server.

## Team Workflow

1.  **Pull:** Start the day by updating your local code.
2.  **Branch:** Always work in a separate branch.
3.  **Push:** Send the branch to the server.
4.  **Pull Request (PR) / Merge Request (MR):** Ask a colleague to review your code before merging it into the main branch.

## Practical Exercise (Simulated)

Since we don't have a real remote server configured now, let's simulate the commands:

1.  Check if you have remotes configured: `git remote -v`.
2.  Imagine you want to send a branch:
    ```bash
    git push origin my-new-feature
    ```
3.  Imagine a colleague made changes to `main`:
    ```bash
    git checkout main
    git pull origin main
    ```

---
[Back to Home](../README.md)
