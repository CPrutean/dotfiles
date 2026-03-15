export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/bin/:$PATH"

ZSH_THEME="robbyrussell"

ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

zstyle ':omz:update' frequency 13


ENABLE_CORRECTION="true"

plugins=(git)
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"


#ALIAS FUNCTIONS HERE
#
alias sshmac="ssh -X -Y -v 192.168.1.16"
alias copy="pbcopy"
alias mv="mv -i"
alias rm="rm -rf -I"
alias pipes="pipes.sh -r 5000 -t 1 -f 100"
alias c="clear"





# need this for the neovim config
export JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/opt/spaceship/spaceship.zsh
export JAVA_HOME=$(/usr/libexec/java_home)


pfetch

export MANPAGER="sh -c 'col -bx | bat -l man -p'"


# Created by `pipx` on 2026-01-09 21:10:49
export PATH="$PATH:/Users/calinprutean/.local/bin"




