" A minimal vimrc for new vim users to start with.
"
" Referenced here: http://vimuniversity.com/samples/your-first-vimrc-should-be-nearly-empty
"
" Original Author:	 Bram Moolenaar <Bram@vim.org>
" Made more minimal by:  Ben Orenstein
" Last change:	         2012 Jan 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"
"  If you don't understand a setting in here, just type ':h setting'.

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Make backspace behave in a sane manner.
set backspace=indent,eol,start

" Switch syntax highlighting on
syntax on

" Enable file type detection and do language-dependent indenting.
filetype plugin indent on


set shiftwidth=4 softtabstop=4
set incsearch ignorecase hlsearch
" Press space to clear search highlighting and any message already displayed.
" nnoremap <silent> <Space> :silent noh<Bar>echo<CR>

inoremap <c-d> <C-R>=strftime("%F %T")<CR>

" Word wrap visually
set wrap

" Only wrap at a character in the breakat option
set linebreak

" List disables linebreak
set nolist

" For markdown
" See http://stackoverflow.com/questions/10964681/enabling-markdown-highlighting-in-vim
au BufRead,BufNewFile *.md set filetype=markdown

" For netrw
" See http://vimcasts.org/episodes/the-file-explorer/
"let g:netrw_liststyle=3 " Use tree-mode as default view
"let g:netrw_browse_split=4 " Open file in previous buffer
"let g:netrw_preview=1 " preview window shown in a vertically split
"let g:netrw_winsize=20 " preview takes up 80% and file explorer the other 20%

" To insert space characters whenever the tab key is pressed
" See http://vim.wikia.com/wiki/Converting_tabs_to_spaces
set expandtab
" To control the number of space characters that will be inserted when the tab
" key is pressed
set tabstop=4
" To change the number of space characters inserted for indentation
set shiftwidth=4

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" By default, disable vim-instant-markdown realtime display update
" See https://github.com/suan/vim-instant-markdown
let g:instant_markdown_slow = 1
