#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 01: Introduction (5 min)"

# Setup
REPO_DIR="01-exercise-introduction"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"

print_step 1 "Check Git version"
echo -e "${YLW}Before starting, let's verify if Git is installed on your system and check its version:${RST}\n"
student_command "git --version"
wait_user

print_step 2 "Initialize a new Git repository"
echo -e "${YLW}Scenario: You are starting a brand new infrastructure configuration project.${RST}"
echo -e "${YLW}We are inside our sandboxed training directory: 'training/01-exercise-introduction'.${RST}"
echo -e "${YLW}Let's initialize our very first Git repository!${RST}\n"
student_command "git init"
wait_user

print_step 3 "Verify the Git directory"
echo -e "${YLW}Scenario: Git stores all its configuration, history, and internal metadata in a hidden folder.${RST}"
echo -e "${YLW}Let's list all files, including hidden ones, to see the newly created '.git' folder:${RST}\n"
student_command "ls -la"

echo -e "\n${GRN}Module 01 completed!${RST}"
