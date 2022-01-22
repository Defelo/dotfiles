call plug#begin('~/.vim/plugged')

{{#if vim.plugins.airline.enabled}}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
{{/if}}

{{#if vim.plugins.vimtex.enabled}}
Plug 'lervag/vimtex'
{{/if}}

" Initialize plugin system
call plug#end()
