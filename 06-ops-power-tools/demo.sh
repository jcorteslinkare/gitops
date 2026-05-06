#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 06: Power Tools (15 min)"

# Setup
REPO_DIR="exercise-power-tools"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null
echo "original content" > file.txt
git add file.txt
git commit -m "initial commit" > /dev/null

print_step 1 "The magic of Git Stash"
echo "Unfinished work" >> file.txt
echo -e "${YLW}Current status of file.txt:${RST}"
cat file.txt
execute_command "git stash"
echo -e "\n${YLW}After stash (back to clean state):${RST}"
cat file.txt
wait_user

print_step 2 "Recover the work"
execute_command "git stash pop"
echo -e "\n${YLW}Work recovered:${RST}"
cat file.txt
wait_user

print_step 3 "Cherry-pick a specific fix"
git checkout -b experimental > /dev/null
echo "Security fix" > security.txt
git add security.txt
git commit -m "fix: important security patch" > /dev/null
FIX_HASH=$(git rev-parse HEAD)
git checkout main > /dev/null

echo -e "${YLW}Cherry-picking fix from experimental branch ($FIX_HASH)...${RST}"
execute_command "git cherry-pick $FIX_HASH"
execute_command "ls -la"

echo -e "\n${GRN}Module 06 completed!${RST}"
