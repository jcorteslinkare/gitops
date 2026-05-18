#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 04: Branching & Merging (25 min)"

# Setup
REPO_DIR="04-exercise-branching"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

# Initial production base config
echo "APP_ENV=production" > config.env
git add config.env
git commit -m "chore: add initial base environment config" > /dev/null

print_step 1 "Create and switch to a new branch"
echo -e "${YLW}Scenario: In DevOps, we never develop directly on the production-ready 'main' branch.${RST}"
echo -e "${YLW}Instead, we create an isolated 'feature branch' to work on our code or scripts safely.${RST}\n"

echo -e "${YLW}1. Create and switch to a new branch called 'feature-a':${RST}"
student_command "git checkout -b feature-a"
wait_user

echo -e "\n${YLW}2. List all local branches (the active branch is marked with an asterisk *):${RST}"
student_command "git branch"
wait_user


print_step 2 "Make a change in your feature branch"
echo -e "${YLW}Scenario: In your feature branch, you need to enable caching for the web application.${RST}"
echo -e "${YLW}Let's append the caching configuration property to 'config.env' and commit it:${RST}\n"

echo -e "${YLW}1. Append the CACHE_ENABLED setting to config.env:${RST}"
student_command "echo 'CACHE_ENABLED=true' >> config.env"
wait_user

echo -e "\n${YLW}2. Stage and commit the caching configuration on 'feature-a':${RST}"
student_command "git add config.env"
wait_user
student_command "git commit -m 'feat: enable application cache'"
wait_user


print_step 3 "Go back to main and simulate a concurrent update"
echo -e "${YLW}Scenario: Meanwhile, another engineer is handling database tuning.${RST}"
echo -e "${YLW}They concurrently update 'config.env' on the 'main' branch to configure database pools.${RST}"
echo -e "${YLW}Let's switch back to 'main' and simulate their commit:${RST}\n"

echo -e "${YLW}1. Switch back to the 'main' branch:${RST}"
student_command "git checkout main"
wait_user

echo -e "\n${YLW}2. Append the DB_POOL_SIZE setting to config.env on main:${RST}"
student_command "echo 'DB_POOL_SIZE=20' >> config.env"
wait_user

echo -e "\n${YLW}3. Stage and commit the database tuning configuration on 'main':${RST}"
student_command "git add config.env"
wait_user
student_command "git commit -m 'chore: configure database pool size'"
wait_user


print_step 4 "Merge and trigger the conflict"
echo -e "${YLW}Scenario: You are now ready to merge your feature branch back into 'main'.${RST}"
echo -e "${YLW}Let's try to run the merge. Notice how Git flags a conflict on the second line!:${RST}\n"

echo -e "${YLW}1. Attempt to merge 'feature-a' into your active branch ('main'):${RST}"
student_command "git merge feature-a"
wait_user

echo -e "\n${RED}⚠️  MERGE CONFLICT DETECTED!${RST}"
echo -e "${YLW}Because both you and your colleague modified the exact same lines in config.env,${RST}"
echo -e "${YLW}Git has paused the merge and injected visual conflict markers into the file.${RST}\n"

echo -e "${YLW}2. Open and view the conflicted 'config.env' file to inspect the markers:${RST}"
student_command "cat config.env"
wait_user

echo -e "${YLW}How to read the conflict markers:${RST}"
echo -e "  ${BOLD}<<<<<<< HEAD${RST}       → 'HEAD' means your current active branch ('main'). This is YOUR version."
echo -e "  ${BOLD}=======${RST}            → The separator between the two conflicting versions."
echo -e "  ${BOLD}>>>>>>> feature-a${RST}  → This is the INCOMING version from the branch you are merging in."
echo -e "  ${DIM}To resolve: delete all 3 marker lines and keep the content you want from either or both sides.${RST}"
wait_user


print_step 5 "Resolve Conflict (Taking the best of both worlds)"
echo -e "${YLW}Scenario: To resolve the conflict, we do NOT want to throw away any changes!${RST}"
echo -e "${YLW}We want to KEEP BOTH the database pool size and the caching enabled setting.${RST}\n"

echo -e "${YLW}In real life, you would open 'config.env' in a text editor (like VS Code or Nano),${RST}"
echo -e "${YLW}manually delete the marker lines (<<<<<<< HEAD, =======, >>>>>>> feature-a),${RST}"
echo -e "${YLW}rearrange the configurations to keep both, and save the file.${RST}\n"

echo -e "${YLW}To simulate this manual edit easily in our terminal without opening an interactive editor,${RST}"
echo -e "${YLW}we will run a single 'echo' command to write the final merged configuration:${RST}\n"

echo -e "${YLW}1. Resolve the conflict by rewriting 'config.env' containing BOTH configurations:${RST}"
student_command "echo -e 'APP_ENV=production\nDB_POOL_SIZE=20\nCACHE_ENABLED=true' > config.env"
wait_user

echo -e "\n${YLW}2. Verify that 'config.env' now cleanly contains both settings and no markers:${RST}"
student_command "cat config.env"
wait_user

echo -e "\n${YLW}3. Stage the resolved configuration file (marking it as resolved in Git):${RST}"
student_command "git add config.env"
wait_user

echo -e "\n${YLW}4. Commit the merge to finish the resolution successfully:${RST}"
student_command "git commit -m 'merge: resolve conflict by keeping database and cache settings'"
wait_user

echo -e "\n${YLW}5. View the complete, beautiful graph of your merged branches using 'git lg':${RST}"
student_command "git lg"
wait_user

print_summary \
    "Branches represent high-speed, lightweight pointers to specific commits, enabling risk-free isolation." \
    "How to create and switch branches using 'git checkout -b <branch>' and 'git checkout <branch>'." \
    "How Git automatically flags conflicts when the same lines of a file are modified differently in both branches." \
    "How to read Git conflict markers (<<<<<<< HEAD, =======, >>>>>>>) and resolve them on disk." \
    "How to resolve conflicts cleanly by combining both contributions (taking the best of both worlds)." \
    "How to complete a merge conflict resolution by staging the resolved files and running a final commit." \
    "How to review the entire project merge branch history visually using the custom 'git lg' graph."

echo -e "\n${GRN}Module 04 completed!${RST}"
