# -*-sh-*-

# This is based on https://gist.github.com/natelandau/10654137

# Summon up the config from bashrc if it exists.
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
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

#   Change Prompt
#   ------------------------------------------------------------
export PS1="$C6\w$C4 $ $P"

#   golang related variables
export GOPATH=/Users/johnsogg/Projects/go

#   Zoteserver env vars
export SKETCHES_PATH=~/sketches

#   Set Paths
#   ------------------------------------------------------------
pathmunge $GOPATH/bin
pathmunge $HOME/bin

#   Java classpath
#   ------------------------------------------------------------
cpmunge /usr/local/lib/antlr-4.5.2-complete.jar

#   Set Default Editor 
#   ------------------------------------------------------------
export EDITOR=/usr/bin/vim

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
export BLOCKSIZE=1k
    
    
#
# Aliases
#

alias recent='cd `most_recent_app_dir.sh`'  # Go to most recent iOS app directory
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
githist () { git log --all --stat -- "*$1*" ; } # githist myfile: Search through git history for a file
foob() { echo "Did the thing *$1*" ; pwd ; }

#   extract:  Extract most known archives with one command
#   ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}


alias qfind="find . -name "                 # qfind:    Quickly search for file

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
alias hogsMemTop='top -l 1 -o rsize | head -20'
alias hogsMemPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
alias hogsCPU='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
    
#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
alias topForever='top -l 9999999 -s 10 -o cpu'

#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
alias ttop="top -R -F -s 10 -o rsize"

#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
