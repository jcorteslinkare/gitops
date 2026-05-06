# Module 03: Basic Workflow

The heart of Git lies in the transition of files between three states.

## The 3 States

1.  **Working Directory:** Your local folder where you edit files (e.g., `site.yml`).
2.  **Staging Area (or Index):** An intermediate zone where you prepare what will be saved.
3.  **Repository:** Where Git permanently saves the "snapshot" (commit).

## Lifecycle

1.  **Edit:** Change a file.
2.  **Add (`git add`):** Move the file to Staging.
3.  **Commit (`git commit`):** Save the current state with a descriptive message.

## Essential Commands

- `git status`: Shows what state your files are in.
- `git diff`: Shows what changed in the files before adding them.
- `git log`: Shows the commit history.

## Practical Exercise

Let's simulate creating an Ansible inventory.

1.  Create an `inventory.ini` file:
    ```bash
    echo -e "[webservers]\nserver1 ansible_host=10.0.0.1" > inventory.ini
    ```
2.  Check status: `git status`. The file appears as **untracked**.
3.  Add to staging: `git add inventory.ini`.
4.  Check status again. The file is ready for commit.
5.  Commit:
    ```bash
    git commit -m "feat: add initial inventory"
    ```
6.  Change the file (add another server) and use `git diff` to see the difference before repeating the process.

---
[Back to Home](../README.md)
