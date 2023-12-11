" vim:fdm=marker
"
set nocompatible 
filetype indent plugin on 
syn on

" Platform setup {{{1
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization

" across (heterogeneous) systems easier.
if (has('win16') || has('win32') || has('win64'))
    set shellquote=\"
    set shell=cmd
    set shellcmdflag=/c
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
    " let g:python3_host_prog='c:\Users\cba\scoop\apps\python\current\python.exe'
    " set pythonthreedll='c:\Users\cba\scoop\apps\python\current\python37.dll'
    "set pythonthreedll=python37.dll
    " set pythonthreehome='c:\Users\cba\scoop\apps\python\current'
    set directory=.,$TMP,$TEMP
    au GUIEnter * simalt ~x
elseif has("nvim")
    let g:python3_host_prog='/usr/bin/python'
    " set runtimepath=/mnt/c/Users/allencb/.config/nvim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,/mnt/c/Users/allencb/.config/nvim/after
	"set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,/mnt/c/Users/allencb/.vim/after
" else
  "  set shell=/home/cba/.local/bin/xonsh
endif 
" set shell=/home/cba/.local/bin/xonsh
" set shell=/usr/bin/bash
set shell=/usr/bin/zsh

set winaltkeys=no
set encoding=utf-8
"
" Be nice and check for multi_byte even if the config requires
" multi_byte support most of the time
if has("multi_byte")
    " Windows cmd.exe still uses cp850. If Windows ever moved to
    " Powershell as the primary terminal, this would be utf-8
    if (has('win16') || has('win32') || has('win64'))
        set termencoding=cp850
    endif
    " Let Vim use utf-8 internally, because many scripts require this
    set encoding=utf-8
    setglobal fileencoding=utf-8
    " Windows has traditionally used cp1252, so it's probably wise to
    " fallback into cp1252 instead of eg. iso-8859-15.
    " Newer Windows files might contain utf-8 or utf-16 LE so we might
    " want to try them first.
    set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
endif

" Setting up the directories {
set backup                  " Backups are nice ...
if has('persistent_undo')
    set undodir='~/.undodir/'
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

" GVIM- (here instead of .gvimrc)
"To maximize the initial Vim window under WindowsEdit
"Put the following in your vimrc to maximize Vim on startup (from :help win16-maximized):
" If you don't want to remove all autocommands, you can instead use a variable
" to ensure that Vim includes the autocommands only once: >
if !has('gui_running')
    set t_Co=256
endif
set noshowmode
" else
"     if &term == 'xterm' || &term == 'screen'
"         set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
"     endif
"     "set term=builtin_ansi       " Make arrow and other keys work
" endif

"if has('win32')
 ""   if has('nvim')
  ""      let localvimpath='~/AppData/Local/nvim/site'
   "" endif
"else
 ""   let localvimpath='~/.config/nvim'
"endif

if !empty($CONEMUBUILD)
    " echom "running in conemu"
" if !has('gui')
    "set term=$TERM          " Make arrow and other keys work
    set termencoding=utf8
    if !has('nvim')
        set term=xterm
    endif
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    colorscheme industry
    " colorscheme default
endif

" Appearance {{{1
"
set title
set background=dark         " Assume a dark background
" color manuscript_modified
" color solarized
"color jellybeans
color zenburn_modified
" Vim UI {
"set background=dark         " Assume a dark background
"let g:zenburn_high_Contrast=1

let g:prd_fontList="Source_Code_Pro:h9,CamingoCode:h8,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10"
let g:prd_fontIdx = 1
let g:prd_paperIdx = 7
let g:prd_lineNrIdx = 1
let g:prd_wrapIdx = 2

"set guifont=Anka/Code:h9,Consolas:h9
" set guifont=Source_Code_Pro:h9,CamingoCode:h10,Andale_Mono:h10

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set guioptions-=e
" set guioptions-=m
" set guioptions+=M
" set guioptions+=A
" set guioptions+=k

if has('win32')
    if has('nvim')
        " call GuiWindowMaximized(1)
        let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
    endif
endif
set termguicolors
" color cursor based on mode
set gcr=a:block
" mode aware cursors
set gcr+=o:hor50-Cursor
set gcr+=n:Cursor
set gcr+=i-ci-sm:InsertCursor
set gcr+=r-cr:ReplaceCursor-hor20
set gcr+=c:CommandCursor
set gcr+=v-ve:VisualCursor
set gcr+=a:blinkon0
hi InsertCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=37  guibg=#2aa198
hi VisualCursor  ctermfg=15 guifg=#fdf6e3 ctermbg=125 guibg=#d33682
hi ReplaceCursor ctermfg=15 guifg=#fdf6e3 ctermbg=65  guibg=#dc322f
hi CommandCursor ctermfg=15 guifg=#fdf6e3 ctermbg=166 guibg=#cb4b16
highlight Cursor guifg=white guibg=black
highlight iCursor guifg=white guibg=steelblue
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver25-iCursor
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10


let mapleader = ";"
let maplocalleader = ";"

set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
"set autowrite                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set history=1000                    " Store a ton of history (default is 20)
" set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving

" let cursor go beyond eol"
set virtualedit=block " onemore	   	" allow for cursor beyond last character

" Excluding version control directories
" set wildignore+=*/.git/*,*/.hg/*,*/.svn/*        " Linux/MacOSX
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*  " Windows ('nohellslash')
" set showtabline=2
"set tabpagemax=10
set so=1
set lbr
set dy=
set nornu
set cuc
"set cc=80
set nospell
set spell spelllang=en_us

"
" fix pause when leaving insert mode
set ttimeoutlen=50

let g:clipbrdDefaultReg = '+'
set modelines=5

set colorcolumn=79,131

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background for
" things like vim-gitgutter

highlight clear LineNr          " Current line number row will have same background color in relative mode.
" Things like vim-gitgutter will match LineNr highlight

if has('cmdline_info')
    set ruler                   " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd                 " Show partial commands in status line and
    " Selected characters/lines in visual mode
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" set foldenable                  " Auto fold code
set list
set listchars=tab:»·,trail:·,extends:#,nbsp:. " Highlight problematic whitespace

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**
" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
command! MakeTags !ctags -R .

" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack
" }

" Formatting {{{2

set wrap                      " Wrap long lines
""set nowrap                      " Wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set shiftround                  " when indenting, round odd number of leading spaces to nearest shiftwidth
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)


"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
" GUI Settings {


if has ('unix')  " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

" use * register for unnamed - this works better in Windows"
if has ('w32')
    set clipboard=unnamed
endif

" unnamedplus seems to copy anything selected into clipboard, try unnamed 20160902
" set clipboard+=unnamed
" Guifont Droid Sans Mono Dotted
" Guifont Consolas

" set default printing to not use syntax highlighting; this will probably
" break the intent of using Hardcopy function below
set printoptions=number:y
" set printoptions = syntax:n,number:y
hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE
" other customizations {{{2
set completeopt=menu,preview,longest
" }

" Ctags {
set tags+=./tags; " D:/dev/hybris/bin

" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif
" }

" Python stuff {{{2
"
" Indent Python in the Google way.


let s:maxoff = 50 " maximum number of lines to look backwards.

let pyindent_nested_paren="&sw*2"
let pyindent_open_paren="&sw*2"
" end Google python indenting


" disable numbers plugin because it may be causing display issues
let g:enable_numbers = 0
"
" Session List {
" set sessionoptions-=buffers
set sessionoptions-=help
set sessionoptions-=blank
" set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
nmap <leader>sl :SLoad<CR>
nmap <leader>ss :SSave<CR>
" }

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif
"
"
" Disable the neosnippet preview candidate window
" When enabled, there can be too much visual noise
" especially when splits are used.
" set completeopt-=preview
" }
"
set relativenumber

" nmap <Leader>ww :tabe ~/gdrive/text/index.txt<CR>
" nmap <Leader>2ww :tabe ~/Documents/UniFirst/wiki/index.txt<CR>
" disable error beep, flash window instead:
set vb

" nnoremap <silent> <C-]> :exe "tjump ".expand("<cscope>")<CR>
" nmap <leader>f :set guifont=*<CR>

" mucomplete recommendations
" <c-h> and <c-l> cycles completion methods
" set completeopt+=menu,menuone
set shortmess+=c
" set completeopt+=noinsert,noselect
" 
" nnoremap gm m
" nmap <F5> :TODOToggle<CR>
" :noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
set nofoldenable
let g:unite_force_overwrite_statusline = 0
" let g:vimfiler_force_overwrite_statusline = 0
" let g:vimshell_force_overwrite_statusline = 0
"
" FILE BROWSING {{{4

" Tweaks for browsing
let g:netrw_banner=1        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings
" We can also set the width of the window. The value is set in percent of the total window width:
let g:netrw_winsize = 25
" Toggle explore with Ctrl-e
" let loaded_netrwPlugin = 1


set timeout           " for mappings
set timeoutlen=1000   " default value
set ttimeout          " for key codes
set ttimeoutlen=10    " unnoticeable small value
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE {{{4
" see: :help 'statusline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set statusline=         "reset
" set statusline+=%#todo# "set color
" set statusline+=[       "open bracket char
" set statusline+=%n      "buffer number
" set statusline+=%M      "modifiable/modified flag
" set statusline+=%R      "Readonly flag
" set statusline+=%W      "Preview window flag
" set statusline+=]%*     "close bracket & reset color
" set statusline+=%<      "cut from here if line is too long
" set statusline+=./%f    "relative path of the filename
" set statusline+=[%{strlen(&fenc)?&fenc:'wtf-enc'}\| "file encoding
" set statusline+=%{&ff}\| "file format
" set statusline+=%{strlen(&ft)?&ft:'zomg'}] "file type
" set statusline+=%=      "left/right separator
" set statusline+=%{fugitive#statusline()}\  "git branch
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ (%P)  "escaped space, percent through file
set laststatus=2

" " Broken down into easily includeable segments
" set statusline=[\%{mode()}\]
set statusline=%<%f\                     " Filename
set statusline+=%w%h%m%r                 " Options
set statusline+=%{fugitive#statusline()} " Git Hotness
set statusline+=\ [%{&ff}/%Y]            " Filetype
" set statusline+=\ [%{getcwd()}]          " Current dir
set statusline+=\ [       "open bracket char
set statusline+=%.25{anzu#search_status()} "limit to 25 chars
set statusline+=]\ +[       "open bracket char
set statusline+=%.25{@+}                      " ditto for clipbd
set statusline+=]       "open bracket char
set statusline+=%=                       "align right
set statusline+=char:%b\ 0x%B           "char under cursor
set statusline+=\ [%{&fo}]\                  " formatoptions
set statusline+=%p%%\ offset\ %o\                 "percent of file, offset from start"
set statusline+=col\ %c\                   "column
set statusline+=line\ %l/%L                   "line #/total lines
" set statusline+=col\ %c%V:%b                  "column, virtual column number if different, char value under cursor
set statusline+=%#warningmsg#                 " Syntastic error flag
" set statusline+=%{SyntasticStatuslineFlag()}  " Syntastic error flag
set statusline+=%*                            " Syntastic error flag %b/%B)\ %p%%  " Right aligned file nav info

" :call libcallnr("vimtweak64.dll", "EnableMaximize", 1)
" set lines=90
" set columns=300
" set completeopt=menuone,noinsert,noselect
set gdefault " use global flag by default in s: commands
" Zoom / Restore window.
command! ZoomToggle call s:ZoomToggle()

" in neovim, equivalent of .vim directory is C:\Users\allencb\AppData\Local\nvim\site
"
" Plug options: {{{1
"
"| Option                  | Description                                      |
"| ----------------------- | ------------------------------------------------ |
"| `branch`/`tag`/`commit` | Branch/tag/commit of the repository to use       |
"| `rtp`                   | Subdirectory that contains Vim plugin            |
"| `dir`                   | Custom directory for the plugin                  |
"| `as`                    | Use different name for the plugin                |
"| `do`                    | Post-update hook (string or funcref)             |
"| `on`                    | On-demand loading: Commands or `<Plug>`-mappings |
"| `for`                   | On-demand loading: File types                    |
"| `frozen`                | Do not update unless explicitly specified        |
"
" More information: https://github.com/junegunn/vim-plug
if has('vim_starting')
    if has('nvim')
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall | source $MYVIMRC
        endif
        call plug#begin('~/.config/nvim/site/plugged')
    else "if (has('win16') || has('win32') || has('win64'))
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall | source $MYVIMRC
        endif
        call plug#begin('~/.vim/plugged')
    endif

" writing aids {{{2
    Plug 'ajh17/VimCompletesMe'
    " Plug 'ap/vim-buftabline'
    "*" "Plug 'bronson/vim-trailing-whitespace'
    "*" "Plug 'chemzqm/denite-extra'
    "*" "Plug 'chemzqm/unite-location'
    "*" "Plug 'chrisbra/NrrwRgn'
    "*" "Plug 'chrisbra/Recover.vim'
    "*" "Plug 'craigemery/vim-autotag'
    "*" "Plug 'Dalker/vim-now'
    "*" "Plug 'davidhalter/jedi-vim', { 'for': 'python', 'frozen': '1'}
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'tmhedberg/SimpylFold', {'for': 'python'}
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
    Plug 'godlygeek/tabular'
    Plug 'reedes/vim-pencil'
    " Plug 'internationa1/write-as.vim'
    "*" "Plug 'Dimercel/todo-vim'
    "*" "Plug 'drmingdrmer/xptemplate'
    "*" "Plug 'ervandew/supertab'
    "*" "Plug 'eugen0329/vim-esearch'
    "*" "Plug 'evansalter/vim-checklist'
    " Plug 'fmoralesc/vim-pad'
    "*" "Plug 'fweep/vim-tabber/'
    "*" "Plug 'geetarista/ego.vim'
    "*" "Plug 'gioele/vim-autoswap'
    "*" "Plug 'henrik/vim-indexed-search' "*"anzu replaces
    "*" "Plug 'honza/vim-snippets'
    "*" "Plug 'https://github.com/fmoralesc/vim-pad'
    "*" "Plug 'itchyny/lightline.vim' 
    "*" "Plug 'jamessan/vim-gnupg'
    "*" "Plug 'juneedahamed/vc.vim'
    "*" "Plug 'justinmk/vim-sneak'
    "*" "Plug 'KabbAmine/lazyList.vim'
    "*" "Plug 'KeyboardFire/vim-minisnip'
    "*" "Plug 'klen/python-mode', { 'for': 'python' }
    "*" "Plug 'Konfekt/FastFold'
    "*" "Plug 'ktonga/vim-follow-my-lead'
    " Plug 'lukaszkorecki/workflowish'
    Plug 'tarnas14/workflowish'
"*" help {{{2
    Plug 'lifepillar/vim-cheat40' "*" 20170928
    Plug 'tomtom/zeal_vim'
    "*" "Plug 'lifepillar/vim-mucomplete' "*" 20170825
    "*" "Plug 'Lokaltog/vim-easymotion' "*" replaced by vim-sneak
    "*" "Plug 'lucasoman/vim-listfile'
    "*" "Plug 'LucHermitte/lh-brackets'
    "*" "Plug 'LucHermitte/lh-dev'    
    "*" "Plug 'LucHermitte/lh-style'
    "*" "Plug 'LucHermitte/lh-vim-lib'
    "*" "Plug 'LucHermitte/mu-template'
    "*" "Plug 'maralla/completor.vim'
    "*" "Plug 'marcopaganini/mojave-vim-theme'
    "*" "Plug 'mbbill/vimExplorer'
    "*" "Plug 'mfukar/robotframework-vim'
    "*" "Plug 'michalbachowski/vim-wombat256mod'
    "*" "Plug 'mileszs/ack.vim' - now using ripgrep rg 
    "*" "Plug 'mir-mal/reco'
    "*" "Plug 'mmai/vim-markdown-wiki'
    "*" "Plug 'mmai/vim-markdown-wiki' "*" doesn't seem to work 20151208, but
    "*" "Plug 'mrtazz/simplenote.py'
    "*" "Plug 'mrtazz/simplenote.vim', {'frozen': '1'}
    "*" "Plug 'mtth/scratch.vim'
    "*" "Plug 'nathanaelkane/vim-indent-guides'
    "*" "Plug 'osyo-manga/vim-over'
    "*" "Plug 'Raimondi/delimitMate'
    "*" "Plug 'romgrk/winteract.vim'
    "*" "Plug 'Rykka/riv.vim'
    "*" "Plug 'saltstack/salt-vim', {'frozen': '1'}
    " Plug 'Shougo/denite.nvim'
    "*" "Plug 'Shougo/denite.nvim', {'frozen': '1'}
    "*" "Plug 'Shougo/deoplete.nvim', has('nvim') ? {'do': ':UpdateRemote"Plugins' } : { 'on': []}
    "*" "Plug 'Shougo/neocomplete.vim' , has('gui') ? {} : { 'on': [] }
    "*" "Plug 'Shougo/neomru.vim'
    "*" "Plug 'Shougo/neosnippet'
    "*" "Plug 'Shougo/neosnippet-snippets'
    "*" "Plug 'Shougo/neoyank.vim'
    "*" "Plug 'Shougo/unite-outline'
    "*" "Plug 'Shougo/unite.vim'
    "*" "Plug 'Shougo/vimfiler.vim'
    "*" "Plug 'Shougo/vimproc'
    "*" "Plug 'Shougo/vimproc'
    "*" "Plug 'Shougo/vimproc' this is in http://www.kaoriya.net/software/vim/ install directory
    "*" "Plug 'Shougo/vimproc', {'frozen': '1'}
    "*" "Plug 'sirver/ultisnips'
    "*" "Plug 'skywind3000/asyncrun.vim'
    "*" "Plug 'svermeulen/vim-easyclip'
    "*" "Plug 'szw/vim-ctrlspace'
    "*" "Plug 'terryma/vim-expand-region'
    "*" "Plug 'terryma/vim-multiple-cursors'
    "*" "Plug 'tommcdo/vim-lion'
    "*" "Plug 'tomtom/stakeholders_vim'
    "*" "Plug 'tomtom/tcomment_vim'
    "*" "Plug 'tomtom/tskeleton_vim'
    " Plug 'tomtom/ttodo_vim'
    "*" "Plug 'tpope/vim-fireplace'
    "*" "Plug 'trevorrjohn/vim-obsidian'
    "*" "Plug 'tsukkee/unite-tag'
    "*" "Plug 'tweekmonster/braceless.vim'
    "*" "Plug 'tyru/restart.vim'
    "*" "Plug 'ujihisa/unite-font'
    "*" "Plug 'unblevable/quick-scope'
    "*" "Plug 'vadv/vim-chef'
    "*" "Plug 'vim-airline/vim-airline'
    "*" "Plug 'vim-airline/vim-airline-themes'
    "*" "Plug 'vim-scripts/cwiki'
    "*" "Plug 'vim-scripts/DrawIt'
    "*" "Plug 'vim-scripts/Efficient-python-folding'
    "*" "Plug 'vim-scripts/Headlights' , has('gui') ? {} : { 'on': []}
    "*" "Plug 'vim-scripts/hyperlist', {'frozen': '1'}
    "*" "Plug 'vim-scripts/jpythonfold.vim'
    "*" "Plug 'vim-scripts/matchit.zip'
    "*" "Plug 'vim-scripts/restore_view.vim'
    "*" "Plug 'vim-scripts/searchfold.vim'
    "*" "Plug 'vim-scripts/SideBar.vim'
    "*" "Plug 'vim-scripts/snippet.vim'
    "*" "Plug 'vim-scripts/Tabmerge'
    "*" "Plug 'vim-scripts/TFS'
    "*" "Plug 'vim-scripts/txt.vim'
    "*" "Plug 'vim-scripts/vcscommand.vim'
    "*" "Plug 'vim-scripts/VerticalHelp'
    Plug 'vim-scripts/VisIncr'

    " organization {{{2
    "*" "Plug 'vimoutliner/vimoutliner'
    "*" "Plug 'vimoutliner/vimoutliner', { 'frozen': '1' }
    "*" "Plug 'visi-pivi-sivi/leerkan-vim-colors'
    "*" "Plug 'vitalk/vim-simple-todo'
    "*" "Plug 'webdevel/tabulous'
    "*" "Plug 'wellle/targets.vim'
    "*" "Plug 'wincent/ferret'
    "*" "Plug 'xolox/vim-notes', { 'frozen': '1' }
    "*" "Plug 'xolox/vim-session'
    "*" put pandoc stuff last so that .txt gets interpreted as pandoc
    "*", has('nvim') ? {} : { 'on': [] }

"*" coding {{{2
    Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
    Plug 'pangloss/vim-javascript', { 'for': 'js' }
    Plug 'scrooloose/syntastic'
    Plug 'stephpy/vim-yaml'
    Plug 'vim-scripts/HTML-AutoCloseTag', { 'for': 'html' }
    " Plug 'vim-scripts/VimClojure'

"*" version control {{{3
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

"*" python {{{3
    " Plug 'ambv/black'
    Plug 'fs111/pydoc.vim', { 'for': 'python'}
    Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins' }
    Plug 'vim-scripts/python.vim', { 'for': 'python' }
    Plug 'vim-scripts/python_match.vim', { 'for': 'python' }
    "*" "Plug 'altercation/vim-colors-solarized'
    "*" "Plug 'bhurlow/vim-parinfer'    
    "*""Plug 'davidhalter/jedi-vim', { 'for': 'python'}

"*" search {{{2
    Plug 'osyo-manga/vim-anzu'
    " Plug 'dyng/ctrlsf.vim'
    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/incsearch.vim'
    Plug 'haya14busa/incsearch-easymotion.vim'
    Plug 'equalsraf/neovim-gui-shim' , has('nvim') ? {} : { 'on': [] }
    Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
    Plug 'lotabout/skim.vim'
    Plug 'ludovicchabant/vim-gutentags'
    " Plug 'majutsushi/tagbar'
    Plug 'xolox/vim-easytags'
    " Plug 'Yggdroot/LeaderF', { 'do': '.\install.sh' }
    " Plug 'Yggdroot/LeaderF-marks'
    Plug 'junegunn/fzf' ", { 'do': './install --bin' }
    Plug 'ibhagwan/fzf-lua'
    Plug 'vijaymarupudi/nvim-fzf'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'junegunn/fzf.vim'
    " Plug 'pbogut/fzf-mru.vim'
    " Plug 'rhysd/clever-f.vim' " https://github.com/rhysd/clever-f.vim
    " replaced by easymotion

"*" pkb {{{2
    " Plug 'brtastic/vorg'
    Plug 'vim-voom/VOoM'
    Plug 'dbeniamine/todo.txt-vim'
    "*" "Plug 'humiaozuzu/tabbar'
    " Plug 'jceb/vim-orgmode'
    " Plug 'filaretov/vim-orgzly' 
    "*" "Plug 'jeetsukumaran/vim-filebeagle'
    "*" "Plug 'joereynolds/deoplete-minisnip'
    "*" "Plug 'joereynolds/vim-minisnip'
    Plug 'junegunn/vim-journal'
    Plug 'junegunn/vim-peekaboo'
    Plug 'kshenoy/vim-signature'
    " Plug 'vimwiki/vimwiki', { 'branch': 'dev' }
    "*" "Plug 'luochen1990/rainbow'
    Plug 'alok/notational-fzf-vim'
    Plug 'isene/hyperlist.vim'
    Plug 'wren/jrnl.vim'

"*" utilities {{{2
    " Plug 'akinsho/bufferline.nvim'
    " Plug 'francoiscabrol/ranger.vim'
    " Plug 'kevinhwang91/rnvimr'
    " Plug 'vim-ctrlspace/vim-ctrlspace'
    " Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'folke/which-key.nvim'

    Plug 'kevinhwang91/nvim-bqf'
    " Plug 'ipod825/vim-netranger'
    " Plug 'rafaqz/ranger.vim'
    Plug 'mbbill/undotree'
    " Plug 'mg979/vim-xtabline'
    Plug 'mhinz/vim-hugefile'
    Plug 'mhinz/vim-startify'
    Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
    " if has('nvim')
    "     Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " else
    "    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
    " endif
    Plug 'Shougo/neco-syntax'
    Plug 'tomtom/autolinker_vim'
    Plug 'tomtom/tlib_vim'
    " Plug 'tpope/vim-speeddating' 
    Plug 'vim-scripts/ingo-library'
    "*" "Plug 'vim-scripts/LargeFile' "*" replaced by vim-hugefile
    Plug 'vim-scripts/Printer-Dialog'
    Plug 'vim-scripts/utl.vim'
    Plug 'voldikss/vim-floaterm'
    "*" "Plug 'sandeepcr529/Buffet.vim'
    "*" "Plug 'scrooloose/nerdtree'
    "*""Plug 'zchee/deoplete-jedi'
    Plug 'tpope/vim-characterize'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
	Plug 'tweekmonster/exception.vim'
    Plug 'vifm/vifm.vim'
    Plug 'vim-pandoc/vim-pandoc'
    Plug 'vim-pandoc/vim-pandoc-after'
    Plug 'vim-pandoc/vim-pandoc-syntax'
    Plug 'vim-scripts/CaptureClipboard'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-shell'
    Plug 'Yggdroot/indentLine'

"*" UI {{{2
    Plug 'romgrk/barbar.nvim'
    Plug 'molok/vim-smartusline'
    Plug 'xolox/vim-colorscheme-switcher'
    "*" "Plug 'zefei/vim-wintabs'
	"*" endif
	"*" if has('nvim')
    call plug#end()
endif


" Functions {{{1
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! Hardcopy call Hardcopy()
function! Hardcopy()
    set printoptions=syntax:n,number:n,paper:letter,duplex:off
    setlocal formatoptions=tw
    setlocal textwidth=86
    normal gg
    normal gqG
  let colors_save = g:colors_name
  colorscheme print_bw
  hardcopy
  execute 'colorscheme' colors_save
endfun

command! Hardcopyl call Hardcopyl()
function! Hardcopyl()
    set printoptions=syntax:n,number:n,paper:letter,duplex:off
    setlocal formatoptions=
    setlocal textwidth=132
    normal gg
    normal gqG
  let colors_save = g:colors_name
  colorscheme print_bw
  hardcopy
  execute 'colorscheme' colors_save
endfun

function! GetGooglePythonIndent(lnum)

  " Indent inside parens.
  " Align with the open paren unless it is at the end of the line.
  " E.g.
  "   open_paren_not_at_EOL(100,
  "                         (200,
  "                          300),
  "                         400)
  "   open_paren_at_EOL(
  "       100, 200, 300, 400)
  call cursor(a:lnum, 1)
  let [par_line, par_col] = searchpairpos('(\|{\|\[', '', ')\|}\|\]', 'bW',
        \ "line('.') < " . (a:lnum - s:maxoff) . " ? dummy :"
        \ . " synIDattr(synID(line('.'), col('.'), 1), 'name')"
        \ . " =~ '\\(Comment\\|String\\)$'")
  if par_line > 0
    call cursor(par_line, 1)
    if par_col != col("$") - 1
      return par_col
    endif
  endif

  " Delegate the rest to the original function.
  return GetPythonIndent(a:lnum)
endfunction

function! ToggleExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction

"function! s:my_cr_function() abort
"	  return deoplete#close_popup() . "\<CR>"
"endfunction

function! Cream_case_title(mode)
" Title Case -- uppercase characters following whitespace

	if a:mode == "v"
		normal gv
		" Hack: fix Vim's gv proclivity to add a line when at line end
		if virtcol(".") == 1
			normal '>
			" line select
			normal gV
			" up one line
			normal k
			" back to char select
			normal gV
			"""" back up one char
			"""normal h
		endif
	else
		let mypos = Cream_pos()
		" select current word
		normal v
		normal aw
	endif
	" yank
	normal "xy
	" lower case entire string
	let @x = tolower(@x)
	" capitalize first in series of word chars
	let @x = substitute(@x, '\w\+', '\u&', 'g')
	" lowercase a few words we always want lower
	let @x = substitute(@x, '\<A\>', 'a', 'g')
	let @x = substitute(@x, '\<An\>', 'an', 'g')
	let @x = substitute(@x, '\<And\>', 'and', 'g')
	let @x = substitute(@x, '\<In\>', 'in', 'g')
	let @x = substitute(@x, '\<The\>', 'the', 'g')
	" lowercase apostrophe s
	let @x = substitute(@x, "'S", "'s", 'g')
	" fix first word again
	let @x = substitute(@x, '^.', '\u&', 'g')
	" fix last word again
	let str = matchstr(@x, '[[:alnum:]]\+[^[:alnum:]]*$')
	let @x = substitute(@x, str . '$', '\u&', 'g')
	"" optional lowercase...
	"let n = confirm(
	"    \ "Lowercase additional conjunctions, adpositions, articles, and forms of \"to be\"?\n" .
	"    \ "\n", "&Ok\n&Cancel", 2, "Info")
	"if n == 1
	"    " lowercase conjunctions
	"    let @x = substitute(@x, '\<After\>', 'after', 'g')
	"    let @x = substitute(@x, '\<Although\>', 'although', 'g')
	"    let @x = substitute(@x, '\<And\>', 'and', 'g')
	"    let @x = substitute(@x, '\<Because\>', 'because', 'g')
	"    let @x = substitute(@x, '\<Both\>', 'both', 'g')
	"    let @x = substitute(@x, '\<But\>', 'but', 'g')
	"    let @x = substitute(@x, '\<Either\>', 'either', 'g')
	"    let @x = substitute(@x, '\<For\>', 'for', 'g')
	"    let @x = substitute(@x, '\<If\>', 'if', 'g')
	"    let @x = substitute(@x, '\<Neither\>', 'neither', 'g')
	"    let @x = substitute(@x, '\<Nor\>', 'nor', 'g')
	"    let @x = substitute(@x, '\<Or\>', 'or', 'g')
	"    let @x = substitute(@x, '\<So\>', 'so', 'g')
	"    let @x = substitute(@x, '\<Unless\>', 'unless', 'g')
	"    let @x = substitute(@x, '\<When\>', 'when', 'g')
	"    let @x = substitute(@x, '\<While\>', 'while', 'g')
	"    let @x = substitute(@x, '\<Yet\>', 'yet', 'g')
	"    " lowercase adpositions
	"    let @x = substitute(@x, '\<As\>', 'as', 'g')
	"    let @x = substitute(@x, '\<At\>', 'at', 'g')
	"    let @x = substitute(@x, '\<By\>', 'by', 'g')
	"    let @x = substitute(@x, '\<For\>', 'for', 'g')
	"    let @x = substitute(@x, '\<From\>', 'from', 'g')
	"    let @x = substitute(@x, '\<In\>', 'in', 'g')
	"    let @x = substitute(@x, '\<Of\>', 'of', 'g')
	"    let @x = substitute(@x, '\<On\>', 'on', 'g')
	"    let @x = substitute(@x, '\<Over\>', 'over', 'g')
	"    let @x = substitute(@x, '\<To\>', 'to', 'g')
	"    let @x = substitute(@x, '\<With\>', 'with', 'g')
	"    " lowercase articles
	"    let @x = substitute(@x, '\<A\>', 'a', 'g')
	"    let @x = substitute(@x, '\<An\>', 'an', 'g')
	"    let @x = substitute(@x, '\<The\>', 'the', 'g')
	"    " lowercase forms of to be
	"    let @x = substitute(@x, '\<Be\>', 'be', 'g')
	"    let @x = substitute(@x, '\<To\> \<Be\>', 'to be', 'g')
	"    let @x = substitute(@x, '\<To\> \<Do\>', 'to do', 'g')
	"    " lowercase prepositions
	"    " lowercase conjunctions
	"endif
	" reselect
	normal gv
	" paste over selection (replacing it)
	normal "xP
	" return state
	if a:mode == "v"
		normal gv
	else
		execute mypos
	endif
endfunction

" set tabline=%!MyTabLine()  " custom tab pages line
function! MyTabLine()
  let s = ''
  " loop through each tab page
  for i in range(tabpagenr('$'))
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#' " WildMenu
    else
      let s .= '%#Title#'
    endif
    " set the tab page number (for mouse clicks)
    let s .= '%' . (i + 1) . 'T '
    " set page number string
    let s .= i + 1 . ''
    " get buffer names and statuses
    let n = ''  " temp str for buf names
    let m = 0   " &modified counter
    let buflist = tabpagebuflist(i + 1)
    " loop through each buffer in a tab
    for b in buflist
      if getbufvar(b, "&buftype") == 'help'
        " let n .= '[H]' . fnamemodify(bufname(b), ':t:s/.txt$//')
      elseif getbufvar(b, "&buftype") == 'quickfix'
        " let n .= '[Q]'
      elseif getbufvar(b, "&modifiable")
        let n .= fnamemodify(bufname(b), ':t') . ', ' " pathshorten(bufname(b))
      endif
      if getbufvar(b, "&modified")
        let m += 1
      endif
    endfor
    " let n .= fnamemodify(bufname(buflist[tabpagewinnr(i + 1) - 1]), ':t')
    let n = substitute(n, ', $', '', '')
    " add modified label
    if m > 0
      let s .= '+'
      " let s .= '[' . m . '+]'
    endif
    if i + 1 == tabpagenr()
      let s .= ' %#TabLineSel#'
    else
      let s .= ' %#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space
    let s .= ' '
  endfor
  let s .= '%#TabLineFill#%T'
  " right-aligned close button
  " if tabpagenr('$') > 1
  "   let s .= '%=%#TabLineFill#%999Xclose'
  " endif
  return s
endfunction

" Initialize directories {
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
                \ 'backup': 'backupdir',
                \ 'views': 'viewdir',
                \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif
    "
    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_consolidated_directory = <full path to desired directory>
    "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
    if exists('g:spf13_consolidated_directory')
        let common_dir = g:spf13_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif
    "
    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction
call InitializeDirectories()
" }

" Strip whitespace {
function! StripTrailingWhitespace()
    " To disable the stripping of whitespace, add the following to your
    " .vimrc.before.local file:
    "   let g:spf13_keep_trailing_whitespace = 1
    if !exists('g:spf13_keep_trailing_whitespace')
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        %s/\s\+$//e
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endif
endfunction
" }

" Shell command {
function! s:RunShellCommand(cmdline)
    botright new
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal nobuflisted
    setlocal noswapfile
    setlocal nowrap
    setlocal filetype=shell
    setlocal syntax=shell
    call setline(1, a:cmdline)
    call setline(2, substitute(a:cmdline, '.', '=', 'g'))
    execute 'silent $read !' . escape(a:cmdline, '%#')
    setlocal nomodifiable
    1
endfunction

command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
" e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
" }


"let g:bookmarking_menu = 1

""define bookmark text=>>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" mappings {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" standard vim functions .................................
"

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" highlight last inserted text
" This one is pretty cool. It visually selects the block of characters you added last time you were in INSERT mode.
nnoremap gV `[v`]

" folding using /search/ pattern
" \z
" This folds every line that does not contain the search pattern.
" see vimtip #282 and vimtip #108
noremap <silent><leader>z :set foldexpr=getline(v:lnum)!~@/ foldlevel=0 foldcolumn=0 foldmethod=expr<CR>
" this folds all classes and function to create a code index.
" mnemonic: think "function fold"
noremap zff :/^\s*class\s\\|^\s*function\s\\|^\s*def\s/<CR>:set foldmethod=expr foldlevel=0 foldcolumn=1<CR><CR>
" space toggles the fold state under the cursor.
" nnoremap <silent><space> :exe 'silent! normal! za'.(foldlevel('.')?'':'l')<cr>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h
nnoremap <Leader>cd :lcd %:p:h<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to - redundant with UniteWithCursorWord line
" nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Code folding options
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>


" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


if has("nvim")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
    " GuiFont! Consolas:h10
endif


"use control-tab to cycle through buffers, NOT tabs
" :nnoremap <C-Tab> :bnext<CR>
" :nnoremap <S-C-Tab> :bprevious<CR>

" Use CTRL-S for saving, also in Insert mode
noremap  <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>

" Some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
" inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"


" CTRL-X = cut
" vnoremap <C-X> "*x
" CTRL-C = copy
" vnoremap <C-C> "*y

" copy text to "+ (clipboard)
vmap <Leader>y "+y
" CTRL-R * will insert in the contents of the clipboard
" CTRL-R " (the unnamed register) inserts the last delete or yank.
        " paste text from "+ (clipboard)
inoremap <Leader>p <ESC>pa
inoremap <Leader>P <ESC>Pa
nnoremap <Leader>p "+p
vnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P
" inoremap <Leader>p <Space><Esc>"+P<Right>xi
nnoremap <Leader><Leader> V
" only show the current buffer
" noremap <Leader>c :only<CR>

" Surround word with quote
noremap <Leader>' ysiw'
noremap <Leader>" ysiw"

" Add Trailing Semi-colon
" noremap <Leader>; g_a;<Esc>
nnoremap <leader>cc :CaptureClipboard!<CR>
" prepend clips:
nnoremap <leader>cr <Plug>CaptureClipboardReverse!<CR>

" vim-expand-region
    " Hit v to select one character
    " Hit vagain to expand selection to word
    " Hit v again to expand to paragraph
    " Hit <C-v> go back to previous selection if I went too far
" vnoremap v <Plug>(expand_region_expand)
" vnoremap <C-v> <Plug>(expand_region_shrink)

" Alt+leftarrow will go one window left, etc.
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>
inoremap <silent> <A-Up> :wincmd k<CR>
inoremap <silent> <A-Down> :wincmd j<CR>
inoremap <silent> <A-Left> :wincmd h<CR>
inoremap <silent> <A-Right> :wincmd l<CR>

" barbar mappings" NOTE: If barbar's option dict isn't created yet, create it
" let bufferline = get(g:, 'bufferline', {}):
" Magic buffer-picking mode
nnoremap <silent> <C-a>    :BufferPick<CR>
" Move to previous/next
nnoremap <silent>    <A-,> :BufferPrevious<CR>
nnoremap <silent>    <A-.> :BufferNext<CR>
" Re-order to previous/next
nnoremap <silent>    <A-<> :BufferMovePrevious<CR>
nnoremap <silent>    <A->> :BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent>    <A-1> :BufferGoto 1<CR>
nnoremap <silent>    <A-2> :BufferGoto 2<CR>
nnoremap <silent>    <A-3> :BufferGoto 3<CR>
nnoremap <silent>    <A-4> :BufferGoto 4<CR>
nnoremap <silent>    <A-5> :BufferGoto 5<CR>
nnoremap <silent>    <A-6> :BufferGoto 6<CR>
nnoremap <silent>    <A-7> :BufferGoto 7<CR>
nnoremap <silent>    <A-8> :BufferGoto 8<CR>
nnoremap <silent>    <A-9> :BufferLast<CR>
" Pin/unpin buffer
nnoremap <silent>    <A-p> :BufferPin<CR>
" Close buffer
nnoremap <silent>    <A-c> :BufferClose<CR>
" Wipeout buffer
"                          :BufferWipeout<CR>
" Close commands
"                          :BufferCloseAllButCurrent<CR>
"                          :BufferCloseAllButPinned<CR>
"                          :BufferCloseBuffersLeft<CR>
"                          :BufferCloseBuffersRight<CR>
" Enable/disable icons
" if set to 'buffer_number', will show buffer number in the tabline
" if set to 'numbers', will show buffer index in the tabline
" if set to 'both', will show buffer index and icons in the tabline
" let bufferline.numbers = v:true
" let bufferline.icons = "buffer_number"

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>
" Now 5[<space> inserts 5 blank lines above the current line.
"
map <F3> :Lex<CR>
" map <F3> :NERDTreeToggle<CR>
noremap! <expr> ,d strftime("%Y-%m-%d")

map <silent> <C-e> :call ToggleExplorer()<CR>
nnoremap <c-j> :execute 'tag '.expand('<cword>')<CR>
" <C-h>, <BS>: close popup and delete backword char.

" map <F2> :Bufferlist<CR>
" .....................
" function calls ........................................
"
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" Title Case selection or word if in insert mode
imap <silent> <F5>   <C-b>:call Cream_case_title("i")<CR>
vmap <silent> <F5>   :<C-u>call Cream_case_title("v")<CR>

nnoremap <silent> <Leader>z :ZoomToggle<CR>

" activate/deactivate full screen with function key <F11>  
map <F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
"
nmap <silent> <Leader>ef  :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"   <cr>:set scb<cr>:wincmd h<cr>:set scb<cr>

"inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS>  deoplete#smart_close_popup()."\<C-h>"

" deoplete tab-complete cba 20190313 disable tab completion, use c-space as
" set in minisnip config elsewhere
" inoremap <expr><tab> pumvisible()? "\<c-n>" : "\<tab>"
"
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)

" clear status
nmap <Esc><Esc> <Plug>(anzu-clear-search-status)

" nmap <leader>xmh :Pandoc html -f markdown --smart --standalone --self-contained -c c:/Users/allencb/.dotfiles/css/github-pandoc.css --columns=1000
nmap <leader>xmh :!pandoc -f markdown -t html -T "%:r" --standalone --self-contained --data-dir %:p:h -c "~/.dotfiles/css/github-pandoc.css" "%" -o "%:p:r.html" --columns=1000
" nmap <leader>xmhh :!pandoc -f markdown -t html -T "%:r" --smart --standalone --self-contained --data-dir %:p:h -c "c:/Users/allencb/.dotfiles/css/github-pandoc.css" "%" -o "%:p:r.html""
" nmap <leader>xmd :!pandoc -f markdown -t docx  "%" -o "%:p:r.docx" --data-dir %:p:h
" nmap <leader>xmd :Pandoc docx -f markdown --reference-docx=C:/Users/allencb/.pandoc/templates/cba.docx --toc
nmap <leader>xmd :!pandoc --reference-doc=C:/Users/allencb/.pandoc/templates/cba.docx "%" -o "%:p:r.docx"
nmap <leader>xmdc :silent !start pandoc --reference-docx=C:/Users/allencb/.pandoc/templates/cba.docx --toc "%" -o "%:p:r.docx"
nmap <leader>xmp :silent !start pandoc --reference-doc=D:\wiki\custom-reference.pptx "%" -o "%:p:r.pptx"
nmap <leader>xhd :Pandoc docx -f html
" nmap <leader>xhd :!pandoc -f html -t docx  "%" -o "%:p:r.docx" --data-dir %:p:h
" put this in yaml:
" revealjs-url: C:/Users/allencb/AppData/Roaming/pandoc/reveal.js
nmap <leader>xms :Pandoc revealjs -s --self-contained<CR>
" nmap <leader>xms :!pandoc -t slideous -s --data-dir="C:\wiki" "%" -o "%:p:r.html"
" nmap <leader>xwm :!w2m "%" "%:r.md"
nmap <leader>xwm :%s/# \(.*\)$/* \1/ge<bar>%s/^= \(.*\) =$/# \1/ge<bar>%s/^== \(.*\) ==$/## \1/ge<bar>%s/^=== \(.*\) ===$/### \1/ge<bar>%s/^==== \(.*\) ====$/#### \1/ge<bar>%s/^===== \(.*\) =====$/##### \1/ge<bar>%s/^====== \(.*\) ======$/###### \1/ge
nmap <leader>xwm1 :%s/\[\[\(.*\)\]\]/\[\1\](\1)/gc
nmap <leader>xwm2 :%s/^# /1. /gc
nmap <leader>xwm3 :%s/    # /    1. /gc
nmap <leader>xwm4 :%s/^=== \(.*\)===/### \1/gc
nmap <leader>xwm5 :%s/^== \(.*\)==/## \1/gc
nmap <leader>xwm6 :%s/^= \(.*\)=/# \1/gc

nnoremap <Leader>u :UndotreeToggle<CR>
" inoremap <C-k>     <Plug>(neosnippet_expand_or_jump)
" snoremap <C-k>     <Plug>(neosnippet_expand_or_jump)
" xnoremap <C-k>     <Plug>(neosnippet_expand_target)
"
" Fugitive {
nnoremap <silent> <leader>gs :Gstatus
nnoremap <silent> <leader>gd :Gdiff
nnoremap <silent> <leader>gc :Gcommit
nnoremap <silent> <leader>gb :Gblame
nnoremap <silent> <leader>gl :Glog
nnoremap <silent> <leader>gp :Git push
nnoremap <silent> <leader>gr :Gread:GitGutter
nnoremap <silent> <leader>gw :Gwrite:GitGutter
nnoremap <silent> <leader>ge :Gedit
nnoremap <silent> <leader>gg :GitGutterToggle
"}
" JSON {
nnoremap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
" }
" Tabularize {{{2
nnoremap <Leader>a& :Tabularize /&<CR>
vnoremap <Leader>a& :Tabularize /&<CR>
nnoremap <Leader>a= :Tabularize /=<CR>
vnoremap <Leader>a= :Tabularize /=<CR>
nnoremap <Leader>a: :Tabularize /:<CR>
vnoremap <Leader>a: :Tabularize /:<CR>
nnoremap <Leader>a:: :Tabularize /:\zs<CR>
vnoremap <Leader>a:: :Tabularize /:\zs<CR>
nnoremap <Leader>a, :Tabularize /,<CR>
vnoremap <Leader>a, :Tabularize /,<CR>
nnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
vnoremap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }
nmap <Leader>ac <Plug>ToggleAutoCloseMappings
" key noremapping that I want
" go to wiki dir and open index file
" nnoremap <silent> <Leader>w :tabe /users/allencb/Documents/UniFirst/wiki/index.txt<CR>
" :Utl
nnoremap <Leader>q :Utl openLink underCursor tabe<CR>
"
" nnoremap [LeaderF] <Nop>
" nmap \ [LeaderF]
" nnoremap <Leader>f :<C-u>LeaderfFile<cr>
" nnoremap <Leader>b :<C-u>LeaderfBuffer<cr>
" nnoremap <Leader>m :<C-u>LeaderfMru<cr>
" nnoremap <Leader>. :<C-u>LeaderfMruCwd<cr>
" nnoremap <Leader>t :<C-u>LeaderfTag<cr>
" nnoremap <Leader>u :<C-u>LeaderfFunction<cr>
" nnoremap <Leader>h :<C-u>LeaderfHistoryCmd<cr>
" nnoremap <Leader>s :<C-u>LeaderfHistorySearch<cr>
" nnoremap <Leader>? :<C-u>LeaderfHelp<cr>
" nnoremap <Leader>/ :<C-u>LeaderfLine<cr>
" nnoremap <Leader>c :<C-u>Leaderf colorscheme<cr>
" nnoremap <Leader>w :<C-u>Leaderf --cword line<cr>
" nnoremap <Leader>> :<C-u>LeaderfMarks<cr>

nmap     <C-F>f <Plug>CtrlSFPrompt      " search {pattern} [path]
vmap     <C-F>F <Plug>CtrlSFVwordPath   " input visual selected string and wait for further input
vmap     <C-F>f <Plug>CtrlSFVwordExec   " search visual selected string
nmap     <C-F>c <Plug>CtrlSFCwordPath   " search cword
nmap     <C-F>/ <Plug>CtrlSFPwordPath   " search last search string
nnoremap <C-F>o :CtrlSFOpen<CR>         " open ctrlsf window, focus it
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" variables for plugins {{{1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:vifm_exec='C:\programs\vifm-w64-se-0.9.1-binary\vifm.exe'
" allow other todo.txt plugins to also work with Ttodo
" let g:ttodo_enable_ftdetect = 0
let g:ttodo#dirs=['~/sync/pkb',]

" }
" The Silver Searcher
" if executable('ag')
if executable('rg')
    " Use ag over grep
    " set grepprg=ag\ --nogroup\ --nocolor
    set grepprg=rg\ --vimgrep\ --smart-case\ --follow
    "set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    "let g:ctrlp_user_command = 'ag %s --files-with-matches -g "" --ignore "\.git$\|\.hg$\|\.svn$"'
    "let g:ctrlp_user_command = 'ag -l --nocolor -g %s'
    "let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
    " ag is fast enough that CtrlP doesn't need to cache
    "let g:ctrlp_use_caching = 0
endif
" The Silver Searcher
if executable('rg.exe')
    " Use ag over grep
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    " set grepprg=ag\ --nogroup\ --nocolor

endif

let g:autolinker_filetypes = ['text', 'todo', 'md', 'markdown', 'markdown.pandoc', 'tex', 'latex', 'pandoc']
"quick-scope -  Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" vim-follow-my-lead
let g:fml_all_sources =1

let g:svnj_cache_dir="C:/Users/allencb/vc_cache"
let g:vc_log_name="~/vclog.txt"

let python_highlight_all = 1

" Voom stuff {{{2
let g_voom_ft_modes = {'pandoc': 'pandoc', 'markdown': 'markdown', 'vimoutliner': 'vimoutliner', 'vimwiki': 'vimwiki'}
let g:voom_tree_width = 50
let g:voom_return_key = "<C-Return>"
let g:voom_tab_key = "<C-Tab>"

" syntastic {{{2
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
" hide location list (errors), show with :Error
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '⁉️'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '💩'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

" simplenote stuff
let g:SimplenoteUsername = "cba@knodal.com"
let g:SimplenotePassword = "moksha"
let g:SimplenoteVertical=1
let g:SimplenoteSingleWindow=1
let g:SimplenoteFiletype="markdown"

" checklist
" let g:checklist_use_timestamps = 1 "Default 0

" pandoc stuff {{{2
" vim-pandoc-after
" let g:pandoc#after#modules#enabled = ["unite", "vimcompletesme", "nrrwrgn", "tablemode"]
" let g:pandoc#after#modules#enabled = ["unite", "neosnippet", "nrrwrgn", "tablemode"]
let g:pandoc#after#modules#enabled = ["nrrwrgn", "vimcompletesme", "tablemode"]
" let g:pandoc#after#modules#enabled = ["unite", "nrrwrgn", "tablemode"]
let g:pandoc#modules#disabled = ['bibliographies', 'folding', 'TOC', 'keyboard']
let g:pandoc#modules#enabled = ['completion', 'command', 'formatting', 'menu', 'metadata', 'toc', 'hypertext']
" let g:pandoc#modules#enabled = ['completion', 'command', 'formatting', 'menu', 'metadata', 'keyboard', 'toc', 'chdir', 'spell', 'hypertext']
" use voom for folding, toc
" autocmd FileType pandoc :Voom pandoc
let g:pandoc#hypertext#editable_alternates_extensions = '\(pdf\|htm\|odt\|doc\docx\|html\)'
let g:pandoc#hypertext#edit_open_cmd = "tabedit"
let g:pandoc#hypertext#preferred_alternate = "txt"
let g:pandoc#hypertext#create_if_no_alternates_exists = 1
let g:pandoc#formatting#mode = "sA"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level = 2
let g:pandoc#folding#mode = "relative"
let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#syntax#colorcolumn = 1
" use pandoc plugin for markdown files but use markdown syntax and filetype:
" note that extra includes .txt and .text:
let g:pandoc#filetypes#handled = ["pandoc", "extra", "markdown", "rst", "textile"]
let g:pandoc#filetypes#pandoc_markdown = 0

" gpg stuff {{{2
let g:GPGExecutable = 'C:\programs\GNU\GnuPG\gpg2.exe'
let g:GPGPreferArmor = 1
let g:GPGDefaultRecipients = ['cba@knodal.com']

let g:indentLine_setColors = 0
" let g:indent_guides_start_level = 2
" let g:indent_guides_guide_size = 1
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4
" }

" vim-gitgutter {
" https://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0
" }
" vimwiki setup {{{2
" to connect local filesystem to my wiki on Atlassian bitbucket: (at)
" git remote add origin https://craig_allen@bitbucket.org/craig_allen/wiki.git
" git push -u origin master
" If you want to use this converter for temporary wikis then add these to .vimrc:

" autocmd FileType vimwiki call SetMarkdownOptions()

" function! SetMarkdownOptions()
"     call VimwikiSet('syntax', 'markdown')
"     call VimwikiSet('custom_wiki2html', 'wiki2html.sh')
" endfunction

       " \'template_path': 'C:\cba\pkm\cba-big\templates\', 
       " \'path_html': 'D:\wiki\html\'},
       " \'template_path': 'C:\cba\pkm\cba-big\templates\', 
au BufNewFile ~/sync/pkb/diary/*.txt :silent 0r !~/.local/bin/generate-vimwiki-diary-template '%'

let g:vimwiki_list = []
let g:vimwiki_list = [{
       \'path': '~/sync/pkb/*', 
       \'ext': '.txt', 
       \'template_default': 'default', 
       \'template_ext': '.html', 
       \'syntax': 'markdown', 
       \'index': 'index'}]
    " \ {'path': 'C:\Users\allencb\gdrv\wiki', 
    "    \'ext': '.md', 
    "    \'template_default': 'default', 
    "    \'template_ext': '.html', 
    "    \'syntax': 'markdown', 
    "    \'index': 'index'}]
" if (has('win16') || has('win32') || has('win64'))
"     let g:vimwiki_list = [{
"        \'path': 'D:\wiki\', 
"        \'ext': '.md', 
"        \'template_path': 'C:\cba\pkm\cba-big\templates\', 
"        \'template_default': 'default', 
"        \'template_ext': '.html', 
"        \'syntax': 'markdown', 
"        \'index': 'index', 
"        \'path_html': 'D:\wiki\html\'},
"     \ {'path': 'C:\Users\allencb\gdrv\wiki', 
"        \'ext': '.md', 
"        \'template_path': 'C:\cba\pkm\cba-big\templates\', 
"        \'template_default': 'default', 
"        \'template_ext': '.html', 
"        \'syntax': 'markdown', 
"        \'index': 'index'}]
    " au BufRead C:/cba/pkm/cba/wiki/index.md lcd C:/cba/pkm/cba/wiki | execute '!git pull'
    " au BufWritePost C:/cba/pkm/cba/wiki/* execute '!git add "%" & git commit -m "Auto commit + saved %" & git push'
" elseif has('nvim')
"     let g:vimwiki_list = [{'path': '/media/sf_D_DRIVE/wiki', 'ext': '.wiki', 'template_path': '/media/sf_C_DRIVE/Users/allencb/Documents/UniFirst_html/', 'template_default': 'default', 'template_ext': '.html', 'syntax': 'default', 'index': 'index', 'path_html': 'C:/wiki/html/'},
"                 \ {'path': '/media/sf_D_DRIVE/pkm/cba/wiki/', 'ext': '.wiki', 'template_path': '/media/sf_C_DRIVE/Users/allencb/gdrive/text_html', 'template_default': 'default', 'template_ext': '.html', 'syntax': 'default', 'index': 'index'}]
"     " augroup! vimwiki
"     " au! BufRead /media/sf_D_DRIVE/wiki/index.wiki !git pull
"     " au! BufWritePost /media/sf_D_DRIVE/wiki/* !git add ;git commit -m "Auto commit + push.";git push
"     " augroup END
" endif

let g:vimwiki_ext2syntax = {'.md': 'markdown',
                  \ '.mkd': 'markdown',}
                  " \ '.wiki': 'default'}

" let g:vimwiki_folding = 'list'
let g:vimwiki_auto_chdir = 1
let g:vimwiki_option_auto_toc = 1
let g:vimwiki_global_ext = 1
let g:vimwiki_folding = 'expr'
let g:vimwiki_hl_headers = 1
let g:vimwiki_custom_wiki2html = 'D:/downloads/wiki2html.cmd'
" don't let vimwiki hide markup stuff:
let g:vimwikiconceallevel=0
autocmd FileType markdown let g:indentLine_enabled=0
" /Users/allencb/.vim/vimpyre/vimwiki-dev/autoload/vimwiki/customwiki2html.cmd'
" let g:custom_wiki2html = '/Users/allencb/.vim/vimpyre/vimwiki-dev/autoload/vimwiki/customwiki2html.cmd'
" Handler for precise linking
" function! VimwikiWikiIncludeHandler(value)
    " let url = a:value
    " let url = matchstr(a:value, '{{\zs\%([^|}]*\)\ze|.*}}')
    " let url = matchstr(a:value, g:vimwiki_rxWikiInclMatchUrl)
    " let desc = matchstr(a:value, '{{.*|\zs\%([^|}]*\)\ze}}')
    " if desc = ''
    "     let desc = url
    " endif
    " if url[0] =~ '.'
        " let url = url[1:]
    " return '<a href="'.url.'">'.desc.'</a>'
    " endif
    " return ''
" endfunction
"
" :helptags ~/.vim/plugged
" if argc() == 0
"     lcd ~/gdrive/text/
"     autocmd VimEnter Note sidebar
" endif

" UndoTree {{{2
" " If undotree is opened, it is likely one wants to interact with it.
let g:undotree_SetFocusWhenToggle=1
let g:undotree_WindowLayout = 4
" }
" gundo
" nnoremap <F5> :GundoToggle<CR>
" let g:gundo_width = 60
" let g:gundo_preview_bottom = 1

" enable some default behavior in python-mode plugin:
let g:pymode = 1
let g:pymode_lint = 0
let g:pymode_rope = 0
let g:pymode_options_max_line_length = 1
let g:pymode_python = 'python3'
let g:pymode_breakpoint = 0
" let g:pymode_breakpoint_cmd = ''
"

let g:startify_list_order = ['bookmarks', ['sessions:'],'sessions', 'files', ['commands:'], 'commands']
" let g:startify_list_order = ['bookmarks', ['sessions:'],'sessions', 'files', 'dir', ['commands:'], 'commands']
let g:startify_bookmarks = ['~/.vimrc', '~/sync/pkb/systems/ref_vim_cheatsheet.txt', '~/sync/pkb/todo.txt']
let g:startify_update_oldfiles = 1
let g:startify_change_to_dir = 1
let g:startify_session_autoload = 1
let g:startify_enable_special = 1
let g:startify_custom_header = []
let g:startify_files_number = 24
let g:startify_session_autoload = 1
" let g:startify_enable_unsafe = 1
let g:startify_custom_indices = ['v', 'r', 'c', 'd']
let g:startify_session_delete_buffers = 0
let g:startify_enable_special = 1
" let g:startify_disable_at_vimenter = 1
" let g:startify_session_before_save = ['VoomQuitAll']
let g:startify_session_dir = '~/.vim/session'

let g:svnj_cache_dir="C:/Users/allencb/vc_cache"
let g:vc_log_name="~/vclog.txt"

let python_highlight_all = 1

"let g:deoplete#enable_at_startup = 1
" let g:neosnippet#snippets_directory='~/.vim/cbasnippets'
" Use deoplete.

" Use smartcase.
"call deoplete#custom#option('smart_case', v:true)

let g:easytags_suppress_ctags_warning = 1
" let g:easytags_cmd = 'C:\programs\util\ctags.exe'
" let g:easytags_cmd = 'C:\programs\util\ctags.exe'

let g:Lf_ShowHidden = 1
let g:pymode = 0

let g:minisnip_trigger = '<c-space>'
let g:minisnip_dir = '~/.vim/minisnip'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocommands {{{1
" """"""""""""""""""""""""""""""""""""""""""""""""""""""
"
autocmd BufWritePost ~/.vim/doc/* :helptags ~/.vim/doc
" Always switch to the current file directory
" autocmd BufEnter * silent! lcd %:p:h
autocmd BufEnter * set relativenumber
" autocmd BufNewFile,BufRead todo.txt set filetype=todo
" if you want to always open files in a tab, there is a simple solution with no need for a custom gvimext.dll.  Add the below entry to .vimrc file:
" autocmd BufReadPost * tab ball
" autocmd BufReadPost *.txt tab ball
au FocusGained * :redraw!
" Options for python {{{2
augroup python_autocmds
    autocmd!
    au FileType python set fo-=t
    "au FileType python setlocal omnifunc=jedi#completions
    "let g:jedi#completions_enabled = 0
    "let g:jedi#auto_vim_configuration = 0
    " " for mucomplete:
    " set noshowmode shortmess+=c
    " set completeopt-=preview
    " set completeopt+=longest,menu,menuone,noinsert,noselect
    " let g:jedi#popup_on_dot = 1  " It may be 1 as well
    " let g:mucomplete#enable_auto_at_startup = 1
    " if !exists('g:neocomplete#force_omni_input_patterns')
    "     let g:neocomplete#force_omni_input_patterns = {}
    " endif
    " let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t].|^\s@|^\sfrom\s.+import |^\sfrom |^\simport )\w'
    "let g:neocomplete#force_omni_input_patterns.python = '\h\w|[^. \t].\w*'
    setlocal indentexpr=GetGooglePythonIndent(v:lnum)
augroup END
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd BufRead *.py set nocindent
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
" autocmd BufWinEnter *.py setlocal foldexpr=SimpylFold(v:lnum) foldmethod=expr
autocmd BufWinLeave *.py setlocal foldexpr< foldmethod<
" autocmd FileType python BracelessEnable +indent +fold +highlight-cc2

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" AutoCloseTag {
" Make it so AutoCloseTag works for xml and xhtml files as well
au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
" }

" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
endif

" au BufRead,BufNewFile *.txt setfiletype pandoc
" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])


" }

" Remove trailing whitespaces and ^M chars
autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()

autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
"

au GUIEnter * set printfont=Consolas:h10


if !exists("autocommands_loaded")
    let autocommands_loaded = 1
    au GUIEnter * set printfont=Consolas:h10
    " au GUIEnter * set guifont=Source_Code_Pro:h9,CamingoCode:h9,Droid_Sans_Mono_Dotted:h9,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
    " au GUIEnter * set guifont=Sauce_Code_Powerline:h10,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
" if has('gui_running')
" Use local gvimrc if available and gui is running {
    " au GUIEnter :if filereadable(expand("~/.gvimrc"))
    "     source ~/.gvimrc
    " :endif
    au GUIEnter * set guioptions-=T           " Remove the toolbar
    au GUIEnter * set lines=46                " 40 lines of text instead of 24
    " au GUIEnter if has("gui_gtk2")
    "     set guifont=Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
    " elseif has("gui_mac")
    "     set guifont=Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
    " elseif has("gui_win32")
    "     set printfont=Consolas:h10
    "     set guifont=Sauce_Code_Powerline:h10,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
    " endif
    " if has('gui_macvim')
    "     set transparency=5      " Make the window slightly transparent
    " endif
endif
au FileType vim-plug set shellxquote=(
au InsertLeave * hi Cursor guibg=red
au InsertEnter * hi Cursor guibg=yellow
au FileType vimwiki set syntax=pandoc

" todo.vim
" This plugin provides a nice complete function for project and context, to use it add the following lines to your vimrc:
" Use todo#Complete as the omni complete function for todo files
au filetype todo setlocal omnifunc=todo#Complete
" You can also start automatically the completion when entering '+' or '@' by adding the next lines to your vimrc:
" Auto complete projects
au filetype todo imap <buffer> + +<C-X><C-O>

" Auto complete contexts
au filetype todo imap <buffer> @ @<C-X><C-O>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" obsolete stuff from plugins not currently used {{{1
" """""""""""""""""""""""""""""""""""""""""""""""""""""
"
" buftabline
let g:buftabline_numbers=2
" buftabline#update(0)
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
nmap <leader>0 <Plug>BufTabLine.Go(-1)

" " " Enable heavy omni completion.
" if !exists('g:neocomplete#sources#omni#input_patterns')
"   let g:neocomplete#sources#omni#input_patterns = {}
" endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" must happen after customizations
" call neocomplete#initialize()

" end of Shougo's config from readme
" snippets / neosnippet {{{2
" let g:neosnippet#snippets_directory='~/.vim/cbasnippets'
" disable default snippets:
" let g:neosnippet#disable_runtime_snippets = {'_' : 1,}

" " Enable neosnippet snipmate compatibility mode
" let g:neosnippet#enable_snipmate_compatibility = 1

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
  " return neocomplete#close_popup()."\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
" endfunction
" <TAB>: completion.
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" " <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" inoremap <expr><C-y>  neocomplete#close_popup()
" inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"


" PyMode {
let g:pymode_lint_checker = ["pyflakes"]
let g:pymode_utils_whitespaces = 0
let g:pymode_options = 0
" }

" TagBar {
" nnoremap <silent> <leader>tt :TagbarToggle<CR>

" PythonMode {
" Disable if python support not present
if !has('python')
    let g:pymode = 1
endif
" }
" disable syntastic python syntax checking and use python-mode only:
let g:syntastic_mode_map = { 'passive_filetypes': ['python'] }


"" neocomplete {{{2
""Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"" Use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" Use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" Set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"" let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"" Define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {'default' : '', 'vimshell' : $HOME.'/.vimshell_hist'}

"" Define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'

"" Plugin key-mappings.
"" inoremap <expr><C-g>     neocomplete#undo_completion()
"" inoremap <expr><C-l>     neocomplete#complete_common_string()

" SnipMate {
" Setting the author var
" If forking, please overwrite in your .vimrc.local file
let g:snips_author = 'Craig Allen <allencb@unifirst.com>'
" }

" vim-airline {{{2
" Set configuration options for the statusline plugin vim-airline.
" Use the powerline theme and optionally enable powerline symbols.
" To use the symbols î‚°, î‚±, î‚², î‚³, î‚ , î‚¢, and î‚¡.in the statusline
" segments add the following to your .vimrc.before.local file:
let g:airline_powerline_fonts=0
" If the previous symbols do not render for you then install a
" powerline enabled font.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_theme = 'wombat'
" let g:airline_theme = 'powerlineish'
"let g:airline_theme = 'luna'
if !exists('g:airline_powerline_fonts')
    " Use the default set of separators with a few customizations
    let g:airline_left_sep='â€º'  " Slightly fancier than '>'
    let g:airline_right_sep='â€¹' " Slightly fancier than '<'
endif
" here is an example of how you could replace the branch indicator with
" the current working directory, followed by the filename.
let g:airline_section_b = '%{getcwd()}'
let g:airline_section_c = '%t'
" configure which mode colors should ctrlp window use (takes effect
" only if the active airline theme doesn't define ctrlp colors) >
"let g:airline#extensions#ctrlp#color_template = 'insert'
"let g:airline#extensions#ctrlp#color_template = 'normal'
"let g:airline#extensions#ctrlp#color_template = 'visual'
"let g:airline#extensions#ctrlp#color_template = 'replace'
" Automatically displays all buffers when there's only one tab open.
let g:bufferline_echo = 0
"Separators can be configured independently for the tabline, so here is how you can define "straight" tabs:
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
"When enabled, numbers will be displayed in the tabline and mappings will be
"exposed to allow you to select a buffer directly. Up to 9 mappings will be exposed.
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" nmap <leader>1 <Plug>AirlineSelectTab1
" nmap <leader>2 <Plug>AirlineSelectTab2
" nmap <leader>3 <Plug>AirlineSelectTab3
" nmap <leader>4 <Plug>AirlineSelectTab4
" nmap <leader>5 <Plug>AirlineSelectTab5
" nmap <leader>6 <Plug>AirlineSelectTab6
" nmap <leader>7 <Plug>AirlineSelectTab7
" nmap <leader>8 <Plug>AirlineSelectTab8
" nmap <leader>9 <Plug>AirlineSelectTab9
"* enable/disable tagbar integration >
let g:airline#extensions#tagbar#enabled = 1
let g:airline#extensions#tabline#enabled = 1
"* change how tags are displayed (:help tagbar-statusline) >
let g:airline#extensions#tagbar#flags = ''
"let g:airline#extensions#tagbar#flags = 'f'
"let g:airline#extensions#tagbar#flags = 's'
"let g:airline#extensions#tagbar#flags = 'p'

" set tabline=%!tabber#TabLine()
"

"let g:tabber_filename_style = 'full'        " /home/jim/.vim/bundle/vim-tabber/README.md
"let g:tabber_filename_style = 'relative'    " .vim/bundle/vim-tabber/README.md
" let g:tabber_filename_style = 'filename'    " README.md
" let g:tabber_filename_style = 'pathshorten'    " .v/b/v/README.md
" let g:tabber_divider_style = 'compatible'
" let g:tabber_divider_style = 'fancy'
" let g:tabber_divider_style = 'unicode'
" let g:tabber_wrap_when_shifting = 1
"
" nnoremap <silent> <C-t>            :999TabberNew<CR>
" nnoremap <silent> <Leader>tn       :TabberNew<CR>
" nnoremap <silent> <Leader>tm       :TabberMove<CR>
" nnoremap <silent> <Leader>ts       :TabberSwap<CR>
" nnoremap <silent> <Leader>1        :tabnext 1<CR>
" nnoremap <silent> <Leader>2        :tabnext 2<CR>
" nnoremap <silent> <Leader>3        :tabnext 3<CR>
" nnoremap <silent> <Leader>4        :tabnext 4<CR>
" nnoremap <silent> <Leader>5        :tabnext 5<CR>
" nnoremap <silent> <Leader>6        :tabnext 6<CR>
" nnoremap <silent> <Leader>7        :tabnext 7<CR>
" nnoremap <silent> <Leader>8        :tabnext 8<CR>
" nnoremap <silent> <Leader>9        :tabnext 9<CR>
" nnoremap <silent> <Leader>tt       :TabberSelectLastActive<CR>
" nnoremap <silent> <Leader>tc       :tabclose<CR>
" nnoremap <silent> <Leader>tl       :TabberShiftLeft<CR>
" nnoremap <silent> <Leader>tr       :TabberShiftRight<CR>

" Unite
"you can sorta extract the prefix key you use to bring up your different Unite interfaces. It looks something like this:
"This is quite useful if you wanna switch your prefix key for all your mappings at once.
" nnoremap [unite] <Nop>
" nmap \ [unite]
" nmap <space>k [unite]
"Now we can define mappings like this
"Sometimes you just wanna switch buffer, tab or find a file you had open recently. I use this mapping to achieve that.
"map [unite]f :Unite -no-split -start-insert buffer tab file_mru directory_mru<cr>
"
"To open a vimfiler buffer automatically when Vim starts up if no files(arguments) were specified 
" autocmd VimEnter * if !argc() | VimFilerExplorer | endif 
" repeat last Unite command, apparently...

" let g:unite_data_directory = expand("~/.cache/unite")
" let g:unite_source_history_yank_enable = 1
" let g:unite_source_line_enable_highlight = 1
" use ripgrep for search
" call denite#custom#var('file_rec', 'command', ['rg', '--files', '--glob', '!.git', ''])
"" call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
"" call denite#custom#source('file,file/new,buffer,file_rec,line,file_mru', 'matchers', ['matcher_fuzzy', 'matcher_project_files'])
"" next 4 lines for unite, not denite:
"" call unite#filters#matcher_default#use(['matcher_fuzzy'])
"" call unite#filters#sorter_default#use(['sorter_rank'])
"" call unite#custom#source('file,file/new,buffer,file_rec,line', 'matchers', 'matcher_fuzzy')
"" call unite#custom#profile('outline', 'sorters', 'sorter_nothing')
"" -start-insert causes Unite to open with the prompt activated -- subsequent
""  typing will immediately cause Unite to search files. esc to get out of
""  search, then can use j or k or arrows to move, a to get action options
"" nnoremap [unite]r :<C-u>Unite -no-split -buffer-name=files -default-action=tabopen  -start-insert file_rec/async:!<cr>
" nnoremap [unite]u :Denite 
"" nnoremap [unite]r :<C-u>DeniteWithBufferDir -no-split -buffer-name=files -default-action=tabopen  -start-insert file_rec<cr>
" nnoremap [unite]r :<C-u>DeniteBufferDir -buffer-name=files -default-action=tabopen  file_rec<cr>
" nnoremap [unite]f :<C-u>DeniteBufferDir -buffer-name=files -default-action=tabopen  file<cr>
" nnoremap [unite]fv :<C-u>DeniteBufferDir -buffer-name=files -default-action=vsplit  file<cr>
" nnoremap [unite]fs :<C-u>DeniteBufferDir -buffer-name=files -default-action=split  file<cr>
" nnoremap [unite]c :<C-u>DeniteCursorWord line<cr>
" nnoremap [unite]m :<C-u>Denite -buffer-name=mru -default-action=tabopen    file_mru<cr>
" nnoremap [unite]o :<C-u>Denite -buffer-name=outline -direction=dynamictop outline<cr> 
" nnoremap [unite]y :<C-u>Denite -buffer-name=yank    history<cr>
"" nnoremap [unite]y :<C-u>Denite -buffer-name=yank    history/yank<cr>
" nnoremap [unite]l  :<C-u>Denite -buffer-name=lines line<CR>
" nnoremap [unite]d :<C-u>Denite -buffer-name=change change<cr>
"" nnoremap [unite]d :<C-u>Denite -buffer-name=change -vertical change<cr>
"" nnoremap [unite]b :<C-u>Denite -buffer-name=buffer -direction=dynamictop buffer<cr>
"" nnoremap [unite]b :<C-u>Denite -direction=dynamicbottom -auto-resize
""     \ -quick-move {'a' : 0, 'r' : 1, 's' : 2, 't' : 3, 'd' : 4, 'h' : 5, 'n' : 6, 'e' : 7, 'i' : 8, 'o' : 9,
""       \     'q' : 10, 'w' : 11, 'f' : 12, 'p' : 13, 'g' : 14, 'j' : 15, 'l' : 16, 'u' : 17, 'y' : 18, ';' : 19,
""       \     '1' : 20, '2' : 21, '3' : 22, '4' : 23, '5' : 24, '6' : 25, '7' : 26, '8' : 27, '9' : 28, '0' : 29}
""     \ buffer<cr>
" nnoremap [unite]b :<C-u>Denite -auto-resize -direction=dynamicbottom buffer<cr>
" nnoremap [unite]x :<C-u>Denite -auto-resize -direction=dynamicbottom command_history<cr>
" nnoremap <C-k> :<C-u>Denite -buffer-name=search line<cr>
" nnoremap [unite]/ :<C-u>DeniteBufferDir -buffer-name=grep -direction=dynamictop -default-action=tabopen grep<cr>
"" nnoremap [unite]/ :<C-u>Denite -buffer-name=tabs -vertical -direction=dynamictop tab<cr>
"" nnoremap [unite]t :<C-u>Denite -buffer-name=tab -direction=dynamictop tab<cr>
"" nnoremap [unite]t :<C-u>Denite -buffer-name=tab -vertical -direction=dynamictop tab<cr>
"" nnoremap <silent> [unite]k :<C-u>Denite buffer -direction=dynamictop bookmark<CR>
"" for example, you can add followinng mapping to make your life with list much easier:
" nnoremap <silent> [unite]p  :<C-u>Denite -resume<CR>
" " nnoremap <silent> [unite]j  :call execute('Denite -resume -select=+'.v:count1.' -immediately')<CR>
" " " nnoremap <silent> [unite]k  :call execute('Denite -resume -select=-'.v:count1.' -immediately')<CR>
 " " nnoremap <silent> [unite]q  :<C-u>Denite -mode=normal -auto-resize quickfix<CR>
 "" nnoremap <silent> [unite]l  :<C-u>Denite -mode=normal -auto-resize location_list<CR>
 """ Ripgrep command on grep source
"call denite#custom#var('grep', 'command', ['rg'])
""call denite#custom#var('grep', 'default_opts', ['--vimgrep', '--no-heading'])
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])
"" I want to use the cursor keys to move the candidates.
"call denite#custom#map(
"        \ 'insert',
"        \ '<Down>',
"        \ '<denite:move_to_next_line>',
"        \ 'noremap'
"        \)
"call denite#custom#map(
"        \ 'insert',
"        \ '<Up>',
"        \ '<denite:move_to_previous_line>',
"        \ 'noremap'
"        \)
"" nnoremap [unite]x :<C-u>VimFiler -toggle<CR>
"" nnoremap [unite]e :<C-u>VimFilerExplorer -toggle<CR>
"" nnoremap [unite]a :<C-u>DeniteBookmarkAdd<CR>
"" nnoremap [unite]\ :<C-u>DeniteResume<CR>
"" autocmd BufEnter * silent! lcd %:p:h
"" let g:denite-options-quick-move-table=
""       \ get(g:, 'denite-options-quick-move-table', {
""       \     'a' : 0, 'r' : 1, 's' : 2, 't' : 3, 'd' : 4, 'h' : 5, 'n' : 6, 'e' : 7, 'i' : 8, 'o' : 9,
""       \     'q' : 10, 'w' : 11, 'f' : 12, 'p' : 13, 'g' : 14, 'j' : 15, 'l' : 16, 'u' : 17, 'y' : 18, ';' : 19,
""       \     '1' : 20, '2' : 21, '3' : 22, '4' : 23, '5' : 24, '6' : 25, '7' : 26, '8' : 27, '9' : 28, '0' : 29,
""       \ })
""4 mappings; easily memorable. the first 3 options will not replace the current buffer.
""nnoremap <leader>ft :<C-u>Unite file_rec -default-action=tabopen<CR>
""nnoremap <leader>fs :<C-u>Unite file_rec -default-action=split<CR>
""nnoremap <leader>fv :<C-u>Unite file_rec -default-action=vsplit<CR>
""nnoremap <leader>fc :<C-u>Unite file_rec<CR>

"" Custom mappings for the unite buffer
"autocmd FileType unite call s:unite_settings()
"function! s:unite_settings()
"    " Play nice with supertab
"    "let b:SuperTabDisabled=1
"    " Enable navigation with control-j and control-k in insert mode
"    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"endfunction
"" let g:vimfiler_as_default_explorer = 1
"" call vimfiler#custom#profile('default', 'context', {
""             \ 'explorer' : 1,
""             \ 'winwidth' : 30,
""             \ 'winminwidth' : 30,
""             \ 'toggle' : 1,
""             \ 'columns' : 'type',
""             \ 'auto_expand': 1,
""             \ 'direction' : 'rightbelow',
""             \ 'parent': 0,
""             \ 'explorer_columns' : 'type',
""             \ 'status' : 1,
""             \ 'safe' : 0,
""             \ 'split' : 1,
""             \ 'hidden': 1,
""             \ 'no_quit' : 1,
""             \ 'force_hide' : 0,
""             \ })

""""}

" let g:lightline = {
      " \ 'colorscheme': 'powerline',
      " \ 'active': {
      " \   'left': [ [ 'mode', 'paste' ],
      " \             [ 'gitbranch', 'readonly', 'absolutepath', 'modified' ] ],
      " \   'right': [ [ 'lineinfo' ],
      " \              [ 'percent' ],
      " \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
      " \ },
      " \ 'component': {
      " \   'charvaluehex': '0x%B'
      " \ },
      " \ }
" let g:lightline.enable = {
		    " \ 'statusline': 1,
		    " \ 'tabline': 0
" \ }
" let g:lightline.tab = {
		    " \ 'active': [ 'tabnum', 'relativepath', 'filename', 'modified' ],
      "       \ 'inactive': [ 'tabnum', 'relativepath', 'filename', 'modified' ] }
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<c-space>"
" let g:UltiSnipsListSnippets="<c-X>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"
" let g:UltiSnipsSnippetsDir="~/.vim/cbasnippets"
" let g:UltiSnipsSnippetDirectories=[$HOME.'\AppData\Local\nvim\site\plugged\vim-snippets\UltiSnips','cbasnippets']

" " BufNewFile only fires upon :e fname.md, not tabnew or F4 in freecommander!
" " autocmd BufNewFile *.md       TSkeletonSetup docwithHeader.md
" let g:tskelMenuPrefix=1
"run the command immediately when starting vim
" autocmd VimEnter * call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)

" plugins as of 20180219 {{{1
"
" autolinker_vim
" braceless.vim
" Buffet.vim
" CaptureClipboard
" completor.vim
" delimitMate
" DrawIt
" FastFold
" HTML-AutoCloseTag
" ingo-library
" jedi-vim
" LargeFile
" lazyList.vim
" LeaderF
" neosnippet
" neosnippet-snippets
" neovim-gui-shim
" nerdtree
" NrrwRgn
" Printer-Dialog
" pydoc.vim
" python.vim
" python_match.vim
" robotframework-vim
" scratch.vim
" syntastic
" Tabmerge
" tabular
" targets.vim
" tlib_vim
" ttodo_vim
" undotree
" utl.vim
" vim-anzu
" vim-cheat40
" vim-checklist
" vim-colors-solarized
" vim-commentary
" vim-css3-syntax
" vim-expand-region
" vim-fireplace
" vim-fugitive
" vim-gitgutter
" vim-gnupg
" vim-gutentags
" vim-indent-guides
" vim-javascript
" vim-lion
" vim-listfile
" vim-multiple-cursors
" vim-over
" vim-pandoc
" vim-pandoc-after
" vim-pandoc-syntax
" vim-repeat
" vim-signature
" vim-smartusline
" vim-sneak
" vim-startify
" vim-surround
" vim-table-mode
" vim-unimpaired
" vim-yaml
" vimproc
" vimwiki
" VisIncr
" VOoM
" winteract.vim
" zeal_vim

" " # vim-pad
" " # path to save the notes to, and then you are set:
let g:pad#dir = "~/sync/pkb"
let g:pad#local_dir = "resources"
"  " # g:pad#local_dir sets a folder relative to the current dir where vim-pad should also look for notes. This allows for having separate sets of notes in different projects.
" # To make it use pandoc formatting by default, you must set
let g:pad#default_format = "pandoc"
"  " # but you can also use any other filetype if you want to, just specify it in the modeline (<localleader>+m will ask you for a filetype and add the appropiate modeline to the file). You can keep the notes in sub-folders (<localleader>+f), or archive them (<localleader>+a).
" " vim-pad has a single entry point that handles it all:
" " :Pad ls         " lists notes
" " :Pad new        " opens a new note
" " :Pad this       " opens a local note
" " Once in the list, <S-f> begins a search, which filters the list interactively.
" " # This is my config for vim-pandoc and vim-pandoc-syntax:

" let g:pandoc#formatting#mode = "hA"
" cba use soft wrapping only:
let g:pandoc#formatting#mode = "s"
let g:pandoc#formatting#smart_autoformat_on_cursormoved = 1
let g:pandoc#folding#level = 2
let g:pandoc#folding#mode = "relative"
let g:pandoc#after#modules#enabled = ["nrrwrgn", "tablemode"]
let g:pandoc#completion#bib#mode = 'citeproc'
let g:pandoc#syntax#colorcolumn = 1
" vim-pencil stuff
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
let g:pencil#textwidth = 132
let g:pencil#conceallevel = 0     " 0=disable, 1=one char, 2=hide char, 3=hide all (def)
let g:pencil#concealcursor = 'c'  " n=normal, v=visual, i=insert, c=command (def)

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,vimwiki,pandoc call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END

command! WTF call exception#trace()
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" prefer vertical orientation when using :diffsplit
set diffopt+=vertical

let g:vimclojure#ParenRainbow = 1

" autocmd BufWritePre *.py execute ':Black'

inoremap <C-Space> <C-N>
" turn off clojure keymaps, mostly have to do with running in repl
let vimclojure#SetupKeyMap = 0

" nmap <unique> <leader>C :<c-u>Cheat40<cr>
"

let g:ranger_terminal = 'kitty'
" map <leader>rr :RangerEdit<cr>
" map <leader>rv :RangerVSplit<cr>
" map <leader>rs :RangerSplit<cr>
" map <leader>rt :RangerTab<cr>
" map <leader>ri :RangerInsert<cr>
" map <leader>ra :RangerAppend<cr>
" map <leader>rc :set operatorfunc=RangerChangeOperator<cr>g@
" map <leader>rd :RangerCD<cr>
" map <leader>rld :RangerLCD<cr>


if has("nvim")
    " Escape inside a FZF terminal window should exit the terminal window
    " rather than going into the terminal's normal mode.
    autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif

" example user configuration, in ~/.vimrc, that displays fzf in a overlapping window when run in a current version of Vim or Neovim:
if has('nvim-0.4.0') || has("patch-8.2.0191")
    let g:fzf_layout = { 'window': {
                \ 'width': 0.9,
                \ 'height': 0.7,
                \ 'highlight': 'Comment',
                \ 'rounded': v:false } }
else
    let g:fzf_layout = { "window": "silent botright 16split enew" }
endif

" map F5 to inserting the time/date
nnoremap <F5> "=strftime("%I:%M %p %a %d/%m/%Y")<CR>p
inoremap <F5> <C-R>=strftime("%I:%M %p %a %d/%m/%Y")<CR>

" fzf mappings
"you can sorta extract the prefix key you use to bring up your different Unite interfaces. It looks something like this:
"This is quite useful if you wanna switch your prefix key for all your mappings at once.
" nnoremap [fzf] <Nop>
" nmap <Bslash> [fzf]
nnoremap <silent> \f        :FzfLua files<CR>
nnoremap <silent> \c        :FzfLua colorschemes<CR>
nnoremap <silent> \b        :FzfLua buffers<CR>
nnoremap <silent> \u        :FzfLua lines<CR>
nnoremap <silent> \ll       :FzfLua loclist
nnoremap <silent> \'        :FzfLua marks<CR>
nnoremap <silent> \g        :FzfLua grep<CR>
nnoremap <silent> \?        :FzfLua help_tags<CR>
nnoremap <silent> \/        :FzfLua search_history/<CR>
nnoremap <silent> \l        :FzfLua bLines<CR>
nnoremap <silent> \t        :FzfLua tabs<CR>
nnoremap <silent> \h        :FzfLua command_history <CR>
nnoremap <silent> \k        :FzfLua keymaps<CR>
nnoremap <silent> \ft       :FzfLua filetypes<CR>
nnoremap <silent> \m        :FzfLua oldfiles<CR>
nnoremap <silent> \"        :FzfLua registers<CR>
" nnoremap <silent> [fzf]f        :Files<CR>
" nnoremap <silent> [fzf]c        :Colors<CR>
" nnoremap <silent> [fzf]b        :Buffers<CR>
" nnoremap <silent> [fzf]l        :Lines<CR>
" nnoremap <silent> [fzf]ll       :Locate
" nnoremap <silent> [fzf]`        :Marks<CR>
" nnoremap <silent> [fzf]g        :Rg<CR>
" nnoremap <silent> [fzf]?        :Helptags<CR>
" nnoremap <silent> [fzf]/        :History/<CR>
" nnoremap <silent> [fzf]i        :BLines<CR>
" nnoremap <silent> [fzf]w        :Windows<CR>
" nnoremap <silent> [fzf]h        :Commands:<CR>
" nnoremap <silent> [fzf]k        :Maps<CR>
" nnoremap <silent> [fzf]ft       :Filetypes<CR>
" nnoremap <silent> [fzf]m        :History<CR>
" nnoremap <silent> [fzf]m        :FZFMru<CR>
" not really fzf but using it for notational-fzf-vim
nnoremap <silent> \n        :FzfLua files cwd=~/sync/pkb<CR>
" nnoremap <silent> [fzf]n        :NV<CR>

  " `:Files [PATH]`    | Files (similar to  `:FZF` )
  " `:GFiles [OPTS]`   | Git files ( `git ls-files` )
  " `:GFiles?`         | Git files ( `git status` )
  " `:Buffers`         | Open buffers
  " `:Colors`          | Color schemes
  " `:Ag [PATTERN]`    | {ag}{6} search result ( `ALT-A`  to select all,  `ALT-D`  to deselect all)
  " `:Rg [PATTERN]`    | {rg}{7} search result ( `ALT-A`  to select all,  `ALT-D`  to deselect all)
  " `:Lines [QUERY]`   | Lines in loaded buffers
  " `:BLines [QUERY]`  | Lines in the current buffer
  " `:Tags [QUERY]`    | Tags in the project ( `ctags -R` )
  " `:BTags [QUERY]`   | Tags in the current buffer
  " `:Marks`           | Marks
  " `:Windows`         | Windows
  " `:Locate PATTERN`  |  `locate`  command output
  " `:History`         |  `v:oldfiles`  and open buffers
  " `:History:`        | Command history
  " `:History/`        | Search history
  " `:Snippets`        | Snippets ({UltiSnips}{8})
  " `:Commits`         | Git commits (requires {fugitive.vim}{9})
  " `:BCommits`        | Git commits for the current buffer
  " `:Commands`        | Commands
  " `:Maps`            | Normal mode mappings
  " `:Helptags`        | Help tags [1]
  " `:Filetypes`       | File types
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
nnoremap <silent> [fzf]ag       :Ag <C-R><C-W><CR>
nnoremap <silent> [fzf]AG       :Ag <C-R><C-A><CR>
xnoremap <silent> [fzf]ag       y:Ag <C-R>"<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
inoremap <expr> <c-x><c-d> fzf#vim#complete#path('blsd')
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" let g:NERDTreeHijackNetrw = 0 " // add this line if you use NERDTree
" let g:ranger_replace_netrw = 1 " // open ranger when vim open a directory

tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" Make Ranger replace netrw and be the file explorer
let g:rnvimr_ex_enable = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_pick_enable = 1

" Fullscreen for initial layout
let g:rnvimr_layout = {
           \ 'relative': 'editor',
           \ 'width': float2nr(1.0 * &columns),
           \ 'height': float2nr(1.0 * &lines) - 2,
           \ 'col': 0,
           \ 'row': 0,
           \ 'style': 'minimal'
           \ }

" Only use initial preset layout
let g:rnvimr_presets = [{}]
let g:nv_search_paths = ['.', ]
" let g:nv_search_paths = ['~/sync/pkb', ]
let g:nv_default_extension = '.txt'
let g:nv_create_note_window = 'tabedit'
let g:nv_ignore_pattern = ['*.sqlite*', '*_']
" # example for commentary
autocmd FileType apache setlocal commentstring=#\ %s
nnoremap <space>/ :Commentary<CR>
vnoremap <space>/ :Commentary<CR>
let g:utl_cfg_hdl_scm_http_system = "silent !firefox -remote 'ping()' && firefox -remote 'openURL( %u )' || firefox '%u#%f' &"


au FocusGained,BufEnter,BufWinEnter,CursorHold * :checktime

" clever-f:
" let g:clever_f_smart_case = 1
" let g:clever_f_show_prompt = 1
" let g:clever_f_fix_key_direction = 1
" let g:clever_f_repeat_last_char_inputs = '<Tab>'
" let g:clever_f_chars_match_any_signs = ';' "; matches any symbol
" ctrl-space:
" set showtabline=0
" let g:CtrlSpaceDefaultMappingKey = "<C-space> "

command! -bang -nargs=* Rg call fzf#vim#rg_interactive(<q-args>, fzf#vim#with_preview('right:50%:hidden', 'alt-h'))

nmap <unique> <leader>pe <Plug>(PickerEdit)
nmap <unique> <leader>ps <Plug>(PickerSplit)
nmap <unique> <leader>pt <Plug>(PickerTabedit)
" nmap <unique> <leader>pd <Plug>(PickerTabdrop)
nmap <unique> <leader>pv <Plug>(PickerVsplit)
nmap <unique> <leader>pb <Plug>(PickerBuffer)
nmap <unique> <leader>p] <Plug>(PickerTag)
nmap <unique> <leader>pw <Plug>(PickerStag)
nmap <unique> <leader>po <Plug>(PickerBufferTag)
nmap <unique> <leader>ph <Plug>(PickerHelp)

let g:picker_custom_find_executable = 'rg'
let g:picker_custom_find_flags = '--color never --files'


