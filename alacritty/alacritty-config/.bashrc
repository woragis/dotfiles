# Terminal Customization
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# better commands
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias la='ls -A --color=auto'

# git config
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gl='git log --oneline'
alias gb='git branch'
alias gd='git diff'


# 0 normal, 1 bold, 2 dim, 4 underline, 5 none
normal_text_formatting="\e[0;m"
bold_text_formatting="\e[1;m"
dim_text_formatting="\e[2;m"
# some_text_formatting="\e[3;m"
underline_text_formatting="\e[4;m"
none_text_formatting="\e[5;m"

color_black="\e[30m"
color_red="\e[31m"
color_green="\e[32m"
color_yellow="\e[33m"
color_blue="\e[34m"
color_magenta="\e[35m"
color_cyan="\e[36m"
color_white="\e[37m"

bg_black="\e[40m"
bg_red="\e[41m"
bg_green="\e[42m"
bg_yellow="\e[43m"
bg_blue="\e[44m"
bg_magenta="\e[45m"
bg_cyan="\e[46m"
bg_white="\e[47m"

parse_git_branch_bg() {
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  branch=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "$branch" ]; then
    echo -e "${bg_red}($branch)${reset_color}"
  else
    echo ""
  fi
}
parse_git_branch() {
  branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  branch=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "$branch" ]; then
    echo -e "${git_branch_color}($branch)"
  else
    echo ""
  fi
}

# PS1 color
user_color=$color_green
host_color=$color_white
domain_symbol_color="\e[1;32m"
domain_symbol_color=$color_green
dir_color=$color_cyan
reset_color="\e[0m"
git_branch_color=$color_red
ubuntu_ps1="${user_color}\u${domain_symbol_color}@${host_color}\h ${dir_color}\W${reset_color} $ "
bracket=$color_white

user_ps1_f="${user_color}\u@\h"
dir_ps1_f="${dir_color}\w"
git_branch_ps1_f="\$(parse_git_branch)"

default_ps1="[\u@\h \W] $ "
min_ps1="${bracket}[${user_ps1_f} ${dir_ps1_f}${bracket}]${git_branch_ps1_f}${reset_color}\n\$ "
max_ps1="${color_black}${bg_green}\u@\h ${reset_color}${bg_blue}\w>\$(parse_git_branch_bg)${reset_color}\n\$ "

PS1=$min_ps1


# export TERM=alacritty
# cp /etc/skel/.bashrc~
