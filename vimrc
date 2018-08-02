"   Last Modified   : 2018-05-23 20:18:21
"   最后修改时间------------------------------------------

set nocompatible               "be iMproved
filetype off                   "required!

set rtp+=~/.vim/bundle/vundle/
" 设置外观 -------------------------------------
set lines=32 columns=120        "设置默认窗口大小
set number                      "显示行号
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul    "用浅色高亮当前行
set cursorline                  "突出显示当前行"
set langmenu=zh_CN.UTF-8        "显示中文菜单
set background=dark
colorscheme solarized           "设置主题

" 变成辅助 -------------------------------------
syntax on                       "开启语法高亮
set nowrap                      "设置代码不折行"
set fileformat=unix             "设置以unix的格式保存文件"
set cindent                     "设置C样式的缩进格式"
set softtabstop=4
set tabstop=4                   "一个 tab 显示出来是多少个空格，默认 8
set shiftwidth=4                "每一级缩进是多少个空格
set backspace+=indent,eol,start "set backspace&可以对其重置
set showmatch                   "显示匹配的括号"
set scrolloff=5                 "距离顶部和底部5行"
set laststatus=2                "命令行为两行"
set smartindent                 " 智能对齐
set autoindent                  " 自动对齐
set autochdir                   "自动设置当前编辑的文件为当前工作路径
let autosave=30                 "每30秒自动保存文件
" 其他杂项 -------------------------------------
set mouse=a                     "启用鼠标"
set selection=exclusive
set selectmode=mouse,key
set matchtime=5
set ignorecase                  "忽略大小写"
set incsearch
" set hlsearch                  "高亮搜索项"
set expandtab                   "扩展table，使Tab键变为指定个数的空格键"
set whichwrap+=<,>,h,l
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1 "使vim支持中文"
filetype plugin indent on      "开启文件类型推定
autocmd bufwritepost .vimrc source $MYVIMRC                             "修改.vimrc后自动应用配置

" 键盘映射 -------------------------------------
" ----------------------------------------------

" 多窗口操作------------------------------------
map <C-H> <C-W>h
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-L> <C-W>l
map <C-T> <C-W>t
map <C-B> <C-W>b
map <C-W>= :vertical resize +3<CR>
map <C-W>- :vertical resize -3<CR>
map <C-W>+ :resize +3<CR>
map <C-W>_ :resize -3<CR>


" 自动编译运行或调试代码 -----------------------------
" F5 一键编译运行 F6一键调起终端 F7 一键编译调试 F9一键编译

" F5 一键编译运行
map <F5> <F9><F6>./*.out<CR>
"在vim的命令行中编译运行程序（不好用）
"func! CompileRun()
"exec "w"
"if &filetype == 'c'
"exec "!gcc -g % -o %<"
"exec "!time ./%<"
"elseif &filetype == 'cpp'
"exec "!g++ -g % -o %<"
"exec "!time ./%<"
"elseif &filetype == 'java'
"exec "!javac %"
"exec "!time java %<"
"elseif &filetype == 'sh'
":!time bash %
"elseif &filetype == 'python'
"exec "!time python3 %"
"elseif &filetype == 'html'
"exec "!firefox % &"
"elseif &filetype == 'go'
"exec "!go build %<"
"exec "!time go run %"
"elseif &filetype == 'mkd'
"exec "!~/.vim/markdown.pl % > %.html &"
"exec "!firefox %.html &"
"endif
"endfunc

" F6 一键调起终端
map <F6> <ESC>:w<CR>:ConqueTermVSplit zsh<CR>

" F7 一键调试
map <F7> <F9><F6>lldb ./*.out<CR>

" F9一键编译
map <F9> <ESC>:w<CR>:call Compile()<CR><CR>
func! Compile()
    exec "w"
    if &filetype == 'c'
        exec "!gcc -g % -o %<.out"
    elseif &filetype == 'cpp'
        exec "!g++ -g % -o %<.out"
    elseif &filetype == 'java'
        exec "!javac %"
    elseif &filetype == 'go'
        exec "!go build %<"
    endif
endfunc

"自动根据不同的文件类型加入不同的作者信息----------------------------------------------------

" 当新建 .h .c .hpp .cpp .mk .sh等文件时自动调用SetTitle 函数
autocmd BufNewFile *.java,*.[ch],*.hpp,*.cpp,Makefile,*.mk,*.cc,*.sh,*.py exec ":call SetTitle()" | exec "G"
map <F2> <ESC>:call SetTitle()<CR>G

" 加入注释
func! SetComment()
    call append(line(".")+0,"/* ================================================================")
    call append(line(".")+1," *     Copyright (C) ".strftime("%Y")." All rights reserved.")
    call append(line(".")+2," * ")
    call append(line(".")+3," *     File Name       : ".expand("%:t"))
    call append(line(".")+4," *     Author          : shenmishajing")
    call append(line(".")+5," *     Created Time    : ".strftime("%Y年%m月%d日"))
    call append(line(".")+6," *     Last Modified   : ".strftime("%F %T"))
    call append(line(".")+7," *     Description         : ")
    call append(line(".")+8," * ")
    call append(line(".")+9," * ================================================================*/")
    call append(line(".")+10,"")
    call append(line(".")+11,"")
endfunc

" 加入shell,Makefile注释
func! SetComment_sh()
    call append(line(".")+0, "# ================================================================")
    call append(line(".")+1, "#     Copyright (C) ".strftime("%Y")." All rights reserved.")
    call append(line(".")+2, "# ")
    call append(line(".")+3, "#     File Name       : ".expand("%:t"))
    call append(line(".")+4, "#     Author          : shenmishajing")
    call append(line(".")+5, "#     Created Time    : ".strftime("%Y年%m月%d日"))
    call append(line(".")+6, "#     Last Modified   : ".strftime("%F %T"))
    call append(line(".")+7,"#  Description     : ")
    call append(line(".")+8, "# ")
    call append(line(".")+9, "# ================================================================")
    call append(line(".")+10, "")
    call append(line(".")+11, "")
endfunc

" 加入python注释
func! SetComment_py()
    call append(line(".")+0, "# ================================================================")
    call append(line(".")+1, "#     Copyright (C) ".strftime("%Y")." All rights reserved.")
    call append(line(".")+2, "# ")
    call append(line(".")+3, "#     File Name       : ".expand("%:t"))
    call append(line(".")+4, "#     Author          : shenmishajing")
    call append(line(".")+5, "#     Created Time    : ".strftime("%Y年%m月%d日"))
    call append(line(".")+6, "#     Last Modified   : ".strftime("%F %T"))
    call append(line(".")+7,"#  Description     : ")
    call append(line(".")+8, "# ")
    call append(line(".")+9, "# ================================================================")
    call append(line(".")+10, "")
    call append(line(".")+11, "")
endfunc

" 定义函数SetTitle，自动插入文件头
func! SetTitle()

    if &filetype == 'make'
        call SetComment_sh()

    elseif &filetype == 'python'
        call SetComment_py()

    elseif &filetype == 'sh'
        call append(line(".")+0,"#!/system/bin/sh")
        call append(line(".")+1,"")
        call SetComment_sh()

    else
        call SetComment()
        if expand("%:e") == 'hpp'
            call append(line(".")+10, "#ifndef _".toupper(expand("%:t:r"))."_H")
            call append(line(".")+11, "#define _".toupper(expand("%:t:r"))."_H")
            call append(line(".")+12, "#ifdef __cplusplus")
            call append(line(".")+13, "extern \"C\"")
            call append(line(".")+14, "{")
            call append(line(".")+15, "#endif")
            call append(line(".")+16, "")
            call append(line(".")+17, "#ifdef __cplusplus")
            call append(line(".")+18, "}")
            call append(line(".")+19, "#endif")
            call append(line(".")+20, "#endif //".toupper(expand("%:t:r"))."_H")

        elseif expand("%:e") == 'h'
            call append(line(".")+10, "#pragma once")

        elseif &filetype == 'c'
            call append(line(".")+10,"#include \"".expand("%:t:r").".h\"")

        elseif &filetype == 'cpp'
            call append(line(".")+10, "#include \"".expand("%:t:r").".h\"")

        endif

    endif

endfunc

"给文件自动加上最后修改时间--------------------------------------------------------------

autocmd BufWrite,BufWritePre,FileWritePre * ks|call LastModified()|'s

fun! LastModified()

    if line("$") > 20
        let l = 20
    else
        let l = line("$")
    endif

    exe '1,' . l . 's/Last Modified[ \t]*:\zs.*/ ' . strftime("%F %T") . '/e'

endfun

" 配置插件 -----------------------------------------------------------------------

" 配置vim-lldb 无法使用 -------------------------------------------------------------------
"<F4>
"let g:lldb_map_Lstart = "<F7>"
"let g:lldb_map_Lcontinue = "<F7>"
"let g:lldb_map_Lbreakpoint = "<F9>"
"let g:lldb_map_Lstepin = "<F11>"
"let g:lldb_map_Lstepinstover = "<F10>"
"let g:python_vim_lldb = "/usr/bin/python"
" 配置Conque GDB    -----------------------------------------------------------------------
"待调试文件位于屏幕上方
"let g:ConqueGdb_SrcSplit = 'above'
"保存历史
"let g:ConqueGdb_SaveHistory = 1
"修改Conque GDB的Leader键
"let g:ConqueGdb_Leader = ','
"总是显示颜色
"let g:ConqueTerm_Color = 2
"程序结束运行时，关闭Conque GDB窗口
"let g:ConqueTerm_CloseOnEnd = 1
"Conque Term配置错误时显示警告信息
"let g:ConqueTerm_StartMessages = 0

" 配置NERDTree -------------------------------------------------------------------
"使用F3键快速调出和隐藏它
nmap <F3> :NERDTreeToggle<CR>

let NERDTreeChDirMode=1

"从NERDTree打开文件后自动关闭NERDTree
let NERDTreeQuitOnOpen = 1

"显示书签"
let NERDTreeShowBookmarks=1

"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.DAT$', '\.LOG1$', '\.LOG1$', '\c^ntuser\..*']
let NERDTreeIgnore += ['\.png$','\.jpg$','\.gif$','\.mp3$','\.flac$', '\.ogg$', '\.mp4$','\.avi$','.webm$','.mkv$','\.pdf$', '\.zip$', '\.tar.gz$', '\.rar$']

"窗口大小"
let NERDTreeWinSize=25
"
" 修改默认箭头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

""How can I open a NERDTree automatically when vim starts up if no files were
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" 打开vim时不自动打开NERDTree并将光标调至NERDTree右面的窗口
"autocmd vimenter * NERDTree
"wincmd w
"autocmd VimEnter * wincmd w

""How can I open NERDTree automatically when vim starts up on opening a directory?
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endifi

" 关闭vim时，如果打开的文件除了NERDTree没有其他文件时，它自动关闭，减少多次按:q!
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 开发的过程中，我们希望git信息直接在NERDTree中显示出来， 和Eclipse一样，修改的文件和增加的文件都给出相应的标注， 这时需要安装的插件就是 nerdtree-git-plugin,配置信息如下
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ "Unknown"   : "?"
            \ }

" 显示行号
let NERDTreeShowLineNumbers=1
let NERDTreeAutoCenter=1

" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1

"配置indentline ----------------------------------------------------------------
" 支持任意ASCII码，也可以使用特殊字符：¦, ┆, or │ ，但只在utf-8编码下有效
let g:indentLine_char='¦'

" 使indentline生效
let g:indentLine_enabled = 1

"配置 SimplyFold ----------------------------------------------------------------
" 必须手动输入za来折叠（和取消折叠）
set foldmethod=indent                " 根据每行的缩进开启折叠
set foldlevel=99

" 使用空格键会是更好的选择,所以在你的配置文件中加上这一行命令吧：
nnoremap <space> za

" 显示折叠代码的文档字符串
let g:SimpylFold_docstring_preview=1

"配置YCM ----------------------------------------------------------------------
"补全菜单的开启与关闭
set completeopt=longest,menu                    " 让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
let g:ycm_min_num_of_chars_for_completion = 1           " 从第1个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc = 0                    " 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_autoclose_preview_window_after_completion = 1     " 智能关闭自动补全窗口
autocmd InsertLeave * if pumvisible() == 0|pclose|endif         " 离开插入模式后自动关闭预览窗口

"补全菜单中各项之间进行切换和选取：默认使用tab  s-tab进行上下切换，使用空格选取。可进行自定义设置：
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']      " 通过上下键在补全菜单中进行切换
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"    " 回车即选中补全菜单中的当前项

"开启各种补全引擎
let g:ycm_collect_identifiers_from_tags_files = 1       " 开启 YCM 基于标签引擎
let g:ycm_auto_trigger = 1                              " 开启 YCM 基于标识符补全，默认为1
let g:ycm_seed_identifiers_with_syntax = 1              " 开启 YCM 基于语法关键字补全
let g:ycm_complete_in_comments = 1                      " 在注释输入中也能补全
let g:ycm_complete_in_strings = 1                       " 在字符串输入中也能补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1     " 注释和字符串中的文字也会被收入补全
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{5}'],
            \ 'cs,lua,javascript': ['re!\w{5}'],
            \ }                                         "自动开启语义补全
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "objc":1,
            \ "sh":1,
            \ "zsh":1,
            \ "zimbu":1,
            \ }                                         "白名单，白名单外的文件不会启用YCM避免减缓打开速度
"重映射快捷键
"上下左右键的行为 会显示其他信息,inoremap由i 插入模式和noremap不重映射组成，只映射一层，不会映射到映射的映射
"inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
"inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
"inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
"inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>           " force recomile with syntastic
"nnoremap <leader>lo :lopen<CR>    "open locationlist
"nnoremap <leader>lc :lclose<CR>    "close locationlist
"inoremap <leader><leader> <C-x><C-o>

let g:ycm_confirm_extra_conf=1                  " 关闭加载.ycm_extra_conf.py确认提示
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

""配置taglist --------------------------------------------------------------------------------------------
nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<CR>      " 跳转到定义处
let Tlist_Use_Right_Window = 1          "让taglist窗口出现在Vim的右边
let Tlist_File_Fold_Auto_Close = 1      "当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来。
let Tlist_Show_One_File = 1             "只显示一个文件中的tag，默认为显示多个
let Tlist_Sort_Type ='name'             "Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序
let Tlist_GainFocus_On_ToggleOpen = 0   "Taglist窗口打开时，不切换为有焦点状态
let Tlist_Exit_OnlyWindow = 1           "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 32                 "设置窗体宽度为32，可以根据自己喜好设置
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'  "这里比较重要了，设置ctags的位置，不是指向MacOS自带的那个，而是我们用homebrew安装的那个
let Tlist_Exit_OnlyWindow=1             "当只有Tlist开启时，关闭Tlist
let Tlist_Auto_Open=0                   "当vim开启时，不自动打开Tlist
map t :TlistToggle<CR>                  "热键设置，我设置成Leader+t来呼出和关闭Taglist

"配置nerdcommenter --------------------------------------------------------------------------------------------
" 设置注释快捷键
map <F4> <leader>ci<CR>

"配置powerline ------------------------------------------------------------------------------------------------
" 将字体设置为Meslo LG S DZ Regular for Powerline 13号大小
" set guifont=Meslo\ LG\ S\ DZ\ Regular\ for\ Powerline:h13

let g:Powerline_symbols = 'fancy'       " Powerline_symbols为状态栏中的箭头，unicode没有箭头
"let g:Powerline_symbols= 'unicode'

set laststatus=2                " 必须设置为2,否则状态栏不显示
set t_Co=256                    " 开启256颜色之后，colorschema在vim里好看了许多
let g:Powerline_colorscheme='solarized256'  " 状态栏使用了solarized256配色方案

"set fillchars+=stl:\ ,stlnc:\          " 状态栏如果有\\\\\或^^^^^等符号出现，添加此句再删掉此句就好了

"配置autoformat ------------------------------------------------------------------------------------------------
"F12自动格式化代码
noremap <F12> :Autoformat<CR><CR>
let g:autoformat_verbosemode=1
"退出插入模式时自动格式化
let g:clang_format#auto_format_on_insert_leave=1

" 配置Python-mode------------------------------------------------------------------------------------------------
" Disactivate rope
" Keys: 按键：
" K             Show python docs 显示Python文档
" <Ctrl-Space>  Rope autocomplete  使用Rope进行自动补全
" <Ctrl-c>g     Rope gotPlugin "yianwillis/vimcdoc"o definition  跳转到定义处
" <Ctrl-c>d     Rope show documentation  显示文档
" <Ctrl-c>f     Rope find occurrences  寻找该对象出现的地方
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled) 断点
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
"               跳转到前一个/后一个类或函数
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
"               跳转到前一个/后一个类或方法
" 禁用自动补全
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" Documentation 显示文档
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Linting 代码查错，=1为启用
let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>b'

" syntax highlighting 高亮形式
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Autofold code 启用自动代码折叠
let g:pymode_folding = 1

"配置autopep8 --------------------------------------------------------------------------------------------------
" 按照PEP8标准来配置vim
au BufNewFile,BufRead *.py set tabstop=4 |set softtabstop=4|set shiftwidth=4|set textwidth=79|set expandtab|set autoindent|set fileformat=unix

" Disable show diff window
let g:autopep8_disable_show_diff=1

" vim-autopep8自1.11版本之后取消了F8快捷键，需要用户自己为:Autopep8设置快捷键：
autocmd FileType python noremap <F8> :call Autopep8()<CR>


" Vundle插件管理 -----------------------------------------------------------------------------------------------
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" 可以通过以下四种方式指定插件的来源
" a)指定Github中vim-scripts仓库中的插件，直接指定插件名称即可，插件名中的空格使用“-”代替
Plugin 'solarized'
Plugin 'xptemplate'
Plugin 'taglist.vim'
Plugin 'a.vim'

"b) 指定Github中其他用户仓库的插件，使用“用户名/插件名称”的方式指定
" Plugin 'gilligan/vim-lldb'
" Plugin 'Conque-GDB'
" 调试器，因为Python版本问题不能正常运行，可能需要重新编译vim使之和vim-lldb用相同的Python
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Yggdroot/indentLine'
Plugin 'tmhedberg/SimpylFold'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Lokaltog/vim-powerline'
Plugin 'Chiel92/vim-autoformat'
Plugin 'klen/python-mode'
Plugin 'tell-k/vim-autopep8'
Plugin 'yianwillis/vimcdoc'
Plugin 'lrvick/Conque-Shell'

" c) 指定非Github的Git仓库的插件，需要使用git地址

" d) 指定本地Git仓库中的插件
filetype plugin indent on      "required!
