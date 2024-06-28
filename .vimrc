" Enable absolute line numbers
set number

" Enable clipboard support
set clipboard=unnamedplus

" Enable mouse support (optional)
set mouse=a

call plug#begin('~/.vim/plugged')

" Install markdown plugins
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

call plug#end()

" Enable syntax highlighting
syntax on

" Enable filetype detection and plugins
filetype plugin on

" Set some markdown-specific settings
let g:vim_markdown_folding_disabled = 1
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 1
let g:mkdp_open_to_the_world = 0
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = '8080'
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_browser = '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome'


" AutoSaving
" Set the CursorHold event timeout to 5 seconds (5000 milliseconds)
set updatetime=5000

" Define an autocommand to save the file on CursorHold
autocmd CursorHold * if &modifiable && &filetype != 'help' | silent! update | endif
