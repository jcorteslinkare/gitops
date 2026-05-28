#!/usr/bin/env bash
source "$(dirname "$0")/../lib/common.sh"

print_header "Module 01: Introduction (5 min)"

# Setup
REPO_DIR="01-exercise-introduction"
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR" && cd "$REPO_DIR"

print_step 1 "Install Git and check version"
echo -e "${YLW}Before starting, let's ensure Git is installed on your system.${RST}\n"
if command -v dnf >/dev/null 2>&1; then
    student_command "sudo dnf install -y git"
else
    student_command "sudo apt install -y git"
fi
echo -e "\n${YLW}Now let's check its version:${RST}\n"
student_command "git --version"
wait_user

print_step 2 "Install a Terminal UI client (tig)"
echo -e "${YLW}While the CLI is standard, visual tools are great for daily Ops work.${RST}"
echo -e "${YLW}'tig' is an excellent text-mode interface for Git.${RST}\n"
if command -v dnf >/dev/null 2>&1; then
    student_command "sudo dnf install -y tig"
else
    student_command "sudo apt install -y tig"
fi
echo -e "\n${YLW}Let's verify tig is installed:${RST}\n"
student_command "tig --version"
wait_user

print_step 3 "Initialize a new Git repository"
echo -e "${YLW}Scenario: You are starting a brand new infrastructure configuration project.${RST}"
echo -e "${YLW}We are inside our sandboxed training directory: 'training/01-exercise-introduction'.${RST}"
echo -e "${YLW}Let's initialize our very first Git repository!${RST}\n"
student_command "git init"
wait_user

print_step 4 "Verify the Git directory structure"
echo -e "${YLW}Scenario: Git stores all its configuration, history, and internal metadata in a hidden folder.${RST}"
echo -e "${YLW}Let's use 'tree' to look inside the '.git' folder:${RST}\n"
if command -v dnf >/dev/null 2>&1; then
    student_command "sudo dnf install -y tree > /dev/null"
else
    student_command "sudo apt install -y tree > /dev/null"
fi

if [[ "${PLAY_MODE}" == "demo" ]]; then
    echo ""
    execute_command "tree .git"
    sleep 1
    echo -e "\n${YLW}Brief overview of what you are seeing:${RST}"
    echo -e "${YLW} - HEAD     : A file that points to your current active branch.${RST}"
    echo -e "${YLW} - config   : Your repository-specific settings.${RST}"
    echo -e "${YLW} - objects/ : The actual database where snapshots (files and commits) are saved.${RST}"
    echo -e "${YLW} - refs/    : The pointers to your branches (like 'main') and tags.${RST}"
else
    echo -e "\n${YLW}Brief overview of what you will see when you run 'tree .git':${RST}"
    echo -e "${YLW} - HEAD     : A file that points to your current active branch.${RST}"
    echo -e "${YLW} - config   : Your repository-specific settings.${RST}"
    echo -e "${YLW} - objects/ : The actual database where snapshots (files and commits) are saved.${RST}"
    echo -e "${YLW} - refs/    : The pointers to your branches (like 'main') and tags.${RST}"
    echo ""
    student_command "tree .git"
fi
wait_user

print_step 5 "Quick Stage and Commit using tig"
echo -e "${YLW}Let's create a quick file and commit it using our new UI tool.${RST}"
echo -e "${YLW}1. We will create 'hello.txt'.${RST}"
echo -e "${YLW}2. Then open 'tig status'.${RST}"
echo -e "${YLW}3. Inside tig: Press 'u' on 'hello.txt' to stage it.${RST}"
echo -e "${YLW}4. Press 'Shift + C' to open the commit editor, type a message, save and exit.${RST}"
echo -e "${YLW}5. Press 'q' to quit.${RST}\n"
if [[ "${PLAY_MODE}" == "demo" ]]; then
    echo -e "${MAG}$ echo 'Hello Git' > hello.txt && tig status${RST}"
    echo 'Hello Git' > hello.txt
    
    echo -e "\n${DIM}--- Simulating 'tig status' UI ---${RST}"
    echo -e "${CYN}Untracked files:${RST}"
    echo -e "${YLW}?${RST} hello.txt"
    sleep 1.5
    
    echo -e "\n${DIM}(User presses 'u' on hello.txt to stage it...)${RST}\n"
    sleep 1.5
    
    echo -e "${CYN}Changes to be committed:${RST}"
    echo -e "${GRN}A${RST} hello.txt"
    sleep 1.5
    
    echo -e "\n${DIM}(User presses 'Shift+C' to commit...)${RST}\n"
    sleep 1.5
    
    echo -e "${BLU}┌── [ Commit Editor ] ────────────────────────────────────────┐${RST}"
    echo -e "${BLU}│${RST} feat: add hello.txt via UI                                ${BLU}│${RST}"
    echo -e "${BLU}│${RST}                                                           ${BLU}│${RST}"
    echo -e "${BLU}│${RST} ${DIM}# Please enter the commit message for your changes.${RST}       ${BLU}│${RST}"
    echo -e "${BLU}│${RST} ${DIM}# Changes to be committed:${RST}                                ${BLU}│${RST}"
    echo -e "${BLU}│${RST} ${DIM}#       new file:   hello.txt${RST}                             ${BLU}│${RST}"
    echo -e "${BLU}└─────────────────────────────────────────────────────────────┘${RST}"
    sleep 2
    
    echo -e "\n${DIM}(User saves, exits the editor, and quits 'tig'...)${RST}\n"
    git add hello.txt
    git commit -m "feat: add hello.txt via UI" > /dev/null
    sleep 1
    
    echo -e "\n${YLW}Let's verify the commit was created successfully:${RST}"
    execute_command "git log --oneline"
else
    student_command "echo 'Hello Git' > hello.txt && tig status"
    
    echo -e "\n${YLW}Let's verify the commit was created successfully:${RST}"
    student_command "git log --oneline"
fi

wait_user

print_summary \
    "How to install Git and a Terminal UI client (tig)." \
    "How to verify the installed Git version using 'git --version'." \
    "How to initialize a fresh, empty Git repository using 'git init'." \
    "Understanding that Git stores 100% of its history and config in the hidden '.git' folder." \
    "How to perform a quick stage and commit operation using 'tig status'."

echo -e "\n${GRN}Module 01 completed!${RST}"
