
MYHOST=sudo scutil --set HostName [new name]
SESSION=main

# if the session is already running, just attach to it.
if [ "$MYHOST" -ne "Nilss-MacBook-Pro" ]; then
    tmux has-session -t $SESSION
    if [ $? -eq 0 ]; then
        echo "Session $SESSION already exists. Attaching."
        sleep 1
        tmux attach -t $SESSION
    else                                
        # create a new session, named $SESSION, and detach from it
        tmux new-session -d -s $SESSION
        tmux new-window    -t $SESSION:0 
        tmux split-window  -h -t $SESSION:0
        tmux split-window  -v -t $SESSION:0

        #tmux new-window    -t $SESSION:1 
        #tmux new-window    -t $SESSION:2  
        #tmux new-window    -t $SESSION:3  
        #tmux split-window  -h -t $SESSION:3
        #tmux new-window    -t $SESSION:4
        tmux select-window -t $SESSION:0
        tmux attach -t $SESSION

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

export PATH="/usr/local/opt/gettext/bin:/Library/TeX/texbin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/nils/skripte:/Users/nils/.cargo/bin"

source $ZSH/oh-my-zsh.sh


alias wlan="ifconfig en0"
alias lan="ifconfig en6"
alias lsusb="system_profiler SPUSBDataType"
alias pms="/Applications/Plex\ Media\ Server.app/Contents/MacOS/Plex\ Media\ Scanner"
alias GIT="git add . && git commit -am "working" && git push"
alias wipe="diskutil secureErase freespace 1"
alias syncer="rsync -avzh --progress"
test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
alias publishCPP="ssh uberspace '/home/dernils/skripte/copyCPP.sh'"
alias docker_clean_images='docker rmi -f $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias docker_clean='docker rm $(docker ps -a -q)' && 'docker rmi $(docker images -q)'
alias BZR="bzr add . && bzr commit -m "working" && bzr push"


alias shred="gshred -u"

function flattenToFolder() {
    find $1 -type f -size +307200k -exec mv {} $2 \;
}

alias pushDotFiles='cd ~/.dotfiles && GIT'
alias pullDotFiles='cd ~/.dotfiles && git pull'


function anybar { echo -n $1 | nc -4u -w0 localhost ${2:-1738}; }

function push {
    curl -s -F "aa7d7bik4596wdiogiv7gc1cmq1uvo" \
        -F "user=uZQPseeXNuCh89BqDZYMLMD6t7WtWC" \
        -F "title=Message from MacBook" \
        -F "message=$1" https://api.pushover.net/1/messages.json
}
ssh-add -K

export WECHALLUSER="DerNils"
export WECHALLTOKEN="20BAF-D0844-62A31-53B32-27185-62D8D"

export PIP_REQUIRE_VIRTUALENV=false;

export WORKON_HOME=$HOME/.virtualenvs
#source /usr/local/bin/virtualenvwrapper.sh
source /Users/nils/Library/Python/2.7/bin/virtualenvwrapper.sh


checkCertStatus() {
    openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text | grep "Not After"
}

export PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
