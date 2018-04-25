#!/bin/bash -x

source /host/settings.sh

echo $DOMAIN > /etc/hostname

cat <<EOF > /root/.bash_aliases
alias mysql='mysql --host=$DBHOST --port=$DBPORT --user=$DBUSER --password=$DBPASS --database=$DBNAME'
#alias git='hub'
alias g='git status -sb'
alias gh='git hist'
alias gp='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull --rebase && git push'
alias gf='git fetch'
alias gb='git branch'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gcv='git commit --no-verify'
alias gd='git diff --color-words'
alias gdc='git diff --cached -w'
alias gdw='git diff --no-ext-diff --word-diff'
alias gdv='git diff'
alias gl='git log --oneline --decorate'
alias gt='git tag'
alias grc='git rebase --continue'
alias grs='git rebase --skip'
alias gsl='git stash list'
alias gss='git stash save'
EOF

cat <<EOF > /root/.gitconfig
[alias]
    hist = log --color --pretty=format:\"%C(yellow)%h%C(reset) %s%C(bold red)%d%C(reset) %C(green)%ad%C(reset) %C(blue)[%an]%C(reset)\" --relative-date --decorate
    unstage = reset HEAD --
    restore = checkout --
    cn = commit --no-verify
    co = checkout
    praise = blame
    visualise = !gitk
    graph = log --color --graph --pretty=format:\"%h | %ad | %an | %s%d\" --date=short
EOF
