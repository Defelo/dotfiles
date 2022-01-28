{{#if dotter.packages.x11}}
xrdb ~/.Xresources
{{/if}}

{{#if dotter.packages.zsh}}
if ! test -L ~/.zprofile; then
    ln -s ~/.profile ~/.zprofile
fi
{{else}}
if test -L ~/.zprofile; then
    rm ~/.zprofile
fi
{{/if}}

{{#if dotter.packages.fonts}}
fc-cache -vf ~/.fonts
{{/if}}
