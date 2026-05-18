#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 01: Introduction (5 min)"

print_step 1 "Check Git version"
student_command "git --version"
wait_user

print_step 2 "Create a test directory"
student_command "mkdir -p 01-exercise-introduction && cd 01-exercise-introduction"
echo "Current directory: $(pwd)"
wait_user

print_step 3 "Initialize Git repository"
student_command "git init"
wait_user

print_step 4 "Verify .git directory"
student_command "ls -la"
echo -e "\n${GRN}Module 01 completed!${RST}"
