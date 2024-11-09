" Codium Disable when it is freewriting in Markdown
let g:codium_disabled_filetypes = ['markdown']

" no swp file
set noswapfile

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

" Autoformat
Plug 'Chiel92/vim-autoformat'

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

" FZF Fuzzy File Search Shortcuts
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Rg<CR>
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

" Clang Format
let g:formatdef_clangformat = '"clang-format"'
let g:formatters_c = ['clangformat']

