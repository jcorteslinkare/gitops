#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 08: Introduction to GitOps (5 min)"

# Setup
REPO_DIR="08-exercise-gitops"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "The Declarative Model"
echo -e "${YLW}Scenario: In traditional Ops, you run 'kubectl scale' or 'docker run' to change running systems.${RST}"
echo -e "${YLW}In GitOps, the git repository is the SINGLE SOURCE OF TRUTH. You declare your desired state in Git!${RST}"
echo -e "${YLW}We have initialized a Kubernetes deployment manifest (deployment.yaml) for a web server:${RST}\n"

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

echo -e "${YLW}1. Inspect the declared infrastructure configuration:${RST}"
student_command "cat deployment.yaml"
wait_user

echo -e "\n${YLW}2. Stage and commit the desired state to Git:${RST}"
student_command "git add deployment.yaml"
student_command "git commit -m 'feat: deploy initial web-server'"
wait_user


print_step 2 "The GitOps Loop (Initial Sync)"
echo -e "${YLW}Scenario: A GitOps controller (like ArgoCD or Flux) is continuously running in the cluster.${RST}"
echo -e "${YLW}It pulls your Git repo, reads deployment.yaml, and applies it to the cluster.${RST}\n"

echo -e "${MAG}[GitOps Agent] 🔍 Continuous Reconciliation Active...${RST}"
echo -e "${MAG}[GitOps Agent] Comparing states...${RST}"
sleep 1
echo -e "  - ${BOLD}Git Desired State:${RST} deployment.yaml (replicas: 3)"
echo -e "  - ${BOLD}K8s Cluster State:${RST} Brand new cluster (0 pods running)"
echo -e "${YLW}⚠️  DRIFT DETECTED! Cluster is out-of-sync!${RST}"
echo -e "${MAG}[GitOps Agent] 🔄 Deploying declared infrastructure...${RST}"
sleep 1
echo -e "  [+] Provisioning Deployment/web-server..."
echo -e "  [+] Pod web-server-7f89d - ${GRN}Running${RST}"
echo -e "  [+] Pod web-server-2a45b - ${GRN}Running${RST}"
echo -e "  [+] Pod web-server-9x12c - ${GRN}Running${RST}"
echo -e "${GRN}🟢 STATE IS IN SYNC! Cluster matches Git desired state.${RST}"
wait_reading


print_step 3 "Scale the Infrastructure via Git"
echo -e "${YLW}Scenario: Your app is experiencing high traffic! You need to scale to 5 replicas.${RST}"
echo -e "${YLW}CRITICAL RULE: Never modify the cluster directly! You must update the Git declaration.${RST}\n"

echo -e "${YLW}1. Modify the replicas count from 3 to 5 in deployment.yaml:${RST}"
student_command "sed -i 's/replicas: 3/replicas: 5/' deployment.yaml"
wait_user

echo -e "\n${YLW}2. Commit and push this change to Git (declaring the new desired state):${RST}"
student_command "git add deployment.yaml"
student_command "git commit -m 'chore: scale web-server to 5 replicas'"
wait_user


print_step 4 "Watch the GitOps Reconciliation!"
echo -e "${YLW}Scenario: The GitOps Agent instantly detects your new commit and reconciles the cluster!${RST}\n"

echo -e "${MAG}[GitOps Agent] ⚡ New Git commit detected!${RST}"
echo -e "${MAG}[GitOps Agent] Comparing states...${RST}"
sleep 1
echo -e "  - ${BOLD}Git Desired State:${RST} deployment.yaml (replicas: 5)"
echo -e "  - ${BOLD}K8s Cluster State:${RST} 3 pods running"
echo -e "${YLW}⚠️  DRIFT DETECTED! Cluster is out-of-sync (missing 2 pods)!${RST}"
echo -e "${MAG}[GitOps Agent] 🔄 Reconciling cluster state automatically...${RST}"
sleep 1.5
echo -e "  [+] Pod web-server-5m23p - ${GRN}Running${RST}"
echo -e "  [+] Pod web-server-8q91z - ${GRN}Running${RST}"
echo -e "${GRN}🟢 STATE IS IN SYNC! 5 pods running (Real State == Desired State).${RST}"
wait_reading

print_summary \
    "The core Declarative Model—defining our Desired State (infrastructure, pods) as files in Git." \
    "What the GitOps Loop represents (the continuous reconciliation loop comparing Git with active environments)." \
    "How agents (like ArgoCD or Flux) dynamically detect and fix Drift (out-of-sync cluster status)." \
    "CRITICAL RULE: Never modify active infrastructure directly; always declare state in Git to drive reconciliation." \
    "Why Git serves as the single source of truth, establishing auditable, high-security operations."

print_header "Workshop Concluded!"
echo -e "${GRN}Congratulations! You have completed the Git for DevOps hands-on workshop!${RST}"
echo -e "${BLU}Next steps:${RST} Implement these patterns using real ArgoCD, Flux, and GitLab CI/CD."
