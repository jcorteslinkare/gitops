#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 05: Collaboration (10 min)"

# Setup a 'server' repo
REMOTE_REPO="$(pwd)/05-server-repo.git"
rm -rf "$REMOTE_REPO"
mkdir -p "$REMOTE_REPO"
git init --bare "$REMOTE_REPO" > /dev/null

print_step 1 "Clone the remote repository"
echo -e "${YLW}Scenario: Git is a distributed VCS. A central repository (like GitHub or GitLab)${RST}"
echo -e "${YLW}acts as a sync hub. Let's clone our central repository to start working locally:${RST}\n"

REPO_DIR="05-my-local-work"
rm -rf "$REPO_DIR"

echo -e "${YLW}1. Clone the central bare repository into a local work directory:${RST}"
student_command "git clone $REMOTE_REPO $REPO_DIR"
wait_user

echo -e "\n${YLW}2. Enter your newly cloned repository directory:${RST}"
student_command "cd $REPO_DIR"
wait_user

echo -e "\n${YLW}3. View the remote bookmarks pointing back to the central server:${RST}"
student_command "git remote -v"
wait_user

echo -e "\n${YLW}Note: Cloning automatically creates a remote shortcut named 'origin' pointing to the server.${RST}"
echo -e "${YLW}When you run 'git pull origin main', you are telling Git:${RST}"
echo -e "${YLW}  1. Go to the remote server named 'origin'${RST}"
echo -e "${YLW}  2. Pull the branch named 'main'${RST}"
echo -e "${YLW}If you just ran 'git pull main', Git wouldn't know which server to contact!${RST}"
wait_user


print_step 2 "Push your first change to the server"
echo -e "${YLW}Scenario: Let's create a shared README file in our local repository${RST}"
echo -e "${YLW}and push it up to the central server so our colleagues can access it:${RST}\n"

echo -e "${YLW}1. Create, stage, and commit 'README.md' locally:${RST}"
student_command "echo 'First shared file' > README.md"
wait_user
student_command "git add README.md"
wait_user
student_command "git commit -m 'feat: initial shared commit'"
wait_user

echo -e "\n${YLW}2. Upload (push) your local commits to the server's 'main' branch:${RST}"
student_command "git push origin main"
wait_user


print_step 3 "Simulate a colleague's work (Alice)"
echo -e "${YLW}Scenario: Meanwhile, your colleague Alice clones the same repository,${RST}"
echo -e "${YLW}creates a new deployment file, and pushes it up to the server:${RST}\n"

COLLEAGUE_DIR="../05-colleague-work"
rm -rf "$COLLEAGUE_DIR"

execute_command "git clone $REMOTE_REPO $COLLEAGUE_DIR"
execute_command "cd $COLLEAGUE_DIR"
execute_command "echo \"Colleague's update\" > update.txt"
execute_command "git add update.txt"
execute_command "git commit -m \"feat: colleague added update.txt\""
execute_command "git push origin main"

echo -e "\n${RED}⚠️  DISTRIBUTED MINDSET CHALLENGE:${RST}"
echo -e "${YLW}In Git, you will NEVER get a notification when Alice pushes her work.${RST}"
echo -e "${YLW}Since Git is completely local and distributed, your local repository is out of sync${RST}"
echo -e "${YLW}until you decide to actively pull the updates from the server!${RST}\n"

execute_command "cd ../$REPO_DIR"
wait_reading


print_step 4 "Pull the updates from the server"
echo -e "${YLW}Scenario: Let's pull down Alice's changes to sync our local repository:${RST}\n"

echo -e "${YLW}1. Fetch and merge (pull) Alice's commits from the server:${RST}"
student_command "git pull origin main"
wait_user

echo -e "\n${YLW}2. List all files in your workspace to verify Alice's 'update.txt' is now here:${RST}"
student_command "ls -la"
wait_user

print_summary \
    "How Git functions as a distributed VCS—cloning creates complete local database copies." \
    "What the remote bookmark 'origin' represents (default name for the cloned server)." \
    "Why you must use 'git push <remote> <branch>' to share local commits with the team." \
    "The asynchronous nature of Git—no real-time server push notifications are pushed to your PC." \
    "What 'git pull' is (a combination of 'git fetch' to download changes + 'git merge' to join them)." \
    "How to keep your local repository perfectly in sync using 'git pull origin main'."

echo -e "\n${GRN}Module 05 completed!${RST}"
