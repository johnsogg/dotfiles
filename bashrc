# User specific aliases and functions

BASHRC_LOADED=true

# 'classpath munge' for adding a a jar or directory to the classpath.
# Use the second argument 'after' if you want to place the new entry
# at the end. Otherwise the entry is placed at the front.
#
# example:
#
#  cpmunge foo.jar
#  cpmunge /home/johnsogg/proj
#  cpmunge bar.jar after
#
# This will result in CLASSPATH = "/home/johnsogg/proj:foo.jar:bar.jar"
cpmunge () {
        if ! echo $CLASSPATH | grep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "after" ] ; then
              CLASSPATH=$CLASSPATH:$1
           else
              CLASSPATH=$1:$CLASSPATH
           fi
        fi
}

# Add all the jars in the input directory to the classpath. This uses
# the cpmunge function above.
#
# example:
# 
#  addjars /home/johnsogg/proj/lib
addjars () {
    for thejar in $1/*.jar
      do
      if [ -f "$thejar" ]; then
          cpmunge "$thejar"
      fi
    done
}

# Add something to the PATH environment variable. By default the new entry
# will go at the end. If you need it to go at the beginning, use 'before' as
# the second argument. Example:
#
#  pathmunge /usr/local/bin
#  pathmunge /opt/bin
#  pathmunge $HOME/bin before
#
# This results in PATH = /home/johnsogg/bin:/usr/local/bin:/opt/bin
pathmunge () {
        if ! echo $PATH | grep -q "(^|:)$1($|:)" ; then
           if [ "$2" = "before" ] ; then
              PATH=$1:$PATH
           else
              PATH=$PATH:$1
           fi
        fi
}

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# List of color variables that bash can use

   C1="\[\033[0;30m\]" # Black
   C2="\[\033[1;30m\]" # Dark Gray
   C3="\[\033[0;31m\]" # Red
   C4="\[\033[1;31m\]" # Light Red
   C5="\[\033[0;32m\]" # Green
   C6="\[\033[1;32m\]" # Light Green
   C7="\[\033[0;33m\]" # Brown
   C8="\[\033[1;33m\]" # Yellow
   C9="\[\033[0;34m\]" # Blue
   C10="\[\033[1;34m\]" # Light Blue
   C11="\[\033[0;35m\]" # Purple
   C12="\[\033[1;35m\]" # Light Purple
   C13="\[\033[0;36m\]" # Cyan
   C14="\[\033[1;36m\]" # Light Cyan
   C15="\[\033[0;37m\]" # Light Gray
   C16="\[\033[1;37m\]" # White
   P="\[\033[0m\]" # Neutral

# bash prompt---pick which color combo you like

#   PS1="\w$P$C4 $ $C4$P"
#   PS1="$P$C9[\w]$C9$P\n$P$C10 $ $C10$P"
PS1="$C6\w$C4 $ $P"

export SVN_EDITOR=vi

# Get the aliases and functions if not loaded yet
if [ -z $BASH_PROFILE_LOADED ] && [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi

# use colors when at the command prompt for maximum greatness.
export CLICOLOR=1

# see http://geoff.greer.fm/lscolors/ for info on this.
export LSCOLORS=gxfxcxdxCxegedabagacad

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
