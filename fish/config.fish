if status is-interactive
end

# Utils alias

# rm alias
alias rm='rm -I'

# Ls alias
alias ls='ls -CF --color=auto'
alias la='ls -A'
alias lah='ls -Alh'

# Tree alias
alias tree='tree -FC'
alias tlea='tree -FCa'
alias tlee='tree -FCL'
alias tlea='tree -FCaL'

# Git alias
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -m'
alias gl='git log --oneline'
alias gac='git commit -am'
alias gb='git branch -v'
alias gps='git push'
alias gpl='git pull'
alias gcl='git clone'
alias gd='git diff'

# CD alias
abbr -a ...   '../..'
abbr -a ....  '../../..'
abbr -a ..... '../../../..'
abbr -a ...... '../../../../..'
abbr -a ....... '../../../../../..'
abbr -a ........ '../../../../../../..'
abbr -a ......... '../../../../../../../..'
abbr -a .......... '../../../../../../../../..'

# Editor alias
alias v='vim'
alias nv='vim'

# Copy alias
alias cp='cp -i'
alias df='df -h'

# Grep alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Coding alias
alias nrd='npm run dev'
alias nrb='npm run build'
alias yrd='yarn run dev'
alias yrb='yarn run build'
alias brd='bun run dev'
alias bb='bun run build'
alias bs='bun start'
alias bbs='bun run build && bun start'

# Docker alias
alias dcmp='docker-compose'


# Created by `pipx` on 2025-04-24 02:45:18
set PATH $PATH /home/woragis/.local/bin

