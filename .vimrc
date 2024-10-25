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

" Dependency plugins
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Grammar checking
Plug 'Exafunction/codeium.vim'

call plug#end()

" Enable syntax highlighting
syntax on

" Enable filetype detection and plugins
filetype plugin on

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
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Rg<CR>

