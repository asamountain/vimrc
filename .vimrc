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

" FZF Fuzzy File Search Shortcuts
nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Rg<CR>
set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow

" Codeium Shortcuts
nnoremap <leader>ce :CodeiumEnable<CR>
nnoremap <leader>cd :CodeiumDisable<CR>

" Rename markdown file
autocmd BufWritePost *.md call s:RenameMarkdownFile()

function! s:RenameMarkdownFile()
  echom "s:RenameMarkdownFile called"
  let l:line = getline(1)
  if l:line =~ '^# .\+' && strlen(matchstr(l:line, '\S\+')) > 2
    let l:title = s:GetTitleFromContent()
    call s:Rename(s:GetFilename(), l:title . '.md')
  endif
endfunction

function! s:GetTitleFromContent()
  echom "s:GetTitleFromContent called"
  let l:content = getline(1, '$')
  let l:title = matchstr(l:content, '^# \zs.*')
  return substitute(l:title, ' ', '_', 'g') . '-' . strftime('%Y-%m-%d')
endfunction

function! s:GetFilename()
  echom "s:GetFilename called"
  let l:file_name = expand('%:t')
  if l:file_name !~ '\.md$'
    return substitute(l:file_name, '\..*$', '.md', '')
  endif
  return l:file_name
endfunction

function! s:Rename(from, to)
  echom "s:Rename called with " . a:from . " to " . a:to
  silent! execute 'rename' a:from a:to
endfunction


