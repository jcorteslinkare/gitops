#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 07: Git Hooks (10 min)"

# Setup
REPO_DIR="07-exercise-hooks"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "Explore Git's default Hook templates"
echo -e "${YLW}Scenario: Let's see how Git structures hooks by default under the hood.${RST}"
echo -e "${YLW}When you run 'git init', Git automatically creates a '.git/hooks/' directory.${RST}"
echo -e "${YLW}This folder is NOT empty; it is pre-populated with default template files ending in '.sample'!${RST}\n"

echo -e "${YLW}1. Let's list the contents of the default hooks folder. Notice all the '.sample' templates:${RST}"
student_command "ls -l .git/hooks/"
wait_user

echo -e "\n${YLW}Note: Git ignores all '.sample' files. To activate a hook, we must create a file${RST}"
echo -e "${YLW}named EXACTLY after the hook event (e.g. 'pre-commit') and make it executable.${RST}"
wait_user

print_step 2 "Create our custom pre-commit hook"
echo -e "${YLW}Scenario: We will now create our own custom 'pre-commit' hook (without the '.sample' suffix).${RST}"
echo -e "${YLW}Our goal is to automatically block any commit that contains unfinished 'TODO' tasks!${RST}"
echo -e "${YLW}We are writing the following shell script to '.git/hooks/pre-commit':${RST}\n"

# Output the script code in a beautiful box
echo -e "${BLU}╔══════════════════════════════════════════════════════════════════╗${RST}"
echo -e "${BLU}║${RST} ${BOLD}.git/hooks/pre-commit${RST}                                           ${BLU}║${RST}"
echo -e "${BLU}╠══════════════════════════════════════════════════════════════════╣${RST}"
echo -e "${BLU}║${RST} #!/bin/sh                                                        ${BLU}║${RST}"
echo -e "${BLU}║${RST} # Check if any of the staged files contain the word 'TODO'       ${BLU}║${RST}"
echo -e "${BLU}║${RST} if grep -q \"TODO\" \$(git diff --cached --name-only); then        ${BLU}║${RST}"
echo -e "${BLU}║${RST}     echo \"ERROR: Remove TODOs before committing!\"                 ${BLU}║${RST}"
echo -e "${BLU}║${RST}     exit 1                                                       ${BLU}║${RST}"
echo -e "${BLU}║${RST} fi                                                              ${BLU}║${RST}"
echo -e "${BLU}╚══════════════════════════════════════════════════════════════════╝${RST}\n"

HOOK_FILE=".git/hooks/pre-commit"
cat <<EOF > "$HOOK_FILE"
#!/bin/sh
if grep -q "TODO" \$(git diff --cached --name-only); then
    echo "ERROR: Remove TODOs before committing!"
    exit 1
fi
EOF

echo -e "${YLW}1. Let's verify that our custom pre-commit hook file has been created:${RST}"
student_command "cat $HOOK_FILE"
wait_user

echo -e "\n${YLW}2. By default, scripts in Linux do not have execute permissions. We must grant them${RST}"
echo -e "${YLW}using 'chmod +x' so that Git is allowed to run this hook before every commit:${RST}"
student_command "chmod +x $HOOK_FILE"
wait_user

print_step 3 "Test the Hook (Block Unfinished Work)"
echo -e "${YLW}Scenario: Now let's try to commit a script containing an unfinished 'TODO' comment.${RST}"
echo -e "${YLW}Our pre-commit hook should automatically detect it and block our commit!${RST}\n"

# Create the file with TODO
echo "Fix the server config # TODO" > setup.sh

echo -e "${YLW}1. Stage the file for commit:${RST}"
student_command "git add setup.sh"
wait_user

echo -e "\n${YLW}2. Attempt to commit. Notice how our pre-commit hook aborts the operation:${RST}"
student_command "git commit -m 'chore: add setup script'"
echo -e "\n${GRN}Success: The commit was blocked as expected by our automated hook!${RST}"
wait_user

print_step 4 "Fix the issue and commit"
echo -e "${YLW}Scenario: Let's remove the 'TODO' comment to satisfy the hook, and try committing again.${RST}\n"

echo -e "${YLW}1. Remove the '# TODO' comment from setup.sh:${RST}"
student_command "sed -i 's/ # TODO//' setup.sh"
wait_user

echo -e "\n${YLW}2. Stage the resolved file:${RST}"
student_command "git add setup.sh"
wait_user

echo -e "\n${YLW}3. Commit again. This time it should succeed perfectly!${RST}"
student_command "git commit -m 'chore: add setup script without todo'"
wait_user

print_summary \
    "What Git Hooks represent (event-driven scripts executed locally on your machine)." \
    "Understanding the role of the default '.git/hooks/' templates directory and '.sample' files." \
    "Why execution permissions ('chmod +x') are absolutely required for Git to run hooks." \
    "How 'pre-commit' hooks act as automated local security and quality gates (e.g., blocking secrets/unfinished work)." \
    "Standardizing commit workflows using Conventional Commits ('chore:', 'feat:', 'fix:')." \
    "How hooks dramatically improve DevOps quality by enforcing standards locally before any remote pushes."

echo -e "\n${GRN}Module 07 completed!${RST}"
