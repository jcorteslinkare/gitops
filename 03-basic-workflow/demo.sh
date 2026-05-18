#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 03: Basic Workflow (15 min)"

# Ensure we are in a clean git repo for this exercise
REPO_DIR="03-exercise-basic-workflow"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "Create an initial file"
student_command "echo 'db_host: 10.0.0.1' > config.yml"
student_command "git status"
wait_user

print_step 2 "Add file to staging area"
student_command "git add config.yml"
student_command "git status"
wait_user

print_step 3 "Make your first commit"
student_command "git commit -m 'feat: add initial database configuration'"
student_command "git log --oneline"
wait_user

print_step 4 "Modify the file and check diff"
student_command "echo 'db_port: 5432' >> config.yml"
student_command "git diff"
wait_user

print_step 5 "Finish the update"
student_command "git add config.yml"
student_command "git commit -m 'feat: add database port'"
student_command "git log --oneline"

echo -e "\n${GRN}Module 03 completed!${RST}"
