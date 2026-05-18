#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 05: Collaboration (10 min)"

# Setup a 'server' repo
REMOTE_REPO="$(pwd)/05-server-repo.git"
rm -rf "$REMOTE_REPO"
mkdir -p "$REMOTE_REPO"
git init --bare "$REMOTE_REPO" > /dev/null

print_step 1 "Clone the 'remote' repository"
REPO_DIR="05-my-local-work"
rm -rf "$REPO_DIR"
student_command "git clone $REMOTE_REPO $REPO_DIR"
student_command "cd $REPO_DIR"
student_command "git remote -v"

echo -e "\n${YLW}Note: Cloning automatically creates a remote shortcut named 'origin' pointing to the server.${RST}"
echo -e "${YLW}When you run 'git pull origin main', you are telling Git:${RST}"
echo -e "${YLW}  1. Go to the remote server named 'origin'${RST}"
echo -e "${YLW}  2. Pull the branch named 'main'${RST}"
echo -e "${YLW}If you just ran 'git pull main', Git wouldn't know which server to contact!${RST}"
wait_user

print_step 2 "Push your first change"
student_command "echo 'First shared file' > README.md"
student_command "git add README.md"
student_command "git commit -m 'initial shared commit'"
student_command "git push origin main"
wait_user

print_step 3 "Simulate a colleague's work (Alice)"
echo -e "${YLW}Meanwhile, your colleague Alice is working on another machine...${RST}"
COLLEAGUE_DIR="../05-colleague-work"
rm -rf "$COLLEAGUE_DIR"
execute_command "git clone $REMOTE_REPO $COLLEAGUE_DIR"
execute_command "cd $COLLEAGUE_DIR"
execute_command "echo \"Colleague's update\" > update.txt"
execute_command "git add update.txt"
execute_command "git commit -m \"colleague added update.txt\""
execute_command "git push origin main"

echo -e "\n${YLW}Note: In a real environment, Git will NOT notify you when Alice pushes.${RST}"
echo -e "${YLW}You must fetch or pull to see or merge her changes.${RST}"
execute_command "cd ../$REPO_DIR"
wait_reading

print_step 4 "Pull the updates"
student_command "git pull origin main"
student_command "ls -la"

echo -e "\n${GRN}Module 05 completed!${RST}"
