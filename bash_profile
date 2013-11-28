BASH_PROFILE_LOADED=true

# Get the aliases and functions if not loaded yet
if [ -z $BASHRC_LOADED ] && [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi
pathmunge /usr/local/bin
pathmunge $HOME/bin
pathmunge /usr/local/ant/bin

test -r /sw/bin/init.sh && . /sw/bin/init.sh
