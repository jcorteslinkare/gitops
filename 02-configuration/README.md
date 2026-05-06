# Module 02: Configuration and Productivity

Before you start making commits, Git needs to know who you are.

## Identity

Configure the name and email that will appear in the logs:

```bash
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

## Editor Configuration

Git opens a text editor for long commit messages. If you prefer `nano` or `vim`:

```bash
git config --global core.editor "nano"
```

## Aliases (Shortcuts)

To be more productive, we can create shortcuts for frequent commands:

```bash
git config --global alias.st status
git config --global alias.br branch
git config --global alias.co checkout
git config --global alias.ci commit
```

**The "Holy Grail" of logs:**
An alias to view history in a graphical and clean way:
```bash
git config --global alias.lg "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
```

## Practical Exercise

1.  Configure your name and email.
2.  Add the `st` alias for `status`.
3.  Check your current settings:
    ```bash
    git config --list
    ```
    Or view the global config file directly:
    ```bash
    cat ~/.gitconfig
    ```

---
[Back to Home](../README.md)
