#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 03: Basic Workflow (15 min)"

# Ensure we are in a clean sandboxed git repo for this exercise
REPO_DIR="03-exercise-basic-workflow"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "The Working Directory (Untracked State)"
echo -e "${YLW}In Git, files go through three main areas:${RST}"
echo -e "  1. ${BOLD}Working Directory${RST} (Your local files) 💻"
echo -e "  2. ${BOLD}Staging Area${RST} (The loading dock for the next commit) 📦"
echo -e "  3. ${BOLD}Git Repository${RST} (The permanent history of snapshots) 🗄️"
echo -e "     ${DIM}└─ Snapshots: Git takes full cryptographic 'photos' of your files, not partial differences (deltas).${RST}"
echo -e "     ${DIM}└─ Permanent: Once committed, history is immutable and secure under a unique SHA hash ID.${RST}"
echo -e "     ${DIM}└─ vs SVN/CVS: Older centralized systems only store deltas and require a server connection for history.${RST}"
echo -e "     ${DIM}               Git is fully distributed—you have the entire history locally on your machine at high speed!${RST}\n"

echo -e "${YLW}Scenario: You are setting up a new database configuration file (config.yml).${RST}"
echo -e "${YLW}Let's create this file in our working directory:${RST}\n"

echo -e "${YLW}1. Create the database config file:${RST}"
student_command "echo 'db_host: 10.0.0.1' > config.yml"
wait_user

echo -e "\n${YLW}2. Check the status of your repository. Notice the file is RED (Untracked):${RST}"
echo -e "${YLW}This means Git sees the file in your working directory, but is NOT tracking its history yet!${RST}"
student_command "git status"
wait_user


print_step 2 "The Staging Area (Prepared State)"
echo -e "${YLW}Scenario: Think of the Staging Area as a 'shopping cart'. Before checking out (committing),${RST}"
echo -e "${YLW}you must select which files or changes you want to include in the next snapshot.${RST}\n"

echo -e "${YLW}1. Add your file to the Staging Area:${RST}"
student_command "git add config.yml"
wait_user

echo -e "\n${YLW}2. Check the status again. Notice the file is now GREEN (Staged / Changes to be committed):${RST}"
echo -e "${YLW}Your file is now safely prepared on the staging loading dock!${RST}"
student_command "git status"
wait_user


print_step 3 "The Git Repository (Committed State)"
echo -e "${YLW}Scenario: Now we want to take a permanent, immutable snapshot of our staged changes.${RST}"
echo -e "${YLW}Every commit has a unique hash ID and is saved forever in the Git history.${RST}\n"

echo -e "${YLW}1. Commit your staged changes with a descriptive conventional message:${RST}"
student_command "git commit -m 'feat: add initial database configuration'"
wait_user

echo -e "\n${YLW}2. View your commit history. Let's use our beautiful custom 'git lg' alias!:${RST}"
student_command "git lg"
wait_user

echo -e "\n${RED}⚠️  SECURITY INSIGHT: The Permanent Secret Danger!${RST}"
echo -e "${YLW}Because Git commits are permanent, immutable snapshots, if you commit a password, API key,${RST}"
echo -e "${YLW}or private SSL key by mistake, it is recorded in the repository history FOREVER!${RST}"
echo -e "${YLW}Even if you delete the credentials in a later commit, anyone can still view them by checking${RST}"
echo -e "${YLW}the previous commit history. In Git, once a secret is pushed, it is fully compromised.${RST}\n"
echo -e "${YLW}Best Practice: Never commit raw secrets! We must use secret-management tools, and set up${RST}"
echo -e "${YLW}automated local Git Hooks (which we will build in Module 7) to scan and block secrets${RST}"
echo -e "${YLW}on our machines before they are ever committed!${RST}"
wait_user


print_step 4 "Modify a File & Inspect Differences"
echo -e "${YLW}Scenario: We need to update our database configuration to include a port number.${RST}"
echo -e "${YLW}Let's modify the file and inspect the exact lines of code that changed!${RST}\n"

echo -e "${YLW}1. Append the database port line to config.yml:${RST}"
student_command "echo 'db_port: 5432' >> config.yml"
wait_user

echo -e "\n${YLW}2. Inspect the modifications using 'git diff'. Notice added lines marked with (+):${RST}"
echo -e "${YLW}This compares your active Working Directory with the last committed state!${RST}"
student_command "git diff"
wait_user


print_step 5 "Complete the Lifecycle (Stage & Commit Update)"
echo -e "${YLW}Scenario: Even though Git is already tracking config.yml, any new modifications${RST}"
echo -e "${YLW}must go through the Staging Area again before they can be committed!${RST}\n"

echo -e "${YLW}1. Stage your new changes (moving them to the staging area):${RST}"
student_command "git add config.yml"
wait_user

echo -e "\n${YLW}2. Commit the update to your local repository:${RST}"
student_command "git commit -m 'feat: add database port'"
wait_user

echo -e "\n${YLW}3. View the updated commit history using your visual log alias:${RST}"
student_command "git lg"
wait_user

print_summary \
    "Git's 3 main areas: Working Directory (local files), Staging Area (shopping cart), and Repository (committed history)." \
    "Concept: Git stores high-speed, cryptographic 'snapshots' (photos), unlike SVN's slow delta changesets." \
    "How Git is fully distributed, providing each developer with a complete copy of the database and history." \
    "Accidental credential leakage: Git history is immutable; committed secrets (passwords/keys) are visible forever." \
    "Basic lifecycle pipeline: 'git status' (checks state), 'git add' (stages), 'git commit' (saves), and 'git diff' (inspects)."

echo -e "\n${GRN}Module 03 completed!${RST}"
