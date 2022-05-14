call plug#begin('~/.vim/plugged')

{{#if vim.plugins.airline.enabled}}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
{{/if}}

{{#if vim.plugins.vimtex.enabled}}
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
{{/if}}

{{#if vim.plugins.vim-nix.enabled}}
Plug 'LnL7/vim-nix'
{{/if}}

{{#if vim.plugins.vim-svelte.enabled}}
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
{{/if}}

Plug 'arcticicestudio/nord-vim'

" Initialize plugin system
call plug#end()
