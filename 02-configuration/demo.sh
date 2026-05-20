#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 02: Configuration (5 min)"

# Setup a sandboxed local repository to demonstrate local vs global configuration scoping
REPO_DIR="02-exercise-configuration"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"
git init > /dev/null

print_step 1 "Set your global identity"
echo -e "${YLW}Scenario: Before making any commits, Git needs to know who you are.${RST}"
echo -e "${YLW}Global settings apply to ALL your repositories for your active operating system user.${RST}\n"

echo -e "${YLW}1. Configure your global commit username:${RST}"
student_command "git config --global user.name \"Ops Student\""
wait_user

echo -e "\n${YLW}2. Configure your global commit email address (e.g., your personal email):${RST}"
student_command "git config --global user.email \"student@personal-hub.com\""
wait_user


print_step 2 "Best Practice: Scoping & Local Overrides"
echo -e "${RED}⚠️ BEST PRACTICE WARNING:${RST}"
echo -e "${YLW}Using '--global' for your email is convenient, but blindly using it everywhere is a common mistake.${RST}"
echo -e "${YLW}In professional life, you will work on corporate projects (using your work email)${RST}"
echo -e "${YLW}and personal/open-source projects (using your personal email). You must keep them separate!${RST}\n"

echo -e "${BOLD}Git has 3 Scopes of Configuration:${RST}"
echo -e "  * ${BOLD}--system${RST}: Entire system (all users) - stored in /etc/gitconfig"
echo -e "  * ${BOLD}--global${RST}: Active OS user (all repositories) - stored in ~/.gitconfig"
echo -e "  * ${BOLD}--local${RST} (default): Active repository ONLY - stored in .git/config\n"

echo -e "${YLW}Scenario: This repository is a corporate project. We want to override our email${RST}"
echo -e "${YLW}with our company address ONLY inside this directory, without affecting other repos.${RST}\n"

echo -e "${YLW}1. Configure your local email (without '--global', which defaults to '--local'):${RST}"
student_command "git config user.email \"student@corporate-work.com\""
wait_user

echo -e "\n${YLW}2. Verify that this repository is using the corporate email:${RST}"
student_command "git config user.email"
wait_user

echo -e "\n${YLW}3. Verify that your global configuration still safely preserves your personal email:${RST}"
student_command "git config --global user.email"
wait_user

echo -e "\n${YLW}4. Clean up the global identity we created so we don't pollute your machine:${RST}"
student_command "git config --global --unset user.name"
wait_user
student_command "git config --global --unset user.email"
wait_user


print_step 3 "Add useful Ops aliases"
echo -e "${YLW}Scenario: Typing long Git commands hundreds of times a day is inefficient.${RST}"
echo -e "${YLW}Let's configure 'git st' for status, and a beautiful visual log shortcut 'git lg'.${RST}\n"

echo -e "${YLW}First, let's create a quick commit behind the scenes so we can test our log...${RST}"
echo "test" > dummy.txt
git add dummy.txt
git config user.email "student@corporate-work.com"  # ensure local config is used for commit
git config user.name "Ops Student"                  # need a local name too since we unset global
git commit -m "chore: initial commit" > /dev/null
echo "test2" >> dummy.txt
git commit -am "feat: added more tests" > /dev/null

echo -e "\n${YLW}1. Run the standard verbose 'git log':${RST}"
student_command "git log"
wait_user

echo -e "\n${YLW}2. Create the 'git lg' alias for a beautiful, graph-based oneline log:${RST}"
student_command "git config --global alias.lg \"log --graph --oneline --all --decorate\""
wait_user

echo -e "\n${YLW}3. Run our new 'git lg' alias and compare:${RST}"
student_command "git lg"
wait_user

echo -e "\n${YLW}4. Run the standard 'git status':${RST}"
student_command "git status"
wait_user

echo -e "\n${YLW}5. Create and test the 'git st' alias (the output will be identical):${RST}"
student_command "git config --global alias.st status"
wait_user
student_command "git st"
wait_user


print_step 4 "Verify your Git configuration list"
echo -e "${YLW}Scenario: Let's view the configuration list to see both local and global values in action:${RST}\n"

echo -e "${YLW}1. List only the global configuration values:${RST}"
student_command "git config --global --list"
wait_user

echo -e "\n${YLW}2. List all configuration values (local overrides global inside this repository):${RST}"
student_command "git config --list"
wait_user

print_summary \
    "The 3 Git configuration levels: --system (machine), --global (OS user), and --local (repository)." \
    "Best Practice: Never use '--global' blindly for your commit email to avoid personal vs work address leakage." \
    "How to override global settings locally using 'git config user.email' (local-only config)." \
    "How to configure high-speed productivity shortcuts (aliases) like 'git st' and 'git lg'." \
    "How to verify and view active configurations using 'git config --list' and 'git config --global --list'."

echo -e "\n${GRN}Module 02 completed!${RST}"
