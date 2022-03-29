"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                      n \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
" Author: postfen
" Date Created: 25-03-22
"
"TODO: 
"1. Set up keybindings for vim-fugitive (g+char) for git
"2. Set up vimspector
"
"===============================================================================
"==============================Vim Automation===================================
"===============================================================================

" Configure plug.vim
if has('nvim')
  let vimautoloaddir='~/.config/nvim/site/autoload'
else
  let vimautoloaddir='~/.vim/autoload'
endif

" Install vim-plug if not found
if empty(glob(vimautoloaddir . '/plug.vim'))
  " TODO: else?
  if executable('curl')
    execute 'silent !curl -fLo ' . vimautoloaddir . '/plug.vim --create-dirs ' .
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
" Alternate way to save
" alt
"===============================================================================
"================================Vim Plugins====================================
"===============================================================================
call plug#begin()
if has('nvim')
    Plug 'psliwka/vim-smoothie'             " Smooth scrolling (Needs Rebinding)
endif
    Plug 'mhinz/vim-startify'               " Splash Screen
    Plug 'lifepillar/vim-gruvbox8'                  " Gruvbox Theme
    Plug 'shinchu/lightline-gruvbox.vim'    " Gruvbox for lightline
    Plug 'itchyny/lightline.vim'            " Lean & mean status/tabline for vim
    "Plug 'Lokaltog/powerline'               " Powerline fonts plugin
    Plug 'xianzhon/vim-code-runner'         " Code Runner
    Plug 'ctrlpvim/ctrlp.vim'               " fuzzy search
    "Plug 'ycm-core/YouCompleteMe'          " Auto completion
    "Plug 'terryma/vim-multiple-cursors'    " Multiple Cursors
    "Plug 'christoomey/vim-tmux-navigator'   " tmux Navigation
    Plug 'jiangmiao/auto-pairs'             " Auto bracket pairing
    Plug 'liuchengxu/vim-which-key'         " Shows keybindings
    Plug 'preservim/nerdtree'               " File tree navigation
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " VSCode like function
    Plug 'fannheyward/coc-pyright'          " coc python language server
    Plug 'puremourning/vimspector'          " Debugger
    Plug 'airblade/vim-gitgutter'           " Vim git changes integration
    Plug 'tpope/vim-surround'               " change parenthesis
    Plug 'tpope/vim-fugitive'               " vim git integration
    "Plug 'tpope/vim-sleuth'                 " Automatically match indent
    Plug 'Xuyuanp/nerdtree-git-plugin'      " NERDTree Git Integration
    Plug 'tiagofumo/vim-nerdtree-syntax-highlight' " Nerdtree syntax
    Plug 'ryanoasis/vim-devicons'           " Vim Devicons?
call plug#end()

"===============================================================================
"==========================GNOME Terminal Cursor Settings=======================
"===============================================================================

let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"   " default cursor (usually blinking block) otherwise

"===============================================================================
"==============================Theme Settings===================================
"===============================================================================

set background=dark
colorscheme gruvbox8_hard         " Gruvbox theme
let g:gruvbox_filetype_hi_groups = 1
let g:gruvbox_italic=1
let g:gruvbox_bold=1
let g:gruvbox_improved_strings=0
let g:gruvbox_improved_warnings=1
let g:gruvbox_transp_bg=0

" Set a custom font you have installed on your computer.
    " Syntax: set guifont=<font_name>\ <font_weight>\ <size>
 "set guifont=Monospace\ Regular\ 12
 
"===============================================================================
"=============================General Settings==================================
"===============================================================================
syntax enable                               " syntax highlight
set expandtab                               " Spaces instead of tab
set tabstop=4                               " 4 spaces
set shiftwidth=4                            " 4 spaces for indents
"set t_Co=256                                " set 256 colors
set termguicolors                           " True Colors
set encoding=UTF-8                          " set text encoding
set laststatus=2
set mouse=a                                 " Enable mouse control (tab resizing)
set noshowmode                              " Lightline takes care of showing status
set number                                  " show line numbers
set ruler                                   " 
set ttyfast                                 " terminal acceleration
set tabstop=4                               " 4 whitespaces for tabs visual presentation
set shiftwidth=4                            " shift lines by 4 spaces
set clipboard=unnamed                       " use system clipboard
set nowrap                                  " no linewrapping
set autoindent                              " copy indent from prev line
set incsearch                               " show next match when entering search
set nohlsearch
set list
set listchars=trail:~,nbsp:␣,tab:▸\
set colorcolumn=80                          " column @ col 80 for cleanliness
set guioptions-=r
set relativenumber                          " relative number on line
set cursorline                              " Highlights current line
set scrolloff=5                             " Keeps lines under cursor when scrolling
set undodir=~/.vim/undodir                  " dir for undos
set splitbelow                              " More natural splits
set splitright
set wildmenu                                " TAB for vim command autofill
set wildmode=longest:full,full

" Ignore these filetypes
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.log,*.pyc,*.sqlite,*.sqlite3,*.min.js,*.min.css,*.tags
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.pdf,*.dmg,*.app,*.ipa,*.apk,*.mobi,*.epub
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.doc,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*/.git/*,*/.svn/*,*.DS_Store
set wildignore+=*/node_modules/*,*/nginx_runtime/*,*/build/*,*/logs/*,*/dist/*,*/tmp/*
"===============================================================================
"=========================General Keybind Settings==============================
"===============================================================================
let mapleader = ' '
let maplocalleader = ','

" Alternate way to save
nnoremap <C-s> :w<CR>

" Alternate ways to quit
nnoremap <C-Q> :wq!<CR>
nnoremap <leader>q :q<CR>

" Moving Tabs
nnoremap <silent> <A-Left> :tabm -1<CR>

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Go to the start and end of the line easier
noremap H ^
noremap L $

" Navigating Tabs
 nnoremap <silent><Tab> :tabnext<CR>
" nnoremap <C-L> :tabnext<CR>
"
nnoremap <silent> <leader>      :<c-u>WhichKey ','<CR>
"nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>


"===============================================================================
"=============================Lightline Settings================================
"===============================================================================

if has('gui_running')
  set guifont=Fira\ Mono\ for\ Powerline:h15
endif

let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'


let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
"===============================================================================
"=============================coc Settings==-===================================
"===============================================================================
nmap <F2> <Plug>(coc-rename)

"===============================================================================
"=============================CtrlP Settings==-=================================
"===============================================================================
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"

"===============================================================================
"=============================WhichKey Settings=================================
"===============================================================================
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>

"===============================================================================
"=============================CodeRunner Settings===============================
"===============================================================================
"
"
let g:CodeRunnerCommandMap= {
			\ 'python' : 'python3 $fileName',
			\ 'c'      :  'cd $dir && gcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt'}
let g:code_runner_save_before_execute = 1


nmap <silent><leader>r <plug>CodeRunner

"nmap <F5> <plug>CodeRunner 
"===============================================================================
"==========================YouCompleteMe Settings===============================
"===============================================================================

let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_max_num_identifier_candidates = 5

"===============================================================================
"=============================Python Settings===================================
"===============================================================================

au Filetype python set
     \ tabstop=4
     \ softtabstop=4
     \ shiftwidth=4
     \ textwidth=79
	 \ expandtab
	 \ autoindent

"===============================================================================
"=============================NERDTree Settings===================================
"===============================================================================

autocmd BufEnter * lcd %:p:h
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

function! ToggleNerdTree()
  set eventignore=BufEnter
  NERDTreeToggle
  set eventignore=
endfunction
nmap <silent><C-B> :call ToggleNerdTree()<CR>
"nmap <silent><leader>f :NERDTreeFind<CR>
nmap <silent><leader>t :call ToggleNerdTree()<CR>


let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
"=============================================================================
"=========================Startify Config=====================================
"=============================================================================

let g:ascii = [
\'+─────────────────────────────────────────────────────────────────────────────────────────+',
\'│            ____                                                                         │',     
\'│        _.-`78o ```--._                                                                  │',     
\'│    ,o888o.  .o888o,   ``-.                                                              │',     
\'│  ,88888P  `78888P..______.]                                                             │',     
\'│ /_..__..----``        __.`                                                              │',     
\'│ `-._       /``| _..-``                                                                  │',     
\'│     ``------\  `\                                                                       │',     
\'│             |   ;.-``--..                                                               │',     
\'│             | ,8o.  o88. `.     ,d8888b                            d8,                  │',     
\'│             `;888P  `788P  :    88P`                              `8P                   │',         
\'│       .o``-.|`-._         ./  d888888P`                                                 │',     
\'│      J88 _.-/    ;``-P----`    ?88`  d8888b  88bd88b  ?88   d8P  88b  88bd8b,d88b       │',   
\'│      `--`\`|     /  /          88P  d8b_,dP  88P` ?8b d88  d8P`  88P  88P``?8P`?8b      │',   
\'│          | /     |  |         d88   88b     d88   88P ?8b ,88`  d88  d88  d88  88P      │',   
\'│          \|     /   |        d88`    `?888P`d88`   88b `?888P`  d88` d88` d88`  88b     │',   
\'│           `-----`---`========---======-----=---====---==-----===---==---==---===---=    │',   
\'+─────────────────────────────────────────────────────────────────────────────────────────+']
let g:startify_custom_header = 
            \ 'startify#pad(startify#fortune#boxed() + g:ascii)'

let g:startify_session_dir = '~/vim/sessions'
let g:startify_session_persistence = 1 " automatically update sessions
let g:startify_files_number = 20
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 0
let g:startify_padding_left = 10
let g:startify_session_sort = 1 " sort sessions by modification time
let g:startify_enable_special = 0 " gets rid of [e] and [q]
let s:bookmarks1 = [
		\ '~/.vimrc',
		\ '~/.config/nvim/init.vim', 
		\ ]
let s:bookmarks2 = [
		\ '~/Repositories', 
		\ '~/Repositories/CMPT200',
        \ '~/Repositories/CMPT200/Labs',
		\ ]

"let g:startify_lists = [
"      \ {'header': ['   Files'],   'type': {-> map(s:bookmarks1, '{"line": v:val, \"path": v:val}')}},
"      \ {'header': ['   Folders'], 'type': {-> map(s:bookmarks2, '{"line": v:val, \"path": v:val}')}},
"      \ ]

map <leader>s :Startify<CR>

