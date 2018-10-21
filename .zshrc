

if [ ! -f ~/.oh-my-zsh/README.md ]; then
       echo "oh-my-zsh is not installed. please install"
       exit 1
       # sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


MYHOST=$(hostname)
SESSION=main


    
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

    ZSH_THEME="robbyrussell"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh


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

function checkCertStatus() {
    openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text | grep "Not After"
}










