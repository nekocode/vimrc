" ================================
"          Vundle 的配置
" ================================
set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

Bundle 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()           " required

filetype plugin indent on   " 针对不同的文件类型加载对应的插件以及缩进



" ================================
"             通用配置
" ================================
set nu                      " 显示行号
set hlsearch                " 高亮搜索的结果
set incsearch               " 开启实时搜索功能
set ignorecase              " 搜索时忽略大小写
set smartcase               " 有一个或以上大写字母时仍大小写敏感
set nowrapscan              " 搜索到文件两端时不重新搜索

" set cursorcolumn          " 突出显示当前列
set cursorline              " 突出显示当前行

set autoindent              " 自动对齐
set expandtab               " 将Tab自动转化成空格 [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set tabstop=4               " 设置Tab键的宽度 [等同的空格个数]
set softtabstop=4           " 按退格键时可以一次删掉 4 个空格
set shiftwidth=4            " 每一次缩进对应的空格数

set scrolloff=7             " 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set laststatus=2            " 总是显示底部 2 行的状态栏
set wildignore=*.pyc        " 忽略文件
" 允许回退
:set backspace=indent,eol,start

" 设置文件编码和文件格式
set fenc=utf-8
set encoding=utf-8
set fileencodings=utf-8,gbk,cp936,latin-1
set fileformat=unix
set fileformats=unix,mac,dos

" 隐藏 macvim 滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guifont=Menlo_Regular:h12

" 取消备份，视情况自己改
set nobackup
" 关闭交换文件
set noswapfile
" 文件修改之后自动载入
set autoread

" 配色，着色
Plugin 'Zenburn'
colorscheme Zenburn
Plugin 'syntastic'
syntax on

" 目录树插件
Plugin 'nerdtree'
Plugin 'vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup=0       " 设置打开vim的时候是否打开目录树

" 空格键折叠代码
Plugin 'SimpylFold'
nnoremap <space> za
let g:SimpylFold_docstring_preview=1
set foldlevel=9999

" 设置可以高亮的关键字
if has("autocmd")
    " Highlight TODO, FIXME, NOTE, etc.
    if v:version > 701
        autocmd Syntax * call matchadd('Todo',  'WW\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
        autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
    endif
endif

set completeopt=longest,menu "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项


" ================================
"             键位映射
" ================================
" 修改leader键
let mapleader = '\'
let g:mapleader = '\'

" 开关目录树
map <F10> :NERDTreeTabsToggle<CR>

" 一键替换全部Tab为空格
function! RemoveTabs()
    if &shiftwidth == 2
        exec '%s/	/  /g'
    elseif &shiftwidth == 4
        exec '%s/	/    /g'
    elseif &shiftwidth == 6
        exec '%s/	/      /g'
    elseif &shiftwidth == 8
        exec '%s/	/        /g'
    else
        exec '%s/	/ /g'
    end
endfunc
imap <leader>rt <esc>:call RemoveTabs()<cr>
nmap <leader>rt :call RemoveTabs()<cr>
vmap <leader>rt <esc>:call RemoveTabs()<cr>

" normal 模式下切换到确切的tab
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" 快速进入命令行
nnoremap ; :

" 去掉搜索高亮
noremap <silent><leader>/ :nohls<CR>

" 使用 U 替代 <C-r>，更容易执行 redo 操作
nnoremap U <C-r>

" 切换注释
map <C-c> <leader>c<space>


" ================================
"           Python 配置
" ================================
" 代码缩进
Plugin 'indentpython.vim'

" 语法检查，着色
Plugin 'vim-flake8'
let python_highlight_all=1

Plugin 'virtualenv.vim'
    
" 注释
Plugin 'scrooloose/nerdcommenter'

" 新建 py 文件时，自动插入文件头
autocmd BufNewFile *.py exec ":call AddPyHeader()"
function! AddPyHeader()
    call setline(1, "\#!/usr/bin/env python")
    call append(1, "\# encoding: utf-8")

    normal G
    normal o
    normal o
endf

" 保存并运行当前脚本
autocmd BufRead *.py nmap <F6> :w<esc>:!python %<CR>
