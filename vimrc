set nocompatible		" disregard vi compatibility
execute pathogen#infect()

" ----------------------------------------------------------------------
" file:		~/.vimrc
" author:	Thayer Williams - http://cinderwick.ca
" modified: June 21, 2008
" ----------------------------------------------------------------------

" general --------------------------------------------------------------

set t_Co=256			" enable 256-color support
set nowrap
colorscheme desert		" define syntax color scheme
" set dir=~/.vim/swap	 " keep swap files in one place
" set bdir=~/.vim/backup  " keep backups in one place
set encoding=utf-8		 " UTF-8 encoding for all new files
" set termencoding=utf-8  " force terminal encoding
set fileencoding=utf-8	" force filetype encoding for existing files
set fileencodings=ucs-bom,utf-8,gb18030,utf16-le,big5,euc-jp,euc-kr,latin1
set mouse=a				" allow mouse input in all modes
set ttymouse=xterm2		" enable scrolling within screen sessions (MUST HAVE)
set backspace=2			" full backspacing capabilities (indent,eol,start)
set history=100			" 100 lines of command line history
set number				" show line numbers
set numberwidth=3		" minimum num of cols to reserve for line numbers
set nobackup			" disable backup files (filename~)
set showmatch			" show matching brackets (),{},[]
set ww=h,l,<,>,[,]		" whichwrap -- left/right keys can traverse up/down
set wrap				" wrap long lines to fit terminal width
set ttyfast				" tell vim we're using a fast terminal for redraws
set autoread			" reload file if vim detects it changed elsewhere
set wildmenu			" enhanced tab-completion shows all matching cmds
set splitbelow			" place the new split below the current file
set autowrite			" write file if modified on each :next, :make, etc.
set writebackup			" make a backup before writing a file until successful
" set shell=/bin/sh		" set default shell type
set previewheight=5		" default height for a preview window (def:12)
" set textwidth=80		" insert carriage return after n cols wide
syntax on				" enable syntax highlighting
filetype plugin indent on	" enable filetype-sensitive plugins and indenting
hi LineNr ctermfg=grey guifg=grey


" html conversion (:help 2html.vim) ------------------------------------

let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = "utf8"
let g:html_number_lines = 1


" statusline -----------------------------------------------------------

set cmdheight=2			" command line height
set laststatus=2		" condition to show status line, 2=always.
set ruler				" show cursor position in status line
set showmode			" show mode in status line
set showcmd				" show partial commands in status line
" left: fileencoding, fileformat, filetype, RO/HELP/PREVIEW, modified flag, filepath
" right: buffer num, lines/total, cols/virtual, display percentage
set statusline=%([%{&fenc}%)%(:%{&ff}]%)%(:%y%)\ %r%h%w\ %#Error#%m%#Statusline#\ %F\ %=buff[%1.3n]\ %1.7l/%L,%1.7c%V\ [%P]


" tabs and indenting ---------------------------------------------------

set noexpandtab			  " insert spaces instead of tabs
"set expandtab			  " insert spaces instead of tabs
set tabstop=4			" n space tab width
"set list
set shiftwidth=4		" allows the use of < and > for VISUAL indenting
set softtabstop=4		" counts n spaces when DELETE or BCKSPCE is used
set smarttab			" set <Tab>s according to shiftwidth
set autoindent			" auto indents next new line
set smartindent		  " intelligent indenting -- DEPRECATED by cindent
set cindent			  " C style indenting off
set cinoptions=:0,p0,t0 " recommended defaults from O'Reilly
set cinwords=if,else,while,do,for,switch,case	" recommended defaults from O'Reilly
set formatoptions=tcqr	" recommended defaults from O'Reilly


" searching ------------------------------------------------------------

set hlsearch			" highlight all search results
set incsearch			" increment search
set ignorecase			" case-insensitive search
set smartcase			" uppercase causes case-sensitive search
set nowrapscan			" searches wrap back to the top of file


" hotkeys --------------------------------------------------------------

" enter ex mode with a semi-colon too
nnoremap ; :
vnoremap ; :

" F2 selects all
nnoremap <F2> ggVG

" F3 toggles wordwrap
nnoremap <F3> :set invwrap wrap?<cr>

" F5 toggles paste mode
set pastetoggle=<F5>

" F6 toggles spell checking
map <F6> :setlocal spell! spelllang=en_us<cr>
imap <F6> <C-o>:setlocal spell! spelllang=en_us<cr>

" F9 runs 2html conversion
map <F9> :runtime syntax/2html.vim

" strip ^M linebreaks from dos formatted files
map M :%s/\r$//g


" firefox style tabbing ------------------------------------------------

nmap <c-t> :tabnew<cr>
" nmap <c-w> :close<cr>
map <S-h> gT
map <S-l> gt
map <a-1> 1gt
map <a-2> 2gt
map <a-3> 3gt
map <a-4> 4gt
map <a-5> 5gt
map <a-6> 6gt
map <a-7> 7gt
map <a-8> 8gt
map <a-9> 9gt
map <a-0> 10gt


" highlight extra whitespace and tabs ----------------------------------

" highlight RedundantSpaces ctermbg=red guibg=red
" match RedundantSpaces /\s\+$\| \+\ze\t\|\t/


" gvim for windows
if has ("gui_running")

	" only initialize window size if has not been initialized yet
	if !exists ("s:my_windowInitialized_variable")
		let s:my_windowInitialized_variable=1
	endif

	source $VIMRUNTIME/mswin.vim
	behave mswin

	" deal with the garbled word
	language messages zh_CN.utf-8
	
	set guifont=DejaVu_Sans_Mono:h10:cANSI
	" set guifontwide=Wenquanyi_Micro_Hei_Mono:h10:cGB2312
	set guifontwide=STXihei:h10:cGB2312
	set guioptions-=m
	set guioptions-=T
	winpos 420 150
	set lines=40 columns=120
    set guicursor=a:block-blinkon0
endif


" autocmd rules --------------------------------------------------------

if has("autocmd")
	au BufRead,BufNewFile PKGBUILD set ft=sh
	augroup module
		autocmd BufRead,BufNewFile *.module set filetype=php
		autocmd BufRead,BufNewFile *.install set filetype=php
		autocmd BufRead,BufNewFile *.inc set filetype=php
	augroup END
endif


" tab completion
" if at the begining of the line, tab, otherwise completion c-p (nice !)
function InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<tab>"
	else
		return "\<c-p>"
	endif
endfunction

" then define the appropriate mapping:
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>


" NerdTree

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd vimenter * if !argc() | NERDTree | endif

" map a shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

