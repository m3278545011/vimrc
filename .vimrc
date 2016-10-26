"vim文件模板是 Martin Brochhaus 大神的
"附上大神github https://github.com/mbrochh
"借鉴k-vim https://github.com/wklken/k-vim
"修改于10/25 2016 by lzj

" ===========================================================================
"                         基础配置
" ===========================================================================

set nocompatible
" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.
set pastetoggle=<F3>
set clipboard=unnamed

"去掉报警音
set vb t_vb=

"Configure backspace so it acts as it should act
set backspace=indent,eol,start

" Mouse and backspace
set mouse=a  " on OSX press ALT and click

" 复制选中区到系统剪切板中
"vnoremap <leader>y "+y

" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","

" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohls<CR>
vnoremap <C-n> :nohls<CR>
inoremap <C-n> :nohls<CR>

" Quicksave command
noremap  <Leader>w :w<CR>
"vnoremap <C-S> <C-C>:update<CR>
"inoremap <C-S> <C-O>:update<CR>


" Quick quit command
 noremap <Leader>q :quit<CR>  " Quit current window
"" noremap <Leader>E :qa!<CR>   " Quit all windows


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

"Treat long lines as break lines (useful when moving around in them)
""se swap之后，同物理行上线直接跳
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

"inorllemap <C-h> <Left>
"inoremap <C-j> <Down>
"inoremap <C-k> <Up>
"inoremap <C-l> <Right>

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt

" 新建tab  Ctrl+t
nnoremap <leader>t   :tabnew<CR>
inoremap <leader>t    <Esc>:tabnew<CR>

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
set t_Co=256
color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on

"设置新文件的编码为 UTF-8
set encoding=utf-8

"突出显示当前行
set cursorline 

" Showing line numbers and length
set number  " show line numbers
set tw=89   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233
set scrolloff=10 "距离顶部和底部5行"

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap


" Useful settings
set history=700
set undolevels=700


" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
" leader + / 快速进入搜索
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" 回车即选中当前项
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"

" 设置 退出vim后，内容显示在终端屏幕, 可以用于查看和复制, 不需要可以去掉
" 好处：误删什么的，如果以前屏幕打开，可以找回
"set t_ti= t_te=

" Map ; to : and save a million keystrokes 用于快速进入命令行
nnoremap ; :

"============================================================================
"开启相对行号，插入模式是绝对行号，普通模式是相对行号
"============================================================================
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
"function! NumberToggle()
  "if(&relativenumber == 1)
    "set norelativenumber number
  "else
    "set relativenumber
  "endif
"endfunc
"nnoremap <C-n> :call NumberToggle()<cr>


"============================================================================
"<F6>开启/关闭行号显示:
"============================================================================
function! HideNumber()
  if(&relativenumber == &number)
    set relativenumber! number!
  elseif(&number)
    set number!
  else
    set relativenumber!
  endif
  set number?
endfunc
nnoremap <F6> :call HideNumber()<CR>

"============================================================================
"放大缩小窗口 （类似tmux）
"============================================================================
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
" Zoom / Restore window.
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
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <Leader>a :ZoomToggle<CR>

"============================================================================
"F5运行python
"============================================================================
"按F5运行python"
"map <F5> :Autopep8<CR> :w<CR> :call RunPython()<CR>
"function RunPython()
  "let mp = &makeprg
  "let ef = &errorformat
  "let exeFile = expand("%:t")
  "setlocal makeprg=python\ -u
  "set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
  "silent make %
  "copen
  "let &makeprg = mp
  "let &errorformat = ef
"endfunction

"============================================================================
"tab键补全
"============================================================================
function! CleverTab()
    if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
        return "\<Tab>"
    else
        return "\<C-N>"
    endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

"===========================================================================
"自动插入文件头
"===========================================================================
" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif
    normal G
    normal o
    normal o
endfunc


"============================================================================
"                          插件管理器
"============================================================================
" Setup Pathogen to manage your plugins
" mkdir -p ~/.vim/autoload ~/.vim/bundle
" curl -so ~/.vim/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim
" Now you can install any plugin into a .vim/bundle/plugin-name/ folder
"call pathogen#infect()
"Vundle git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" ============================================================================
"                        Python IDE Setup
" ============================================================================
Plugin 'Lokaltog/vim-powerline'
" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2
let g:Powerline_symbols = 'fancy'

"*************************************************
Plugin 'kien/ctrlp.vim'
" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
" ctrl + j/k select up/down
" ctrl + x   水平打开文件
" leader + f 打开最近的文件
" ctrl + t 在tab中打开
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"*****************************************************
Plugin 'tacahiroy/ctrlp-funky'
"Settings for ctrlpi"                                                               
" cd ~/.vim/bundle
" git clone https://github.com/tacahiroy/ctrlp-funky.git
" <leader>fu 进入当前文件的函数列表搜索
" <leader>fU 搜索当前光标下单词对应的函数
nnoremap <Leader>fu :CtrlPFunky<Cr>
"narrow the list down with a word under cursor
nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
let g:ctrlp_funky_syntax_highlight = 1
let g:ctrlp_extensions = ['funky']



"****************************************************************************
Plugin 'klen/python-mode'
" Settings for python-mode
" Note: I'm no longer using this. Leave this commented out
" and uncomment the part about jedi-vim instead
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
" Go to definition (<C-c>g for :RopeGotoDefinition)   xt 
" leader + d : 跳转到函数定义 
" ctrl + p 补全开启
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
"let g:pymode_rope_goto_def_newwin = "vnew"
"let g:pymode_rope_extended_complete = 1
let g:pymode_rope = 0
let g:pymode_breakpoint = 0
let g:pymode_trim_whitespaces = 1
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
" Don't autofold code
"let g:pymode_folding = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>



"****************************************************************************


"****************************************************************************
Plugin 'davidhalter/jedi-vim'
" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
" leader + r run python code 
" <Ctrl-c>d     Rope show documentation
"  [[    Jump on previous class or function (normal, visual, operator modes)
"  ]]    Jump on next class or function (normal, visual, operator  modes)
"
let g:jedi#usages_command = "<leader>z"
let g:jedi#rename_command ="leader>x" 
let g:jedi#popup_on_dot = 1
let g:jedi#completions_command = "<C-Alt>"
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
 "See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
set wildmenu
"function! OmniPopup(action)
    "if pumvisible()
        "if a:action == 'j'
            "return "\<C-N>"
        "elseif a:action == 'k'
            "return "\<C-P>"
        "endif
    "endif
    "return a:action
"endfunction

"inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>




"****************************************************************************
Plugin 'scrooloose/nerdtree'
"github"https://github.com/scrooloose/nerdtree.git"
"F2开启和关闭树"
map <F2> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
""显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
""窗口大小"
let NERDTreeWinSize=25




"****************************************************************************
Plugin 'tell-k/vim-autopep8'
"github 'https://github.com/tell-k/vim-autopep8.git'
"autopep8设置"
" F8 :Autopep8
" 需要安装 autopep8
" pip install --upgrade autopep8
let g:autopep8_disable_show_diff=1



"****************************************************************************
Plugin 'Yggdroot/indentLine'
"github https://github.com/Yggdroot/indentLine.git
"缩进指示线"
let g:indentLine_char='┆'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 239




"****************************************************************************
Plugin 'scrooloose/nerdcommenter'
"一键注释
map <F4> <leader>ci <CR>
"let g:NERDSpaceDelims=1




"****************************************************************************
Plugin 'tpope/vim-surround'
"http://www.wklken.me/posts/2015/06/13/vim-plugin-surround-repeat.html
"替换: cs"'
""Hello world!" -> 'Hello world!'
"替换-标签(t=tag): cst"
"<a>abc</a>  -> "abc"
"删除: ds"
"Hello world!" -> Hello world!
"添加(ys=you surround): ysiw"
"Hello -> "Hello"
"添加-整行: yss"
"Hello world -> "Hello world"



"****************************************************************************
"Plugin 'terryma/vim-expand-region'
"Press + to expand the visual selection and _ to shrink it.


Plugin 'tpope/vim-fugitive'




"****************************************************************************
" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable
if has('mouse') 
    set mouse-=a 
endif




call vundle#end()
filetype plugin indent on

