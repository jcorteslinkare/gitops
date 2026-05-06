#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 07: Git Hooks (10 min)"

# Setup
REPO_DIR="exercise-hooks"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "Create a pre-commit hook"
HOOK_FILE=".git/hooks/pre-commit"
cat <<EOF > "$HOOK_FILE"
#!/bin/sh
if grep -q "TODO" \$(git diff --cached --name-only); then
    echo "ERROR: Remove TODOs before committing!"
    exit 1
fi
EOF
execute_command "chmod +x $HOOK_FILE"
wait_user

print_step 2 "Try to commit a file with TODO"
echo "Fix the server config # TODO" > setup.sh
execute_command "git add setup.sh"
echo -e "${YLW}Trying to commit...${RST}"
execute_command "git commit -m 'add setup script'"
echo -e "\n${GRN}Commit blocked as expected!${RST}"
wait_user

print_step 3 "Fix and commit"
execute_command "sed -i 's/ # TODO//' setup.sh"
execute_command "git add setup.sh"
execute_command "git commit -m 'add setup script without todo'"

echo -e "\n${GRN}Module 07 completed!${RST}"
