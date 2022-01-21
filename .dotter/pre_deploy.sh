git submodule update --init

{{#if dotter.packages.p10k}}
if ! [[ -L ~/.p10k ]]; then
    ln -s $PWD/powerlevel10k ~/.p10k
fi
{{else}}
if [[ -L ~/.p10k ]]; then
    rm ~/.p10k
fi
{{/if}}
