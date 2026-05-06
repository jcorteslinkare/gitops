#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 04: Branching & Merging (25 min)"

# Setup
REPO_DIR="exercise-branching"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null
echo "v1.0" > version.txt
git add version.txt
git commit -m "initial commit" > /dev/null

print_step 1 "Create and switch to a new branch"
execute_command "git checkout -b feature-a"
execute_command "git branch"
wait_user

print_step 2 "Make a change in the feature branch"
execute_command "echo 'Feature A content' > feature.txt"
execute_command "git add feature.txt"
execute_command "git commit -m 'add feature a'"
wait_user

print_step 3 "Go back to main and create a conflict"
execute_command "git checkout main"
execute_command "echo 'Change in main' >> version.txt"
execute_command "git add version.txt"
execute_command "git commit -m 'update version in main'"
wait_user

print_step 4 "Change the same file in the feature branch"
execute_command "git checkout feature-a"
execute_command "echo 'Conflicting change' >> version.txt"
execute_command "git add version.txt"
execute_command "git commit -m 'update version in feature branch'"
wait_user

print_step 5 "Merge and resolve conflict"
echo -e "${YLW}Trying to merge feature-a into main...${RST}"
execute_command "git checkout main"
execute_command "git merge feature-a"

echo -e "\n${RED}CONFLICT DETECTED!${RST}"
echo -e "Open 'version.txt' to see the markers."
wait_user

echo -e "${YLW}Simulating conflict resolution...${RST}"
echo "Fixed version content" > version.txt
execute_command "git add version.txt"
execute_command "git commit -m 'merge: resolve conflict in version.txt'"

execute_command "git log --oneline --graph --all"

echo -e "\n${GRN}Module 04 completed!${RST}"
