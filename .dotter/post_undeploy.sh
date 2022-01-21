{{#if dotter.packages.p10k}}
if [[ -L ~/.p10k ]]; then
    rm ~/.p10k
fi
{{/if}}

{{#if dotter.packages.zsh}}
if [[ -L ~/.zprofile ]]; then
    rm ~/.zprofile
fi
{{/if}}
