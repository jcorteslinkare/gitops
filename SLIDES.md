# Git for DevOps & Ops
## From System Administration to GitOps

---

## Module 01: Introduction (5 min)
### Why Git for Ops?

- **Infrastructure as Code (IaC):** Ansible, Terraform, Puppet.
- **History and Audit:** Who changed what and when?
- **Rollback:** Quick disaster recovery.
- **Collaboration:** Peer review for infrastructure changes.

---

## Module 02: Initial Configuration (5 min)
### The basics to get started

- `git config --global user.name "Your Name"`
- `git config --global user.email "email@example.com"`
- **Useful Aliases:**
  - `git config --global alias.st status`
  - `git config --global alias.lg "log --oneline --graph --all"`

---

## Module 03: Basic Workflow (15 min)
### The 3 Stages

1.  **Working Directory:** Modified files not yet saved.
2.  **Staging Area (Index):** Files marked for the next commit.
3.  **Repository (.git):** Permanently saved snapshot.

**Commands:** `add`, `commit`, `status`, `log`.

---

## Module 04: Branching & Merging (25 min)
### Parallel work without fear

- **Branch:** A movable pointer to a commit.
- **Merge:** Join lines of development.
- **Conflicts:** When the same line is changed in different branches.
- **Strategies:** GitHub Flow (Simple) vs GitFlow (Complex).

---

## Module 05: Collaboration & Remotes (10 min)
### Git is distributed

- `git clone`: Copy a remote repo.
- `git fetch`: Get updates without changing local code.
- `git pull`: Fetch + Merge.
- `git push`: Send changes to the server.
- **Pull Requests:** The basis of Code Review.

---

## Module 06: Ops Power Tools (15 min)
### Saving the day

- `git stash`: Save changes temporarily to switch branches.
- `git cherry-pick`: Bring a specific commit from another branch.
- `git rebase`: Rewrite history for a clean log.
- `git reset`: Undo mistakes (with care!).

---

## Module 07: Git Hooks (10 min)
### Local Automation

- Scripts that run on specific events.
- **Ops Example:** Validate YAML or Ansible file syntax before commit.
- Suggested tool: `pre-commit`.

---

## Module 08: Introduction to GitOps (5 min)
### The Single Source of Truth

- Infrastructure state is defined in Git.
- Automatic synchronization between Git and Cluster (e.g., Kubernetes).
- Tools: ArgoCD, Flux.

---

# Let's get to work!
Check the README of each module for exercises.
