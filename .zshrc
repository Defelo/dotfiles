# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_DUPS
setopt autocd
bindkey -v
bindkey "^R" history-incremental-search-backward
bindkey "^S" history-incremental-search-forward
# bindkey -r "^[[A"
# bindkey -r "^[[B"
# bindkey -r "^[[C"
# bindkey -r "^[[D"

setopt  autocd autopushd #\ pushdignoredups

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/felix/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH="$PATH:~/.gem/ruby/2.6.0/bin/:/home/felix/.dotnet/tools:/home/felix/.local/bin"

alias .='source'
alias vim='nvim'
alias ls='ls --color=auto'
alias sudo='sudo '
alias ..='cd ..'
alias rm='rm -f'
alias vi='vim'
alias c='printf "\033c";neofetch'
alias h='cd;c'
alias l='ls -al'
alias dog='highlight -O ansi --force'
alias cl='c;l'
alias temp='cd $(mktemp -d)'
alias grep='grep --color=always'
alias back='cd $OLDPWD'
alias f='cd $(pwd -P)'
alias curl='curl -L'
alias cif='curl ifconfig.co'
alias cf='ping 1.1.1.1'
alias cov='pipenv run coverage && rm coverage.xml'
alias g++c='g++ -O2 -Wall -Wextra'
alias g++debug='g++c -fsanitize=undefined,address -D_GLIBCXX_DEBUG -g'
alias ls='exa -g --git'
alias blk='black -l 120 .'
alias config='GIT_DIR=/home/felix/dotfiles GIT_WORK_TREE=/home/felix /usr/bin/git'
alias config-crypt='GIT_DIR=/home/felix/dotfiles GIT_WORK_TREE=/home/felix /usr/bin/git-crypt'
alias tre='ls -alT'
alias volume='pactl set-sink-volume @DEFAULT_SINK@'
alias :q='exit'
alias :e='vim'
alias gource='gource -s 0.4 -i 0 -a 0.5 --highlight-users --file-extensions --hide mouse,filenames --key --stop-at-end'
alias mnt='source ~/mount.sh'
alias bt='bluetoothctl'
alias bprune='borg prune -v --list --stats --keep-daily=4 --keep-weekly=2 --keep-monthly=1'
alias cal='cal -m'
alias vlc='vlc -I ncurses'

[[ -f ~/.zshrc.enc ]] && . ~/.zshrc.enc

wttr() {
    curl -s "wttr.in/$1?lang=de" | head -n -2
}

neofetch() {
    cat ~/.neofetch | sed s/sh/zsh/ | sed s/crond/st/
}

bmnt() {
    borg mount -o ignore_permissions $1 $2
    cd $2
}

venv() {
    virtualenv .venv
    . .venv/bin/activate
}

totp() {
    code=$(oathtool -b --totp $1)
    echo $code
    printf $code | clip
}

xcls() {
    xprop | grep WM_CLASS | cut -d'"' -f4
}

md() {
    fn=$(mktemp --suffix=.html)
    markdown -o $fn $1
    brave $fn
}

list_sinks() {
    pactl list short sinks
}

v() { volume $1%; }

move_sink() {
    pacmd set-default-sink $1
    pactl list short sink-inputs|while read stream; do
        streamId=$(echo $stream|cut '-d ' -f1)
        echo "moving stream $streamId"
        pactl move-sink-input "$streamId" "$1"
    done
}

flake() {
#    pipenv run flake8 --exclude $(git status -u --short | cut -d' ' -f2 | xargs | tr ' ' ,)
    exclude=$(git ls-files --others --exclude-standard | xargs | tr ' ' ,)
    test -n "$exclude" && exclude="--exclude $exclude"
    pipenv run flake8 $exclude $@
}

mkcd() {
    test -d $1 || mkdir $1
    cd $1
}

d() {
    dirs -v | tac
}

deltemp() {
    d=$(pwd)
    [[ $(echo $d | cut -d/ -f2) != "tmp" ]] && return
    cd
    rm -r /tmp/$(echo $d | cut -d/ -f3)
}

mdlint() { docker run --rm -v $(pwd):/repo:ro avtodev/markdown-lint:v1 --config /repo/.linter.yml /repo }
mdfix() { docker run --rm -v $(pwd):/repo avtodev/markdown-lint:v1 --config /repo/.linter.yml /repo --fix }

ram() { ps -o pid,user,%mem,command ax | sort -b -k3 | head -n-1; }

title(){ echo -ne "\033]0;$1\007"; }

cheat() { curl cheat.sh/$1; }

pypub() { python setup.py sdist bdist_wheel && twine upload dist/*; rm -r build/ dist/ *.egg-info; }

noup() { touch /tmp/updates_blocked; }

export EDITOR=nvim
export VISUAL=nvim

title Terminal
neofetch