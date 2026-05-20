#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 06: Power Tools (15 min)"

# Setup
REPO_DIR="06-exercise-power-tools"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

# Create a realistic Nginx config
cat <<EOF > nginx.conf
server {
    listen 80;
    server_name my-app.com;

    location / {
        proxy_pass http://localhost:8080;
    }
}
EOF
git add nginx.conf
git commit -m "feat: add basic Nginx configuration" > /dev/null

print_step 1 "The magic of Git Stash"
echo -e "${YLW}Scenario: You are in the middle of migrating Nginx to HTTPS/SSL (nginx.conf).${RST}"
echo -e "${YLW}Suddenly, a critical bug report comes in! You must switch tasks immediately.${RST}"
echo -e "${YLW}You don't want to lose your half-finished SSL configuration, but you also don't want to commit broken code.${RST}"
echo -e "${YLW}Let's see how Git Stash acts as your 'pause' button!${RST}\n"

echo -e "${YLW}Adding the unfinished SSL config block to nginx.conf:${RST}"
cat <<EOF >> nginx.conf

# IN-PROGRESS: Adding SSL configuration
server {
    listen 443 ssl;
    ssl_certificate /etc/ssl/certs/app.crt;
    # (unfinished configuration...)
}
EOF

student_command "cat nginx.conf"
wait_user

echo -e "\n${YLW}Saving your unfinished SSL config safely on the stash stack:${RST}"
student_command "git stash"
wait_user

echo -e "\n${YLW}How do we check what is currently inside our stash?${RST}"
echo -e "${YLW}1. List all stashed changes in the stack:${RST}"
student_command "git stash list"
wait_user

echo -e "\n${YLW}2. Show a summary of files modified in the most recent stash:${RST}"
student_command "git stash show"
wait_user

echo -e "\n${YLW}3. Show the actual code changes (diff) stored inside the stash:${RST}"
student_command "git stash show -p"
wait_user

echo -e "\n${YLW}Verifying that nginx.conf is back to its clean, production-stable state:${RST}"
student_command "cat nginx.conf"
wait_user

print_step 2 "Recover the work"
echo -e "${YLW}Scenario: You successfully checked out other branches, solved the emergency issue, and are now back.${RST}"
echo -e "${YLW}It is time to resume your SSL migration right where you left off!${RST}\n"

echo -e "${YLW}Popping the stashed SSL changes back into your working directory:${RST}"
student_command "git stash pop"

echo -e "\n${YLW}Checking nginx.conf. Notice your unfinished SSL configuration is back!${RST}"
student_command "cat nginx.conf"
wait_user

print_step 3 "Cherry-pick a specific fix"
echo -e "${YLW}Scenario: We have an unstable 'experimental' branch where we are testing new infrastructure tools.${RST}"
echo -e "${YLW}In it, we committed a critical hotfix to block an active security attack (firewall.sh).${RST}"
echo -e "${YLW}We want this firewall patch on 'main' IMMEDIATELY without merging the other experimental code.${RST}\n"

# Switch to experimental branch and make the critical commit
student_command "git checkout -b experimental"
student_command "echo 'iptables -A INPUT -s 203.0.113.50 -j DROP # block rogue IP' > firewall.sh"
student_command "git add firewall.sh"
student_command "git commit -m 'fix: block malicious IP on firewall'"

FIX_HASH=$(git rev-parse --short HEAD)
wait_user

echo -e "\n${YLW}Now we switch back to 'main' (which doesn't have the firewall fix yet):${RST}"
student_command "git checkout main"
echo -e "\n${YLW}Verifying files on 'main' (firewall.sh is NOT here):${RST}"
student_command "ls -la"
wait_user

echo -e "\n${YLW}Wait! In a real-world scenario, how do we find the hash of the commit we want to cherry-pick?${RST}"
echo -e "${YLW}We can search the log of the 'experimental' branch to locate our firewall fix commit and copy its hash!${RST}"
student_command "git log experimental --oneline -n 1"
wait_user

echo -e "\n${YLW}Perfect! Now that we have identified the commit hash ($FIX_HASH), we can cherry-pick it into 'main':${RST}"
student_command "git cherry-pick $FIX_HASH"

echo -e "\n${YLW}Let's check the files in 'main' again. Notice 'firewall.sh' is now here!${RST}"
student_command "ls -la"
wait_user
student_command "cat firewall.sh"
wait_user

print_step 4 "Undo a bad commit with Git Reset"
echo -e "${YLW}Scenario: You committed a broken configuration or used a terrible commit message.${RST}"
echo -e "${YLW}Since you haven't pushed it yet, you can safely undo it using 'git reset'.${RST}\n"

echo -e "${YLW}Let's create a 'bad' commit that we want to undo:${RST}"
student_command "echo 'broken_syntax=true' >> nginx.conf"
student_command "git add nginx.conf"
student_command "git commit -m 'oops this is a bad commit'"
student_command "git log --oneline -n 2"
wait_user

echo -e "\n${YLW}Now, let's undo the commit but keep the file changes staged (safe reset):${RST}"
student_command "git reset --soft HEAD~1"
student_command "git status"
student_command "git log --oneline -n 1"
wait_user

echo -e "\n${YLW}What if we want to discard the changes entirely? (hard reset)${RST}"
student_command "git reset --hard HEAD"
student_command "cat nginx.conf"
wait_user

print_step 5 "Keep a linear history with Git Rebase"
echo -e "${YLW}Scenario: You've been working on a new feature branch for days.${RST}"
echo -e "${YLW}Meanwhile, 'main' has advanced. You want to update your branch with main's changes${RST}"
echo -e "${YLW}but keep a clean, linear history for your final Pull Request.${RST}\n"

echo -e "${YLW}First, let's create our feature branch and add some work:${RST}"
student_command "git checkout -b feature-cache"
student_command "echo 'cache_enabled=true' > cache.conf"
student_command "git add cache.conf"
student_command "git commit -m 'feat: add cache layer'"
wait_user

echo -e "\n${YLW}Now, let's simulate someone else pushing a critical update to 'main':${RST}"
student_command "git checkout main"
student_command "echo 'timeout=30s' > limits.conf"
student_command "git add limits.conf"
student_command "git commit -m 'fix: add global timeout limits'"
wait_user

echo -e "\n${YLW}Let's look at the current diverging history before the rebase:${RST}"
student_command "git log --oneline --graph --all"
wait_user

echo -e "\n${YLW}Now we switch back to our feature branch and REBASE it on top of main:${RST}"
student_command "git checkout feature-cache"
student_command "git rebase main"
wait_user

echo -e "\n${YLW}Let's look at the history after rebase - notice how clean and linear it is!${RST}"
student_command "git log --oneline --graph --all"
wait_user

print_summary \
    "How to temporarily save unfinished workspace modifications using 'git stash'." \
    "How to pop stashed work back into your working directory using 'git stash pop'." \
    "Why stashing is crucial for Ops: switching branches quickly during production emergencies." \
    "How to search specific commit history hashes using targeted log searches (e.g., 'git log experimental --oneline -n 1')." \
    "How to surgically import a single, critical hotfix from another branch using 'git cherry-pick <commit-hash>'." \
    "Why cherry-picking is a key Ops power tool for copying hotfixes directly to production branches without merging unstable features." \
    "How to safely undo a local commit without losing code using 'git reset --soft'." \
    "How to completely discard unwanted local changes using 'git reset --hard'." \
    "How to update your feature branch with main's latest changes while keeping a linear history using 'git rebase'."

echo -e "\n${GRN}Module 06 completed!${RST}"
