# Module 01: Introduction to Git for Operations

## What is Git?

Git is a distributed version control system. Unlike older systems (like SVN), every user has a full copy of the repository on their computer.

## Why use Git in Operations?

Traditionally, system administrators saved scripts and configurations in folders like `script_v1.sh`, `script_v2_final.sh`, `script_v2_final_REVISED.sh`.

With the advent of **Infrastructure as Code (IaC)**, our configurations become code. Git offers:

1.  **Auditing:** Know exactly who changed the Nginx configuration file at 3 AM.
2.  **Safe Experimentation:** Create a branch to test a new Firewall rule without affecting production.
3.  **Teamwork:** Multiple people can work on the same Ansible project without overwriting each other's work.
4.  **Automation (CI/CD):** A `git push` can automatically trigger a deploy or a security validation.

## Practical Exercise

In this first module, we will ensure Git is installed, explore a terminal UI client, and create our first local repository.

1.  **Install Git:**
    Depending on your OS, you can install Git using your package manager:
    - **Ubuntu/Debian:** `sudo apt update && sudo apt install git`
    - **CentOS/RHEL:** `sudo dnf install git`

2.  **Check Git version:**
    ```bash
    git --version
    ```

3.  **Install a Terminal UI client (tig):**
    While the CLI is powerful, visual tools help understand the repository state. `tig` is an excellent text-mode interface for Git.
    - **Ubuntu/Debian:** `sudo apt install tig`
    - **CentOS/RHEL:** `sudo dnf install tig`

4.  **Create a folder for testing:**
    ```bash
    mkdir module01-test
    cd module01-test
    ```

5.  **Initialize the repository:**
    ```bash
    git init
    ```

6.  **Verify that a hidden `.git` folder was created:**
    ```bash
    ls -la
    ```
    *(Note: This `.git` folder is the heart of your repository. It is where Git stores all its internal information, configuration, and the entire history of your commits. If you delete this folder, the project stops being a Git repository.)*

7.  **Quick Stage and Commit with tig:**
    Let's create a file and use `tig` to commit it.
    ```bash
    echo "Hello Git" > hello.txt
    tig status
    ```
    Inside `tig`:
    - Press `u` on the `hello.txt` file to stage it (move it to "Changes to be committed").
    - Press `C` (Shift+C) to commit.
    - Type your commit message in the editor that opens, save, and exit.
    - Press `q` to quit `tig`.

---
[Back to Home](../README.md)
