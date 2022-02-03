{{#if dotter.packages.p10k}}
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
{{/if}}

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
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept

{{#if dotter.packages.p10k}}
source ~/.p10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
{{/if}}

export PATH="$PATH:~/.gem/ruby/2.6.0/bin/:/home/felix/.dotnet/tools:/home/felix/.local/bin:./node_modules/.bin"

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
{{#if (command_success "type exa")}}
alias ls='exa -g --git'
{{/if}}
alias blk='black -l 120 .'
alias tre='ls -alT'
alias volume='pactl set-sink-volume @DEFAULT_SINK@'
alias :q='exit'
alias :e='vim'
alias gource='gource -s 0.4 -i 0 -a 0.5 --highlight-users --file-extensions --hide mouse,filenames --key --stop-at-end'
alias mnt='source ~/mount.sh'
alias bt='bluetoothctl'
alias bprune='borg prune -v --list --stats --keep-daily=2 --keep-weekly=2 --keep-monthly=2'
alias cal='cal -m'
alias vlc='~/scripts/vlc_notifications.sh'
alias redis='redis-cli -u redis://10.42.2.6'
alias py='python'
alias dotter='./dotter -v'
alias diff='git diff --no-index'

alias docker='sudo docker'
alias dc='sudo docker-compose'
alias logs='dc logs -f'
alias up='dc up -d && dc logs -f'
alias down='dc down'
alias restart='down && up'
alias ct='sudo ctop'
alias pull='dc pull'
alias update='dc pull && up'

alias -s yml=vim
alias -s yaml=vim
alias -s txt=vim
alias -s md=vim

[[ -f ~/.zshrc.enc ]] && . ~/.zshrc.enc

wttr() {
    curl -s "wttr.in/$1?lang=de" | head -n -2
}

vz() { vim ~/.zshrc; source ~/.zshrc }

# neofetch() {
#     cat ~/.neofetch | sed s/sh/zsh/ | sed s/crond/st/
# }

bmnt() {
    borg mount -o ignore_permissions $1 $2
    cd $2
}

venv() {
    virtualenv .venv
    . .venv/bin/activate
}

jinja2() {
    python -c 'argv=__import__("sys").argv[1:];print(__import__("jinja2").Template(open(0).read()).render(**__import__("json").loads(argv[0] if argv else "{}")))' $@
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

pydrocsid_update() {
    git fetch --prune template
    git merge --no-ff -m "Merge template into $(git branch --show-current)" template/develop
}

mdlint() { docker run --rm -v $(pwd):/repo:ro avtodev/markdown-lint:v1 --config /repo/.linter.yml /repo }
mdfix() { docker run --rm -v $(pwd):/repo avtodev/markdown-lint:v1 --config /repo/.linter.yml /repo --fix }
clip() { xclip -selection clipboard; }

ram() { ps -o pid,user,%mem,command ax | sort -b -k3 | head -n-1; }

title(){ echo -ne "\033]0;$1\007"; }

cheat() { curl cheat.sh/$1; }

pypub() { python setup.py sdist bdist_wheel && twine upload dist/*; rm -r build/ dist/ *.egg-info; }

noup() { touch /tmp/updates_blocked; }

luks_open(){
    LUKS_NAME=$2
    LUKS_MOUNT=$3
    if [[ -f $1.key ]]; then
        gpg --decrypt $1.key | sudo cryptsetup open -d - $1 $2
    else
        sudo cryptsetup open $1 $2
    fi
    sudo mount /dev/mapper/$2 $3 && cd $3
}

luks_close(){
    sudo umount $LUKS_MOUNT
    sudo cryptsetup close $LUKS_NAME
}

vm() {
    port=$1
    port=${port:-2222}
    echo Starting VM
    tmux new -s vm-$port -d qemu-system-x86_64 -cdrom ~/ISO/ArchISO/archlinux-2021.09.23-x86_64.iso -enable-kvm -cpu host -m 2G -display none -device virtio-net-pci,netdev=network0 -netdev user,id=network0,hostfwd=tcp::$port-:22
    sleep 2
    echo Waiting for SSH server
    while ! ssh -p 2222 root@localhost
    do
        sleep 1
    done
}

vmanjaro() {
    tmux new -s vmanjaro -d qemu-system-x86_64 -enable-kvm -cpu host -m 4G -display gtk -drive file=qemu_manjaro.img,format=qcow2 -audiodev pa,id=snd0 -device ich9-intel-hda -device hda-output,audiodev=snd0
}

blkw() {
    tmux new -s blkw zsh -c 'while inotifywait -e close_write -r .; do black -l 120 .; done'
}

lint() {
    blk && pipenv run flake8 --exclude data && pipenv run mypy --exclude data
}

export EDITOR=nvim
export VISUAL=nvim

title Terminal
{{#if (command_success "type neofetch")}}
neofetch
{{/if}}

zstyle ':completion:*' menu select
fpath+=~/.zfunc
