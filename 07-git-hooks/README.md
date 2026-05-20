# Module 07: Git Hooks and Local Automation

Git Hooks are scripts that Git executes automatically on certain events (before a commit, before a push, etc.).

## What are they for in Ops?

As system administrators, we want to prevent common mistakes before they reach the server:
- **Linting:** Check if a YAML or JSON file is valid.
- **Security:** Prevent passwords or SSH keys from being committed (e.g., `gitleaks`).
- **Standardization:** Ensure commit messages follow a pattern.

## Where are the Hooks?

They are in the `.git/hooks/` folder of your repository. By default, Git comes with some examples with the `.sample` extension.

## Example: Simple Pre-commit Hook

Let's create a hook that prevents commits if the file contains the word "TODO".

1.  Create the file `.git/hooks/pre-commit`:
    ```bash
    #!/bin/sh
    if grep -q "TODO" $(git diff --cached --name-only); then
        echo "ERROR: Remove TODOs before committing!"
        exit 1
    fi
    ```
2.  Give execution permissions:
    ```bash
    chmod +x .git/hooks/pre-commit
    ```

## The `pre-commit` Tool

Managing hooks manually can be difficult. The [pre-commit.com](https://pre-commit.com/) tool simplifies this using a `.pre-commit-config.yaml` file.

---
[Back to Home](../README.md)
