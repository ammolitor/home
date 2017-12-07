# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	source /etc/bashrc
fi

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

source /usr/local/share/bash-completion/bash_completion

complete -C /Library/Frameworks/Python.framework/Versions/2.7/bin/aws_completer aws

# Source git-prompt
if [ -f /opt/src/bash-completion/others/git-prompt.sh ]; then
	source  /opt/src/bash-completion/others/git-prompt.sh
fi

# User dependent .bashrc file
export PATH=${PATH}:${HOME}/bin
export EDITOR=vim

# Shell Options
# See man bash for more options...
shopt -s histappend
shopt -s cdspell
shopt -s globstar

# for java nonsense
export J8_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_144.jdk/Contents/Home"
export JAVA_HOME=${J8_HOME}
export PATH="${JAVA_HOME}/bin:${PATH}"

# for maven, java builds
export M2_HOME="/opt/maven/default"
export M2=${M2_HOME}/bin
export PATH="${M2}:${PATH}"
export MAVEN_OPTS="-Xmx4g -Djava.awt.headless=true"
source ${HOME}/bin/colorize-maven.sh

export ANT_HOME="/opt/ant/default"
export PATH="${ANT_HOME}/bin:${PATH}"

export JMETER_HOME="/opt/jmeter/default"
export PATH="${JMETER_HOME}/bin:${PATH}"

export GRADLE_HOME="/opt/gradle/default"
export PATH="${GRADLE_HOME}/bin:${PATH}"

export GROOVY_HOME="/opt/groovy/default"
export PATH="${GROOVY_HOME}/bin:${PATH}"

export SCALA_HOME="/opt/scala/default"
export PATH="${SCALA_HOME}/bin:${PATH}"

export SBT_HOME="/opt/sbt/default"
export PATH="${SBT_HOME}/bin:${PATH}"

export GOPATH="${HOME}/go"
export GOROOT="/usr/local/go"
export PATH="${GOROOT}/bin:${PATH}"
export PATH=${HOME}:/usr/local/bin:${PATH}

export HASHICORP_HOME="/opt/hashicorp"
export PATH="${HASHICORP_HOME}:${PATH}"

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
# alias python='/usr/local/bin/python2.7'
alias grep='grep --color'          # show grep string in colour
alias egrep='egrep --color=auto'   # show differences in colour
alias fgrep='fgrep --color=auto'   # show differences in colour

# Some shortcuts for different directory listings
alias ls='/bin/ls -lhG'
alias ll='/bin/ls -lhG'
alias la='/bin/ls -lhAG'
alias tree='tree -C'

# alias check-mvn-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) -o \( -name \*derby\* -o -path \*derby\* \) -o \( -name \*hbase\* -o -path \*hbase\* \) -o \( -name \*spark\* -o -path \*spark\* \) \)'
# alias clean-mvn-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) -o \( -name \*derby\* -o -path \*derby\* \) -o \( -name \*hbase\* -o -path \*hbase\* \) -o \( -name \*spark\* -o -path \*spark\* \) \) -exec rm -rf {} \;'
# alias clean-mvn-splice-repo='find ${HOME}/.m2/repository \( \( -name \*splice\* -o -path \*splice\* \) \) -exec rm -rf {} \;'
alias nuke-mvn-repo='find ${HOME}/.m2/repository -mindepth 1 -maxdepth 1 -type d -exec rm -rf '{}' \;'

alias clean-source-tree="git clean -ndx | awk '! /iml/ && ! /\.idea/ {print $3}' | xargs rm -rf"

# a) function settitle
settitle () 
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

# PS1 colors variable
reset=$(tput sgr0)
bold=$(tput bold)

black=$(tput setaf 0)
#red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
#magenta=$(tput setaf 5)
#cyan=$(tput setaf 6)
#white=$(tput setaf 7)
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

PS1='\[\e]0;\h:\w\a\]\[$bold$black\][\[$reset\]\[$green\]\w\[$reset\]\[$bold$black\]]\[$reset\]\[$yellow\]$(__git_ps1)\[$reset\]
\[$bold$blue\]\u\[$reset\]@\[$bold$black\]\h\[$reset\]> '
