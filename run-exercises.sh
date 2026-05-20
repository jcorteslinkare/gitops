#!/usr/bin/env bash
# =============================================================================
# Git for Ops — Exercise Runner
# Guided interactive exercises for Git training
# =============================================================================

RED='\033[0;31m'; GRN='\033[0;32m'; YLW='\033[1;33m'
BLU='\033[0;34m'; MAG='\033[0;35m'
BOLD='\033[1m'; DIM='\033[2m'; RST='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

modules=(
    "01-introduction"
    "02-configuration"
    "03-basic-workflow"
    "04-branching-merging"
    "05-remotes-collaboration"
    "06-ops-power-tools"
    "07-git-hooks"
    "08-gitops-intro"
)

labels=(
    "Introduction to Git for Ops (5 min)"
    "Initial Setup & Productivity (5 min)"
    "Basic Workflow (add/commit) (15 min)"
    "Branching & Conflict Resolution (25 min)"
    "Remotes & Team Collaboration (10 min)"
    "Ops Power Tools (stash/cherry-pick) (15 min)"
    "Git Hooks & Automation (10 min)"
    "Introduction to GitOps (5 min)"
)

function show_menu() {
    clear
    echo -e "${BLU}╔══════════════════════════════════════════════════════════════════╗${RST}"
    echo -e "${BLU}║${RST}                 ${BOLD}Git for Ops — Hands-on Workshop${RST}                  ${BLU}║${RST}"
    echo -e "${BLU}╚══════════════════════════════════════════════════════════════════╝${RST}"
    echo
    echo -e "  ${BOLD}Available Modules:${RST}"
    for i in "${!modules[@]}"; do
        echo -e "    ${YLW}$((i+1))${RST}  ${labels[$i]}"
    done
    echo
    echo -e "  ${DIM}Usage: ./run-exercises.sh <module_number>${RST}"
    echo -e "  ${DIM}Example: ./run-exercises.sh 3${RST}"
    echo
}

if [[ -n "${1:-}" ]] && [[ "$1" =~ ^[1-8]$ ]]; then
    selected=$((${1} - 1))
    dir="${modules[$selected]}"
    
    echo -e "${BOLD}Choose Training Mode:${RST}"
    echo -e "  ${YLW}1${RST}  ${BOLD}Hands-on Mode${RST} (Interactive - you type the commands yourself)"
    echo -e "  ${YLW}2${RST}  ${BOLD}Demo Mode${RST} (Automated - the script runs them for you)"
    echo
    read -p "Selection [1-2, default: 1]: " mode_choice
    mode_choice=${mode_choice:-1}
    
    if [[ "$mode_choice" == "1" ]]; then
        export PLAY_MODE="interactive"
        echo -e "\n  ${GRN}→ Starting Module ${1} in Hands-on Mode!${RST}"
    else
        export PLAY_MODE="demo"
        echo -e "\n  ${GRN}→ Starting Module ${1} in Demo Mode!${RST}"
    fi
    echo
    
    if [[ -f "${SCRIPT_DIR}/${dir}/demo.sh" ]]; then
        bash "${SCRIPT_DIR}/${dir}/demo.sh"
        exit 0
    else
        echo -e "${RED}Error: demo.sh not found in ${dir}${RST}"
        exit 1
    fi
fi

show_menu
