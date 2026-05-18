#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 08: GitOps Intro (5 min)"

# Setup
REPO_DIR="08-exercise-gitops"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"


print_step 1 "The Declarative Model"
echo -e "${YLW}In GitOps, we define the DESIRED state in Git.${RST}"
cat <<EOF > deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-server
spec:
  replicas: 3
  template:
    spec:
      containers:
      - name: nginx
        image: nginx:1.21
EOF
student_command "cat deployment.yaml"
wait_user

print_step 2 "The GitOps Loop"
echo -e "${YLW}1. Git Push (Desired State) -> GitHub/GitLab${RST}"
echo -e "${YLW}2. ArgoCD/Flux (Agent) detects change${RST}"
echo -e "${YLW}3. Agent applies change to the cluster${RST}"
echo -e "${YLW}4. Continuous Reconciliation (Real State == Desired State)${RST}"
wait_user

print_header "Workshop Concluded!"
echo -e "${GRN}You have completed the Git for DevOps hands-on workshop.${RST}"
echo -e "${BLU}Next steps:${RST} Explore tools like ArgoCD, Terraform, and GitLab CI/CD."
