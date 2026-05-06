#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 05: Collaboration (10 min)"

# Setup a 'server' repo
REMOTE_REPO="$(pwd)/server-repo.git"
rm -rf "$REMOTE_REPO"
mkdir -p "$REMOTE_REPO"
git init --bare "$REMOTE_REPO" > /dev/null

print_step 1 "Clone the 'remote' repository"
REPO_DIR="my-local-work"
rm -rf "$REPO_DIR"
execute_command "git clone $REMOTE_REPO $REPO_DIR"
cd "$REPO_DIR"
wait_user

print_step 2 "Push your first change"
execute_command "echo 'First shared file' > README.md"
execute_command "git add README.md"
execute_command "git commit -m 'initial shared commit'"
execute_command "git push origin main"
wait_user

print_step 3 "Simulate a colleague's work"
COLLEAGUE_DIR="../colleague-work"
rm -rf "$COLLEAGUE_DIR"
git clone "$REMOTE_REPO" "$COLLEAGUE_DIR" > /dev/null
cd "$COLLEAGUE_DIR"
echo "Colleague's update" > update.txt
git add update.txt
git commit -m "colleague added update.txt" > /dev/null
git push origin main > /dev/null
echo -e "${YLW}A colleague has pushed changes to the server.${RST}"
cd "../$REPO_DIR"
wait_user

print_step 4 "Pull the updates"
execute_command "git pull origin main"
execute_command "ls -la"

echo -e "\n${GRN}Module 05 completed!${RST}"
