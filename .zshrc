
MYHOST=$(hostname)
SESSION=main

# if the session is already running, just attach to it.
if [ "$MYHOST" = "Nilss-MBP" ]; then

    echo "We are on my MacBook. Let's do a few specific things."
    export PATH="/usr/local/opt/gettext/bin:/Library/TeX/texbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/nils/skripte:/Users/nils/.cargo/bin"
    ssh-add -K
    test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

    export WECHALLUSER="DerNils"
    export WECHALLTOKEN="20BAF-D0844-62A31-53B32-27185-62D8D"

else

    echo "We are not on my MacBook. Let's do a few specific things."
    
    if [ ! -f ~/.tmux/.tmux.conf ]; then
        echo "TMUX config has not been found and will now be installed"
        cd ~
        git clone https://github.com/gpakosz/.tmux.git ~/.tmux
        ln -s -f .tmux/.tmux.conf
        cp .tmux/.tmux.conf.local .
    fi


    tmux has-session -t $SESSION
    if [ $? -eq 0 ]; then
        echo "Session $SESSION already exists. Attaching."
        sleep 1
        tmux attach -t $SESSION
    else                                
        # create a new session, named $SESSION, and detach from it
        tmux new-session -d -s $SESSION
        tmux new-window    -t $SESSION:0 
#        tmux split-window  -h -t $SESSION:0
#        tmux split-window  -v -t $SESSION:0
        tmux select-window -t $SESSION:0
        tmux attach -t $SESSION

    fi

fi


# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="smyck"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration


source $ZSH/oh-my-zsh.sh


# My alias definitions 
alias wlan="ifconfig en0"
alias lan="ifconfig en6"
alias lsusb="system_profiler SPUSBDataType"
alias pms="/Applications/Plex\ Media\ Server.app/Contents/MacOS/Plex\ Media\ Scanner"
alias GIT="git add . && git commit -am "working" && git push"
alias wipe="diskutil secureErase freespace 1"
alias syncer="rsync -avzh --progress"
alias publishCPP="ssh uberspace '/home/dernils/skripte/copyCPP.sh'"
alias docker_clean_images='docker rmi -f $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_clean='docker rm $(docker ps -a -q)' && 'docker rmi $(docker images -q)'
alias BZR="bzr add . && bzr commit -m "working" && bzr push"
alias pushDotFiles="cd ~/.dotfiles && GIT"
alias pullDotFiles="cd ~/.dotfiles && git pull"

alias shred="gshred -u"

# And my functions 
function flattenToFolder() {
    find $1 -type f -size +307200k -exec mv {} $2 \;}


function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

function push {
    curl -s -F "aa7d7bik4596wdiogiv7gc1cmq1uvo" \
        -F "user=uZQPseeXNuCh89BqDZYMLMD6t7WtWC" \
        -F "title=Message from MacBook" \
        -F "message=$1" https://api.pushover.net/1/messages.json
}

function checkCertStatus() {
    openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text | grep "Not After"
}










