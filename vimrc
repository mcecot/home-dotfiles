" Kuetemeier.NET GmbH - (c) 2008-2013 Jörg Kütemeier <jkuetemeier@kuetemeier.net>

" hint for copy&paste: set paste / set no paste

" comment form original ubuntu file:
" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" --------------------------------------------------------
"

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
syntax on

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
"    \| exe "normal g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules according to the
" detected filetype. Per default Debian Vim only load filetype specific
" plugins.
if has("autocmd")
  filetype indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes) in terminals

" select case-insensitive search
set ignorecase

" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" disply mode INSERT/REPLACE/...
set showmode

" dont't write backup (~) files
set nobackup
set nowritebackup

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1

" have the h and l cursor keys wrap between lines (like <Space> and <BkSpc> do
" by default), and ~ covert case over line breaks; also have the cursor keys
" wrap in insert mode:
set whichwrap=h,l,~,[,]

" use <Ctrl>+N/<Ctrl>+P to cycle through files:
nnoremap <C-N> :next<CR>
nnoremap <C-P> :prev<CR>

" * Keystrokes -- Formatting
"
" " have Q reformat the current paragraph (or selected text if there is any):
nnoremap Q gqap
vnoremap Q gq

" ----------------------------------------------------
"  indent modes

" don't automatically indent lines
" set noautoindent
"set smartindent  # depricated over cindent
set cindent

"  turn of for this files:
autocmd BufEnter *.html setlocal indentexpr=
autocmd BufEnter *.htm setlocal indentexpr=
autocmd BufEnter *.xml setlocal indentexpr=
autocmd BufEnter *.xsd setlocal indentexpr= 

" ----------------------------------------------------
"  better pasting
" :set pastetoggle=<F12>  
" Paste Mode On/Off

map <F2> :call Paste_on_off()<CR>
set pastetoggle=<F2>

let paste_mode = 0 " 0 = normal, 1 = paste

func! Paste_on_off()
        if g:paste_mode == 0
                set paste
		set nolist
                let g:paste_mode = 1
        else
                set nopaste
		set list
                let g:paste_mode = 0
        endif  
        return
endfunc 

" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" have <Tab> (and <Shift>+<Tab> where it works) change the level of
" indentation:
" inoremap <Tab> <C-T>
inoremap <S-Tab> <C-D>
" [<Ctrl>+V <Tab> still inserts an actual tab character.]

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>


map ^Ktu 1G!Gunexpand -a -t4^M
map ^Kte 1G!Gexpand -t4^M

set tabstop=4

set shiftwidth=4
set shiftround
set expandtab
set smarttab
" :retab


" when using list, keep tabs at their full width and display `arrows':
execute 'set listchars=tab:' . nr2char(187) . nr2char(183) . ',trail:' . nr2char(183)
" (Character 187 is a right double-chevron, and 183 a mid-dot.)
set list

" get rid of the default style of C comments, and define a style with two stars
" at the start of `middle' rows which (looks nicer and) avoids asterisks used
" for bullet lists being treated like C comments; then define a bullet list
" style for single stars (like already is for hyphens):
set comments-=s1:/*,mb:*,ex:*/
set comments+=s:/*,mb:**,ex:*/
set comments+=fb:*

" treat lines starting with a quote mark as comments (for `Vim' files, such as
" this very one!), and colons as well so that reformatting usenet messages from
" `Tin' users works OK:
set comments+=b:\"
set comments+=n::

" * Search & Replace

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

" assume the /g flag on :s substitutions to replace all matches in a line:
set gdefault

" have fifty lines of command-line (etc) history:
set history=50
" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

" use "[RO]" for "[readonly]" to save space in the message line:
set shortmess+=r

set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,foreach,switch,case
set formatoptions=tcqr
set cindent

set nocompatible
set esckeys

set <S-Up>=^[[1;2A
set <S-Down>=^[[1;2B
set <S-Right>=^[[1;2C
set <S-Left>=^[[1;2D
set <C-Right>=^[[1;5C
set <C-Left>=^[[1;5D
set <S-Home>=^[[1;2H
set <S-End>=^[[1;2F
set <C-Home>=^[[1;5H
set <C-End>=^[[1;5F


" From Bram:
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" DF - Also do not do this if the file resides in the $TEMP directory,
"      chances are it is a different file with the same name.
" This comes from the $VIMRUNTIME/vimrc_example.vim file
autocmd BufReadPost *
  \ if expand("<afile>:p:h") !=? $TEMP |
  \   if line("'\"") > 0 && line("'\"") <= line("$") |
  \     exe "normal g`\"" |
  \     let b:doopenfold = 1 |
  \   endif |
  \ endif
" Need to postpone using "zv" until after reading the modelines.
autocmd BufWinEnter *
  \ if exists("b:doopenfold") |
  \   unlet b:doopenfold |
  \   exe "normal zv" |
  \ endif 

" From Mac vimrc file:
" Configuration file for vim
set modelines=0         " CVE-2007-2438

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults instead of 100% vi compatibility
set backspace=2         " more powerful backspacing

" Don't write backup file if vim is being called by "crontab -e"
au BufWrite /private/tmp/crontab.* set nowritebackup
" Don't write backup file if vim is being called by "chpass"
au BufWrite /private/etc/pw.* set nowritebackup

autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype ruby setlocal ts=2 sw=2 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 sts=0 noexpandtab
