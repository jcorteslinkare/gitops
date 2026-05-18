#!/usr/bin/env bash

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'
BLU='\033[0;34m'; MAG='\033[0;35m'
BOLD='\033[1m'; DIM='\033[2m'; RST='\033[0m'

# Setup training directory (ignored by git in the workspace root)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TRAINING_DIR="${SCRIPT_DIR}/../training"
mkdir -p "${TRAINING_DIR}"
cd "${TRAINING_DIR}"


function print_header() {
    echo -e "${BLU}>>> $1${RST}"
}

function print_step() {
    echo -e "\n${BOLD}Step $1: $2${RST}"
}

function wait_user() {
    echo -e "\n${DIM}Press [Enter] to continue...${RST}"
    read -r
}

function execute_command() {
    echo -e "${MAG}$ $1${RST}"
    eval "$1"
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

