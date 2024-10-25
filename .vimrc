" Enable absolute line numbers
set number

" Fzf freezing prevention
set noswapfile
set maxfuncdepth=1000

" Enable clipboard support
set clipboard=unnamedplus

" Enable mouse support (optional)
set mouse=a

" Install plugins using vim-plug
call plug#begin('~/.vim/plugged')

" Markdown plugins
Plug 'godlygeek/tabular'

" Dependency plugins
Plug 'inkarkat/vim-ingo-library'
Plug 'junegunn/fzf.vim'
plug 'junegunn/rg.vim'

" Grammar checking
Plug 'rhysd/vim-grammarous'
Plug 'Exafunction/codeium.vim'

call plug#end()

" Enable syntax highlighting
syntax on

" Enable filetype detection and plugins
filetype plugin on

" Markdown-specific settings
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

" AutoSave
set updatetime=5000
autocmd CursorHold * if &modifiable && &filetype != 'help' | silent! update | endif

" Add ** to the beginning and end of the line
nnoremap <leader>e :call AddAsterisks()<CR>
function! AddAsterisks()
  " Go to the beginning of the line
  normal! I**
  " Go to the end of the line
  normal! A**
endfunction

" Git Auto Push
augroup vimrc_autopush
  autocmd!
  autocmd BufWritePost ~/.vimrc call system('cd ~ && git add .vimrc && git commit -m "Update .vimrc" && git push origin main')
augroup END

" Enable all marks
let g:mark#autoMark = 1
let g:mark#enable = 1

" Customize mark highlighting
let g:mark_highlight = 'Search'
let g:mark#debug = 1

" Grammar Check Shortcut
nmap <leader>g :GrammarousCheck<CR>

" FZF Fuzzy File Search Shortcuts
"nnoremap <C-p> :Files<CR>
"nnoremap <leader>f :Rg<CR>

