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
