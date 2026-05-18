#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 04: Branching & Merging (25 min)"

# Setup
REPO_DIR="04-exercise-branching"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null
echo "v1.0" > version.txt
git add version.txt
git commit -m "initial commit" > /dev/null

print_step 1 "Create and switch to a new branch"
echo -e "${YLW}Scenario: In DevOps, we never develop directly on the production-ready 'main' branch.${RST}"
echo -e "${YLW}Instead, we create an isolated 'feature branch' to work on our code or scripts safely.${RST}\n"

echo -e "${YLW}1. Create and switch to a new branch called 'feature-a':${RST}"
student_command "git checkout -b feature-a"
wait_user

echo -e "\n${YLW}2. List all local branches (the active branch is marked with an asterisk *):${RST}"
student_command "git branch"
wait_user


print_step 2 "Make a change in the feature branch"
echo -e "${YLW}Scenario: Let's create a new feature file to simulate writing a new service deployment script:${RST}\n"

echo -e "${YLW}1. Create, stage, and commit 'feature.txt' inside the 'feature-a' branch:${RST}"
student_command "echo 'Feature A content' > feature.txt"
wait_user
student_command "git add feature.txt"
wait_user
student_command "git commit -m 'feat: add feature a'"
wait_user


print_step 3 "Go back to main and simulate a concurrent update"
echo -e "${YLW}Scenario: While you were working in 'feature-a', another engineer merged a hotfix${RST}"
echo -e "${YLW}modifying 'version.txt' on the 'main' branch. Let's switch back and simulate this update:${RST}\n"

echo -e "${YLW}1. Switch back to the 'main' branch:${RST}"
student_command "git checkout main"
wait_user

echo -e "\n${YLW}2. Modify 'version.txt' on 'main' and commit the update:${RST}"
student_command "echo 'Change in main' >> version.txt"
wait_user
student_command "git add version.txt"
wait_user
student_command "git commit -m 'chore: update version in main'"
wait_user


print_step 4 "Modify the same file in feature branch (Recipe for Conflict)"
echo -e "${YLW}Scenario: Now, you switch back to 'feature-a' and modify the exact same 'version.txt' file${RST}"
echo -e "${YLW}without knowing that 'main' has already changed it. This is how merge conflicts are born!${RST}\n"

echo -e "${YLW}1. Switch back to your feature branch:${RST}"
student_command "git checkout feature-a"
wait_user

echo -e "\n${YLW}2. Append a conflicting line to the same 'version.txt' file and commit it:${RST}"
student_command "echo 'Conflicting change' >> version.txt"
wait_user
student_command "git add version.txt"
wait_user
student_command "git commit -m 'feat: update version in feature branch'"
wait_user


print_step 5 "Merge and Resolve Conflicts"
echo -e "${YLW}Scenario: You are ready to merge your feature branch back into 'main'.${RST}"
echo -e "${YLW}Let's switch to 'main' and try to merge 'feature-a':${RST}\n"

echo -e "${YLW}1. Switch back to 'main':${RST}"
student_command "git checkout main"
wait_user

echo -e "\n${YLW}2. Attempt to merge 'feature-a' into 'main'. Notice that Git flags a merge conflict:${RST}"
student_command "git merge feature-a"
wait_user

echo -e "\n${RED}⚠️  MERGE CONFLICT DETECTED!${RST}"
echo -e "${YLW}Git has paused the merge and modified version.txt to include conflict markers:${RST}"
echo -e "  <<<<<<< HEAD (Active branch - main)"
echo -e "  ======="
echo -e "  >>>>>>> feature-a (Incoming branch)"
echo -e "${YLW}Let's fix the conflict by overwriting the file with our unified resolved state:${RST}\n"

echo -e "${YLW}3. Resolve the conflict by rewriting 'version.txt' with the final clean content:${RST}"
student_command "echo 'Fixed version content' > version.txt"
wait_user

echo -e "\n${YLW}4. Stage and commit the conflict resolution to complete the merge successfully:${RST}"
student_command "git add version.txt"
wait_user
student_command "git commit -m 'merge: resolve conflict in version.txt'"
wait_user

echo -e "\n${YLW}5. View the complete, beautiful graph of your merged branches using 'git lg':${RST}"
student_command "git lg"
wait_user

print_summary \
    "Branches represent high-speed, lightweight pointers to specific commits, enabling risk-free isolation." \
    "How to create and switch branches using 'git checkout -b <branch>' and 'git checkout <branch>'." \
    "How Git automatically flags conflicts when the same lines of a file are modified differently in both branches." \
    "How to read Git conflict markers (<<<<<<< HEAD, =======, >>>>>>>) and resolve them on disk." \
    "How to complete a merge conflict resolution by staging the resolved files and running a final commit." \
    "How to review the entire project merge branch history visually using the custom 'git lg' graph."

echo -e "\n${GRN}Module 04 completed!${RST}"
