" Author: pacmanzou <zoumanjaro@gmail.com> && <pacmanzou@qq.com>
" Github: https://github.com/pacmanzou
" Description: nvim config


" Let:
let &t_ut                               = ''
let &termencoding                       = &encoding
let mapleader                           = ","
let g:python_host_prog                  = '/usr/bin/python2'
let g:python3_host_prog                 = '/usr/bin/python3'


" Set:
set autochdir
set autoindent
set autoread
set clipboard=unnamedplus
set completeopt=longest,noinsert,menuone,noselect,preview
set expandtab
set fdm=indent
set fileencodings=utf-8,gbk,ucs-bom,cp936
set fillchars=stlnc:-,vert:\|
set foldcolumn=0
set foldenable
set foldlevel=99
set guioptions-=e
set hidden
set history=10000
set ignorecase
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:\|\ ,trail:▫
set magic
set matchtime=0
set matchpairs+=<:>
set matchpairs+=《:》
set matchpairs+=（:）
set matchpairs+=【:】
set matchpairs+=“:”
set matchpairs+=‘:’
set noshowmatch
set noshowmode
set nospell
set notimeout
set novisualbell
set nowritebackup
set ruler
set scrolloff=3
set shiftwidth=4
set shortmess+=c
set showtabline=2
set signcolumn=yes
set smartcase
set smartindent
set smarttab
set softtabstop=4
set splitbelow
set splitright
set syntax=off
set tabstop=4
set terse
set ttimeoutlen=0
set tw=0
set updatetime=100
set wildmenu
set wrap
set wrapscan


" Map:
" windows focus
noremap <silent><C-l> <C-w>l
noremap <silent><C-h> <C-w>h
noremap <silent><C-j> <C-w>j
noremap <silent><C-k> <C-w>k

" windows size
nnoremap zk :res +5<Cr>
nnoremap zj :res -5<Cr>
nnoremap zl :vertical resize-5<Cr>
nnoremap zh :vertical resize+5<Cr>

" windows exchange
nnoremap <silent><C-s> <C-w>K
nnoremap <silent><C-v> <C-w>H
nnoremap <silent><C-t> <C-w>T

" cursor move
noremap <C-e> $
noremap <C-a> ^
noremap <C-n> <C-i>
noremap <C-p> <C-o>
noremap J 5<C-e>
noremap K 5<C-y>

" tab switch
nnoremap <Tab> :tabnext<Cr>
nnoremap <S-Tab> :tabprevious<Cr>

" visual
noremap <silent>vv <C-v>
noremap <silent>gV ggvG$

" copy
nnoremap yn :let @+=expand('%')<Cr>
nnoremap yp :let @+=expand('%:p')<Cr>
nnoremap yd :let @+=getcwd()<Cr>

" imap
imap <C-h> <Backspace>
imap <C-d> <Delete>
imap <C-k> <Esc>lC
imap <C-a> <Esc>I
imap <C-e> <End>
imap <C-s> <Esc>lce
imap <C-o> <Esc>o
imap <C-f> <Right>
imap <C-b> <Left>
imap <C-v> <nop>
imap <C-q> <nop>
imap <C-z> <nop>
imap <C-g> <nop>

" cmd
cmap <C-d> <Delete>
cmap <C-f> <Right>
cmap <C-b> <Left>
cmap <C-a> <Home>
cmap <C-e> <End>
cmap <C-t> <nop>
cmap <C-l> <nop>
cmap <C-k> <nop>
cmap <C-s> <nop>
cmap <C-z> <nop>
cmap <C-x> <nop>
cmap <C-v> <nop>
cmap <C-y> <nop>
cmap <C-o> <nop>
cmap <C-r> <nop>
cmap <C-q> <nop>
cmap <C-g> <nop>

" nop
map X <nop>
map S <nop>
map <C-z> <nop>
map <C-y> <nop>
map <Space> <nop>

vmap <C-f> <nop>
vmap <C-b> <nop>

tnoremap <C-g> <nop>

" misc
noremap + <C-a>
noremap - <C-x>

vnoremap g+ g<C-a>
vnoremap g- g<C-x>

nnoremap Q @q
nnoremap / mr/\v
nnoremap Y y$
nnoremap > >>
nnoremap < <<


" Plugin:
filetype plugin on
filetype on
filetype indent on
filetype plugin indent on

let g:plug_window = '-tabnew'

call plug#begin('~/.config/nvim/plugged')

" colorscheme && statusline
Plug 'pacmanzou/gruvbox8.vim'
Plug 'rbong/vim-crystalline'
Plug 'luochen1990/rainbow'
Plug 'yggdroot/indentline'

" better operation
Plug 'pacmanzou/surround.vim'
Plug 'pacmanzou/capslock.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-repeat'
Plug 'brooth/far.vim'
Plug 'sbdchd/neoformat'
Plug 'godlygeek/tabular'
Plug 'alvan/vim-closetag'
Plug 'tommcdo/vim-exchange'
Plug 'mg979/vim-visual-multi'
Plug 'jiangmiao/auto-pairs'

" database manager
Plug 'tpope/vim-dadbod',                     { 'on': 'DBUI'}
Plug 'kristijanhusak/vim-dadbod-ui',         { 'on': 'DBUI'}

" git
Plug 'airblade/vim-gitgutter'

" run code
Plug 'skywind3000/asyncrun.vim'
Plug 'skywind3000/asynctasks.vim'

" debug engine
" Plug 'puremourning/vimspector'

" languages
" go
Plug 'fatih/vim-go',                 { 'for': ['go', 'vim-plug']}

" javascript
Plug 'pangloss/vim-javascript',      { 'for': ['javascript', 'vim-plug']}

call plug#end()


" ColorschemeAndStatusline:
" Gruvbox8:
colorscheme gruvbox8

set termguicolors
set background=dark

let g:gruvbox_italics            = 1
let g:gruvbox_italicize_strings  = 1
let g:gruvbox_filetype_hi_groups = 0
let g:gruvbox_plugin_hi_groups   = 0

" my highlight
function! My_highlight_show() abort

    hi!   link           SignColumn      LineNr
    hi    WarningMsg     guifg=#FE8019   guibg=#000000
    hi    ErrorMsg       gui=bold        guifg=#ff4934   guibg=#000000
    hi    IncSearch      gui=bold        guifg=#ebdbb2   guibg=#353535
    hi    StatusLine     gui=reverse     guifg=#000000   guibg=#ebdbb2
    hi    StatusLineNC   gui=reverse     guifg=#000000   guibg=#ebdbb2
    hi    Search         gui=bold        guifg=#ebdbb2   guibg=#353535
    hi    Pmenu          guifg=#ebdbb2   guibg=#202124
    hi    CursorLine     guibg=#353535   guifg=#ebdbb2
    hi    PmenuSel       gui=reverse     guibg=#ebdbb2   guifg=#353535
    hi    PmenuThumb     guibg=#353535
    hi    PmenuSbar      guibg=#202124
    hi    GitGutterAdd   guifg=#b8bb26 guibg=#000000
    hi    GitGutterChange guifg=#8ec07c guibg=#000000
    hi    GitGutterDelete guifg=#fb4934 guibg=#000000
    hi    DiffAdd        guifg=#b8bb26   guibg=#000000
    hi    DiffChange     guifg=#8ec07c   guibg=#000000
    hi    DiffDelete     guifg=#fb4934   guibg=#000000
    hi    DiffText       guifg=#fabd2f   guibg=#000000
    hi    Folded         gui=italic      guifg=#ebdbb2   guibg=#353535
    hi    FoldColumn     guifg=#ebdbb2   guibg=#000000
    hi    SpellBad       gui=undercurl   guifg=#fb4934   guisp=#fb4934
    hi    SpellCap       gui=undercurl   guifg=#83a598   guisp=#83a598
    hi    SpellRare      gui=undercurl   guifg=#d3869b   guisp=#d3869b
    hi    SpellLocal     gui=undercurl   guifg=#8ec07c   guisp=#8ec07c
endfunction

autocmd BufReadPre,BufEnter * call My_highlight_show()

function! Show_highlight_toggle()
    if &background=='dark'
        set background=light
    else
        set background=dark
    endif

    call My_highlight_show()
endfunction

nnoremap <silent><C-b> :call Show_highlight_toggle()<Cr>
nnoremap <silent><C-f> :Neoformat<Cr>


" Crystalline:
" statusline
function! GitStatus()
    let [a,m,r] = GitGutterGetHunkSummary()
    return printf('+%d -%d ~%d', a, r, m)
endfunction

function! StatusLine(current, width)
    let l:s = ''
    if a:current
        let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
        let l:s .= '%#CrystallineInactive#'
    endif
    let l:s .= '%{CapsLockStatusline()}%{&spell?"SPELL ":""}%{&hlsearch?"HLSEARCH ":""} []%h%w%m%r'
    if a:current
        let l:s .= crystalline#right_sep('', 'Fill') . '  %l,%c,%L'
    endif
    let l:s .= '%='
    if a:current
        let l:s .= crystalline#left_sep('', 'Fill')
        let l:s .= crystalline#left_mode_sep('')
    endif
    if a:width > 40
        let l:s .= '%{GitStatus()}  [%{&ft}][%{&fenc!=#""?&fenc:&enc}][%{&ff}]'
    else
        let l:s .= ''
    endif
    return l:s
endfunction

let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_theme         = 'pacmanzou'

set tabline=%!crystalline#bufferline(0,0,1)


" Rainbow:
let g:rainbow_active             = 1
let g:rainbow_conf               = {'guifgs': ['darkorange', 'darkgray']}


" Indentline:
let g:indentLine_char_list       = ['|']
let g:indentLine_fileTypeExclude = ['json']
let g:indentLine_bufTypeExclude  = ['help', 'terminal', 'nofile']


" BetterOperation:
" Tabular:
vmap ga :Tabularize /


" Abolish:
" 's' comes with nvim
nnoremap <Space>s :%s/\v//g<Left><Left><Left>
nnoremap <Space>S :%S///g<Left><Left><Left>

vnoremap <Space>s :s/\v//g<Left><Left><Left>
vnoremap <Space>S :S///g<Left><Left><Left>

nmap cr  <Plug>(abolish-coerce-word)


" VisualMulti:
let g:VM_leader             = {'default': ',', 'visual': ',', 'buffer': ','}
let g:VM_silent_exit        = 1
let g:VM_show_warnings      = 0
let g:VM_maps               = {}
let g:VM_maps['Find Next']  = 'n'
let g:VM_maps['Find Prev']  = 'N'
let g:VM_maps['Find Under'] = ''
let g:VM_custom_motions     = {'<C-e>': '$', '<C-a>': '^'}
let g:VM_Cursor_hl          = 'Visual'
let g:VM_Mono_hl            = 'IncSearch'
let g:VM_Extend_hl          = 'IncSearch'
let g:VM_Insert_hl          = 'IncSearch'
let g:VM_show_warnings      = 0

nmap <Space>n <Plug>(VM-Find-Under)

xmap <Space>n <Plug>(VM-Find-Subword-Under)


" CloseTag:
let g:closetag_filenames = '*.html,*.xml,*.tmpl'


" Neoformat:
let g:neoformat_enabled_go = ['gofmt']
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_sh = ['shfmt']
let g:neoformat_enabled_json = ['jsbeautify']
let g:neoformat_enabled_sql = ['pg_format']
let g:neoformat_enabled_javascript = ['jsbeautify']
let g:neoformat_enabled_html = ['htmlbeautify']
let g:neoformat_enabled_css = ['cssbeautify']
let g:neoformat_enabled_c = ['astyle']
let g:neoformat_enabled_cpp = ['astyle']

" when a filetype is not found
let g:neoformat_basic_format_align = 1
let g:neoformat_basic_format_retab = 1

" del $ space
let g:neoformat_basic_format_trim = 0

" saved silent autoformat
autocmd BufWritePre *.go,*.python,*.sh,*.json,*.sql,
            \*.js,*.html,*.css,*.markdown,*.c,*.cpp silent Neoformat


" Exchange:
nmap <silent>cx <Plug>(Exchange)
nmap <silent>cxc <Plug>(ExchangeClear)

vmap <silent>x <Plug>(Exchange)


" Undo Backup Swap:
set nobackup
set swapfile
set dir=~/.cache/tmp/swap/

if empty(glob('~/.cache/tmp/swap'))
    silent !mkdir -p ~/.cache/tmp/swap
endif

if empty(glob('~/.cache/tmp/undo'))
    silent !mkdir -p ~/.cache/tmp/undo/
endif

if has('persistent_undo')
    set undofile
    set undodir=~/.cache/tmp/undo/
endif


" Dadbod:
let g:db_ui_save_location  = '~/.config/nvim/connections.json'
let g:db_ui_winwidth = 35


" AsyncrunAndAsyncTask:
" tab run
let g:asyncrun_status       = ''
let g:asyncrun_open         = 9
let g:asynctasks_term_pos   = 'TAB'
let g:asynctasks_term_reuse = 1
let g:asyncrun_rootmarks    = [
            \ '.git',
            \ '.svn',
            \ '.root',
            \ '.project',
            \ '.hg',
            \ '.idea',
            \ '.gitignore',
            \ 'Makefile',
            \ 'CMakeLists.txt',
            \ '*.pro',
            \ '.tasks'
            \ ]

nnoremap <silent><Space>r :AsyncTask start<Cr>
nnoremap <silent><Space>a :AsyncTask<space>


" Git:
let g:gtgutter_sign_allow_clobber = 1
let g:gitgutter_map_keys = 0
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_modified_removed = '≃'

nnoremap <silent><Leader>f :GitGutterFold<CR>
nnoremap <silent><Leader>p :GitGutterPreviewHunk<CR>
nnoremap <silent><Leader>k :GitGutterPrevHunk<CR>
nnoremap <silent><Leader>j :GitGutterNextHunk<CR>


" Languages:
" Go:
let g:go_version_warning                     = 0
let g:go_echo_go_info                        = 0
let g:go_doc_popup_window                    = 1
let g:go_def_mapping_enabled                 = 0
let g:go_template_autocreate                 = 0
let g:go_textobj_enabled                     = 0
let g:go_auto_type_info                      = 1
let g:go_def_mapping_enabled                 = 0
let g:go_highlight_array_whitespace_error    = 1
let g:go_highlight_build_constraints         = 1
let g:go_highlight_chan_whitespace_error     = 1
let g:go_highlight_extra_types               = 1
let g:go_highlight_fields                    = 1
let g:go_highlight_format_strings            = 1
let g:go_highlight_function_calls            = 1
let g:go_highlight_function_parameters       = 1
let g:go_highlight_functions                 = 1
let g:go_highlight_generate_tags             = 1
let g:go_highlight_methods                   = 1
let g:go_highlight_operators                 = 1
let g:go_highlight_space_tab_error           = 1
let g:go_highlight_string_spellcheck         = 1
let g:go_highlight_structs                   = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types                     = 1
let g:go_highlight_variable_assignments      = 0
let g:go_highlight_variable_declarations     = 0
let g:go_doc_keywordprg_enabled              = 0


" Javascript:
let g:javascript_plugin_jsdoc                = 1
let g:javascript_plugin_ngdoc                = 1
let g:javascript_plugin_flow                 = 1


" MarkdownSpell:
nnoremap <Space>p <cmd>set spell!<Cr>


" Misc:
" Install:
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    autocmd VimEnter * PlugInstall
endif


" Comment:
autocmd FileType python,sh set commentstring=#\ %s
autocmd FileType c,cpp set commentstring=//\ %s
autocmd FileType markdown,md setlocal commentstring=<!--\ %s-->
autocmd FileType sql setlocal commentstring=--\ %s


" Hlsearch:
autocmd BufReadPre * set nohlsearch

function Hlsearch_toggle() abort
    if &hlsearch == 1
        set nohlsearch
    else
        set hlsearch
    endif
endfunction

nnoremap <silent><Space>h :call Hlsearch_toggle()<Cr>


" SaveCursor:
au BufReadPost * if line("'\"")>1 && line("'\"") <= line("$") && &filetype != 'gitcommit' | exe "normal! g'\"" | endif


" Super_L:
function Super_L() abort
    inoremap <C-l> <nop>
    if &filetype == "go"
        inoremap <C-l> :=
    elseif &filetype == "python"
        inoremap <C-l> ->
    elseif &filetype == "sh"
        inoremap <C-l> "${}"<Left><Left>
        " elseif &filetype == "javascript"
        "     inoremap <C-l> 
        " elseif &filetype == "cpp"
        "     inoremap <C-l> 
        " elseif &filetype == "c"
        "     inoremap <C-l> 
    endif
endfunction

autocmd BufEnter * call Super_L()


" Smooth_scroll:
" scroll the screen up
function! init#up(dist, duration, speed)
    call s:init('u', a:dist, a:duration, a:speed)
endfunction

" scroll the screen down
function! init#down(dist, duration, speed)
    call s:init('d', a:dist, a:duration, a:speed)
endfunction

" animation
function! s:init(dir, dist, duration, speed)
    for i in range(a:dist/a:speed)
        let start = reltime()
        if a:dir ==# 'd'
            exec "normal! ".a:speed."\<C-e>".a:speed."j"
        else
            exec "normal! ".a:speed."\<C-y>".a:speed."k"
        endif
        redraw
        let elapsed = s:get_ms_since(start)
        let snooze = float2nr(a:duration-elapsed)
        if snooze > 0
            exec "sleep ".snooze."m"
        endif
    endfor
endfunction

function! s:get_ms_since(time)
    let cost = split(reltimestr(reltime(a:time)), '\.')
    return str2nr(cost[0])*1000 + str2nr(cost[1])/1000.0
endfunction

nnoremap <silent><C-u> :call init#up(&scroll,6,1)<Cr>
nnoremap <silent><C-d> :call init#down(&scroll,6,1)<Cr>


" OtherCommands:
" rename filename
command! -nargs=1 Rename
            \ let tpname = expand('%:t') |
            \ saveas <args> |
            \ edit <args> |
            \ call delete(expand(tpname))
