# -*-sh-*-

# User specific aliases and functions

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

# added by travis gem
[ -f /Users/johnsogg/.travis/travis.sh ] && source /Users/johnsogg/.travis/travis.sh

export NVM_DIR="/Users/johnsogg/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
