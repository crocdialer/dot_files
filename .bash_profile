#make sure stuff in /usr/local/bin is found first
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/X11/bin"

# Python 2.7 (installed via brew)
export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"
export PATH="/usr/local/share/python:$PATH"

# Google Go
export GOPATH="$HOME/dev/go"

# Node.js
export PATH="/usr/local/share/npm/bin:$PATH"

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_TYPE=de_DE.UTF-8

# bash completion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# define some bash aliases
alias ll='ls -lG'
alias systail='tail -f /var/log/system.log'

export CLICOLOR=1

# Android
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk

# Android NDK
export ANDROID_NDK=/usr/local/android-ndk-current
export ANDROID_NDK_TOOLCHAIN_ROOT=$ANDROID_NDK/android-toolchain

# Artcom Mobile Spark
export MOBILE_SPARK="/Users/Fabian/dev/artcom/mobile-spark"

export EDITOR="/usr/local/bin/mvim"

###############
# GIT SUPPORT #
###############

## Returns "*" if the current git branch is dirty.
function parse_git_dirty {
    [[ $(git diff --shortstat 2> /dev/null | tail -n1) != "" ]] && echo "*"
}

# Returns "|shashed:N" where N is the number of stashed states (if any).
function parse_git_stash {
    local stash=`expr $(git stash list 2>/dev/null| wc -l)`
    if [ "${stash}" != "0" ]
    then
        echo "|stashed:$stash"
    fi
}
#
## Get the current git branch name (if available)
git_prompt() {
    local ref=$(git symbolic-ref HEAD 2>/dev/null | cut -d'/' -f3)
    if [ "${ref}" != "" ]
    then
        echo " ($ref$(parse_git_dirty)$(parse_git_stash))"
    fi
}

export PS1="\h:\W \u\$(git_prompt)\$ "
