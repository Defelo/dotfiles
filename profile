export SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh
export QT_STYLE_OVERRIDE=gtk2
export EDITOR=nvim
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

{{#if profile.auto_start}}
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ]; then
    exec {{profile.auto_start}}
fi
{{/if}}
