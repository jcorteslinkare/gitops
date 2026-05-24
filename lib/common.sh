#!/usr/bin/env bash

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'
BLU='\033[0;34m'; MAG='\033[0;35m'; CYN='\033[1;36m'
BOLD='\033[1m'; DIM='\033[2m'; RST='\033[0m'
# Ensure Git uses English locale for presentation
export LANG=C
# Setup training directory (ignored by git in the workspace root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TRAINING_DIR="${SCRIPT_DIR}/../training"
mkdir -p "${TRAINING_DIR}"
cd "${TRAINING_DIR}"


CURRENT_HEADER=""

function print_header() {
    CURRENT_HEADER="$1"
    echo -e "${BLU}>>> ${CURRENT_HEADER}${RST}"
}

function print_step() {
    clear
    if [[ -n "${CURRENT_HEADER}" ]]; then
        echo -e "${BLU}>>> ${CURRENT_HEADER}${RST}"
    fi
    echo -e "\n${BOLD}Step $1: $2${RST}"
}

function print_summary() {
    echo -e "\n${GRN}================================================================${RST}"
    echo -e "${BOLD}${GRN}🎓 RECAP: What You Learned in this Module!${RST}"
    echo -e "${GRN}================================================================${RST}"
    for line in "$@"; do
        echo -e "  ${GRN}✔${RST} $line"
    done
    echo -e "${GRN}================================================================${RST}"
    wait_reading
}

function wait_user() {
    if [[ "${PLAY_MODE}" == "interactive" ]]; then
        return 0
    fi
    echo -e "\n${DIM}Press [Enter] to continue...${RST}"
    read -r
}

function wait_reading() {
    echo -e "\n${DIM}Press [Enter] to continue...${RST}"
    read -r
}

function execute_command() {
    echo -e "${MAG}$ $1${RST}"
    eval "$1"
}

function student_command() {
    if [[ "${PLAY_MODE}" == "interactive" ]]; then
        echo -e "\n${CYN}👉 YOUR TURN: Run this command in your terminal:${RST}"
        echo -e "${BOLD}${MAG}$ $1${RST}"
        echo -e "${DIM}[Type the command, explore, then type 'exit' or Ctrl+D to continue]${RST}\n"
        
        export SUGGESTED_COMMAND="$1"
        if [ -f ~/.bashrc ]; then
            bash --rcfile <(echo 'source ~/.bashrc; PS1="\[\033[1;36m\](hands-on)\[\033[0m\] \w \$ "') -i
        else
            PS1="\[\033[1;36m\](hands-on)\[\033[0m\] \w \$ " bash -i
        fi
        
        # Erase the 'exit' message printed by the interactive bash shell termination
        printf "\033[1A\033[2K"
        
        # Synchronize directory changes (cd) back to the parent process if necessary
        if [[ "$1" == cd\ * ]]; then
            eval "$1"
        fi
    else
        echo -e "${MAG}$ $1${RST}"
        eval "$1"
    fi
}

# Wrapper for git to ensure new repositories default to 'main' branch
# without changing the user's global git configuration.
function git() {
    if [[ "$1" == "init" ]]; then
        command git init -b main "${@:2}"
    else
        command git "$@"
    fi
}

