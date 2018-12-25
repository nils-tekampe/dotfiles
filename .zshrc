

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

export ZSH=$HOME/.oh-my-zsh
plugins=(git)
source $ZSH/oh-my-zsh.sh


# My alias definitions 

alias GIT="git add . && git commit -am "working" && git push"

function checkCertStatus() {
    openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text | grep "Not After"
}










