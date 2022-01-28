{{#if dotter.packages.p10k}}
if test -L ~/.p10k; then
    rm ~/.p10k
fi
{{/if}}

{{#if dotter.packages.zsh}}
if test -L ~/.zprofile; then
    rm ~/.zprofile
fi
if test -L ~/.zsh/zsh-autosuggestions; then
    rm ~/.zsh/zsh-autosuggestions
fi
{{/if}}
