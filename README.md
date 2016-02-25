# README
**Python 开发** 的 Vim 配置

### Screenshot
![](art/screenshot.png)

### Feature
- 使用 [Vundle](https://github.com/VundleVim/Vundle.vim) 进行插件管理
- 使用 Zenburn 主题色
- 使用 [NerdTree](https://github.com/scrooloose/nerdtree) 目录树插件
- 使用 [YouCompleteMe](https://github.com/Valloric/YouCompleteMe) 进行语法提示
- 语法检查以及语法着色
- 新建 `py` 文件时自动插入文件头

### Hotkey
| Hotkey | Action |
| ------ | -------|
**F6** | **保存并使用 Python3 运行当前脚本**
**F10** | **开关目录树**
**\rt** | **替换所有 Tab 符为空格符**
**\ <数字键>** | **切换到相应的选项卡**
**Ctrl + t** | **新建选项卡**
**;** | **进入命令模式（相当于 `:` 键）**
**\/** | **去掉所有（搜索）高亮词**
**U** | **重做上一个撤销的操作**
**Ctrl + c** | **注释或则反注释该行**

### Config
```
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
set expandtab               " 将 Tab 自动转化成空格 [需要输入真正的 Tab 键时，使用 Ctrl+V + Tab]
set tabstop=4               " 设置 Tab 键的宽度 [等同的空格个数]
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

" 隐藏 Macvim 滚动条
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
let g:nerdtree_tabs_open_on_console_startup=0       " 设置打开 Vim 的时候是否打开目录树

" 折叠代码
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

" 代码补全设置
set completeopt=longest,menu "让 Vim 的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif "离开插入模式后自动关闭预览窗口
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>" "回车即选中当前项

```
