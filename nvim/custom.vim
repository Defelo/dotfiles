call plug#begin('~/.vim/plugged')

{{#if vim.plugins.vimtex.enabled}}
Plug 'lervag/vimtex'
{{/if}}

" Initialize plugin system
call plug#end()
