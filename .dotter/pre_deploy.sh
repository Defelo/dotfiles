git submodule update --init

{{#if dotter.packages.p10k}}
if ! test -L ~/.p10k; then
    ln -s $PWD/powerlevel10k ~/.p10k
fi
{{else}}
if test -L ~/.p10k; then
    rm ~/.p10k
fi
{{/if}}

{{#if dotter.packages.zsh}}
if ! test -L ~/.zsh/zsh-autosuggestions; then
    mkdir -p ~/.zsh
    ln -s $PWD/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
{{else}}
if test -L ~/.zsh/zsh-autosuggestions; then
    rm ~/.zsh/zsh-autosuggestions
fi
{{/if}}
