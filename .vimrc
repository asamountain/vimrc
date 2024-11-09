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
nnoremap <leader>e :call s:AddAsterisks()<CR>
function! s:AddAsterisks()
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
  echom "First line: " . l:line
  if l:line =~ '^# .\+'
    echom "Title line detected"
    let l:title = s:GetTitleFromContent()
    echom "Extracted title: " . l:title
    call s:Rename(s:GetFilename(), strftime('%Y-%m-%d') . '-' . l:title . '.md')
  else
    echom "No valid title line found"
  endif
endfunction

function! s:GetTitleFromContent()
  echom "s:GetTitleFromContent called"
  let l:content = getline(1, '$')
  let l:title = matchstr(l:content, '^# \zs.*')
  echom "Title from content: " . l:title
  return substitute(l:title, '\s\+', '-', 'g')
endfunction

function! s:GetFilename()
  echom "s:GetFilename called"
  let l:file_name = expand('%:t')
  echom "Current filename: " . l:file_name
  if l:file_name !~ '\.md$'
    return substitute(l:file_name, '\..*$', '.md', '')
  endif
  return l:file_name
endfunction

function! s:Rename(from, to)
  echom "s:Rename called with " . a:from . " to " . a:to
  let l:from_path = expand('%:p:h') . '/' . a:from
  let l:to_path = expand('%:p:h') . '/' . a:to
  silent! execute 'rename' l:from_path l:to_path
  echom "File renamed"
endfunction

