{{#if dotter.packages.x11}}
xrdb ~/.Xresources
{{/if}}

{{#if dotter.packages.zsh}}
if ! [[ -L ~/.zprofile ]]; then
    ln -s ~/.profile ~/.zprofile
fi
{{else}}
if [[ -L ~/.zprofile ]]; then
    rm ~/.zprofile
fi
{{/if}}
