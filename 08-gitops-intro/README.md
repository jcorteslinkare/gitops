# Module 08: Introduction to GitOps

GitOps is an operational model for applications and infrastructure that uses Git as the "Single Source of Truth".

## GitOps Principles

1.  **Declarative:** The desired state of the system is described in a file (e.g., Kubernetes YAML, Terraform).
2.  **Versioned in Git:** The state is saved in Git, maintaining a history of changes.
3.  **Automatically Approved:** Changes in Git automatically trigger system updates.
4.  **Software Agents:** There is an agent (ArgoCD, Flux) that ensures the real state of the cluster matches the state defined in Git.

## Why is it the future for Ops?

- **Drift Detection:** The agent warns if someone manually changes the server (outside of Git).
- **Instant Disaster Recovery:** If the cluster is deleted, just point ArgoCD to the Git repository and it recreates everything.
- **Security:** Fewer people need direct access to servers; they only need access to Git.

## The GitOps Workflow

1.  A SysAdmin changes the number of replicas of a service in Git.
2.  Does a `push` to the `main` branch.
3.  **ArgoCD** detects the change.
4.  **ArgoCD** applies the change to Kubernetes automatically.

## Conclusion of the Training

Mastering Git is the first step to becoming a modern DevOps engineer. From here, the limit is automation!

---
[Back to Home](../README.md)
