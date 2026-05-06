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

In this first module, we will just ensure Git is installed and create our first local repository.

1.  Check Git version:
    ```bash
    git --version
    ```
2.  Create a folder for testing:
    ```bash
    mkdir module01-test
    cd module01-test
    ```
3.  Initialize the repository:
    ```bash
    git init
    ```
4.  Verify that a hidden `.git` folder was created:
    ```bash
    ls -la
    ```

---
[Back to Home](../README.md)
