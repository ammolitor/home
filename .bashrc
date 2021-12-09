# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

source /usr/local/share/bash-completion/bash_completion
complete -C /usr/local/bin/aws_completer aws
source <(kubectl completion bash)
# Source git-prompt
if [ -f /opt/src/git/git-2.30.0/contrib/completion/git-prompt.sh ]; then
    source  /opt/src/git/git-2.30.0/contrib/completion/git-prompt.sh
fi

# User dependent .bashrc file
export PATH=${PATH}:${HOME}/bin
export EDITOR=vim

# Shell Options
# See man bash for more options...
shopt -s histappend
shopt -s cdspell
shopt -s globstar


# set indent string for xmllint
export XMLLINT_INDENT="    "

# Set my command line editor to vi
set -o vi

# History Options
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups:erasedups
export HISTFILESIZE=10000
export HISTIGNORE="ls:la:ll:cd:cd ..:git st:pwd:clear:celar:ckear:clea:history:exit"
export HISTTIMEFORMAT='%F %T '

# Aliases
alias grep='grep --color'          # show grep string in colour
alias egrep='egrep --color=auto'   # show differences in colour
alias fgrep='fgrep --color=auto'   # show differences in colour

# Some shortcuts for different directory listings
alias ls='/bin/ls -lhG'
alias ll='/bin/ls -lhG'
alias la='/bin/ls -lhAG'
alias tree='tree -C'
# alias vim='/Applications/MacVim.app/Contents/bin/vim'
alias nproc='sysctl -n hw.ncpu'

# alias check-mvn-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) -o \( -name \*derby\* -o -path \*derby\* \) -o \( -name \*hbase\* -o -path \*hbase\* \) -o \( -name \*spark\* -o -path \*spark\* \) \)'
# alias clean-mvn-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) -o \( -name \*derby\* -o -path \*derby\* \) -o \( -name \*hbase\* -o -path \*hbase\* \) -o \( -name \*spark\* -o -path \*spark\* \) \) -exec rm -rf {} \;'
# alias clean-mvn-splice-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) \) -exec rm -rf {} \;'
alias nuke-mvn-repo='find ${HOME}/.m2/repository -mindepth 1 -maxdepth 1 -type d -exec rm -rf '{}' \;'

alias clean-source-tree="git clean -ndx | awk '! /iml/ && ! /\.idea/ && ! /.stignore/ {print $3}' | xargs rm -rf"

export GOROOT=/usr/local/go
export GOPATH=${HOME}/go
export PATH=${GOPATH}/bin:${GOROOT}/bin:${PATH}

reset-git-fork () {
    branch=$(git rev-parse --abbrev-ref HEAD)
    git fetch upstream
    git remote prune upstream
    git fetch origin
    git remote prune origin
    git reset upstream/"${branch}" --hard
    git push origin "${branch}" --force
}

update-git-fork () {
    branch=$(git rev-parse --abbrev-ref HEAD)
    git reset HEAD --hard
    git fetch upstream
    git remote prune upstream
    git rebase upstream/"${branch}"
    git push origin "${branch}"
}

dhub_login () { 
    cat ${HOME}/.dockerhub | docker login --username ammolitor --password-stdin
}

dhub_fdb_login () { 
    cat ${HOME}/.dockerhub_fdb | docker login --username foundationdb --password-stdin
}

dapple_login () {
    cat ${HOME}/.artifactory | docker login --username amolitor --password-stdin docker.apple.com
}

decr_login () {
    AWS_ACCOUNT=$(aws --output text sts get-caller-identity --query 'Account')
    AWS_REGION=$(aws configure get region)
    aws ecr get-login-password | docker login --username AWS --password-stdin  ${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com
}

mac_ec2_session_release () {
    aws ssm start-session --target $(aws --output text ec2 describe-instances --filters Name=tag:Name,Values=FDB-Development-EC2-Mac-Instance-ReleaseBuild    Name=instance-state-name,Values=running --query 'Reservations[].Instances[?InstanceType==`mac1.metal`].InstanceId')
}

mac_ec2_session_pr () {
    aws ssm start-session --target $(aws --output text ec2 describe-instances --filter Name=tag:Name,Values=FDB-Development-EC2-Mac-Instance-PullRequestBuild Name=instance-state-name,Values=running --query 'Reservations[].Instances[?InstanceType==`mac1.metal`].InstanceId')
}

function diff_sections {
  vim -d <(head -$3 $1 | tail +$2) <(head -$5 $1 | tail +$4)
}

# for python using custom CA 
# SSL_CERT_FILE=/System/Library/OpenSSL/cert.pem
# REQUESTS_CA_BUNDLE=/System/Library/OpenSSL/cert.pem

# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# PS1 colors variable
reset=$(tput sgr0)
bold=$(tput bold)

black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
gray=$(tput setaf 8)
default=$(tput setaf 9)

#bg_black=$(tput setab 0)
#bg_red=$(tput setab 1)
#bg_green=$(tput setab 2)
#bg_yellow=$(tput setab 3)
#bg_blue=$(tput setab 4)
#bg_magenta=$(tput setab 5)
#bg_cyan=$(tput setab 6)
#bg_white=$(tput setab 7)
#bg_default=$(tput setab 9)

PS1='\[\e]0;\h:\w\a\]\[$bold$gray\][\[$reset\]\[$cyan\]\D{%T}\[$reset\] \[$green\]\w\[$reset\]\[$bold$gray\]]\[$reset\]\[$yellow\]$(__git_ps1)\[$reset\]
\[$bold$blue\]\u\[$reset\]@\[$bold$gray\]\h\[$reset\]> '
