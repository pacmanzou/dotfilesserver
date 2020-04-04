" ====================================================================
" auto install{{{
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall
endif
"}}}
" ====================================================================
" python path{{{
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'
"}}}
" ====================================================================
" mapleader{{{
let mapleader="," " Leader key
let g:netrw_nogx = 1 " disable netrw's gx mapping.
"}}}
" ====================================================================
" function{{{
" helptab{{{
function! s:helptab()
  if &buftype == 'help'
    wincmd T
    nnoremap <buffer> q :q<CR>
  endif
endfunction
autocmd BufEnter *.txt call s:helptab()
"}}}
" pdf{{{
let s:pdf_cache = {}
autocmd BufReadPost *.pdf call s:loadpdf()
autocmd BufLeave *.pdf setlocal write
function s:loadpdf()
    if (line('$') < 2 || !strpart(getline(1), 1, 3) ==# "PDF")
        echo "vim-pdf: not a valid pdf file. stop converting..."
        return
    endif
    if !executable("pdftotext")
        echo "vim-pdf: pdftotext is not found. stop converting..."
        return
    endif
    execute "silent %delete"
    if has_key(s:pdf_cache, @%)
        execute "silent '[-1read ".s:pdf_cache[@%]
    else
        let pdf = escape(expand(@%), "'")
        let pdf_cache = escape(tempname(), "'")
        call system("pdftotext -nopgbrk -layout ".
                    \"'".pdf."' ".
                    \"'".pdf_cache."'")
        execute "silent '[-1read ".pdf_cache
        let s:pdf_cache[@%] = pdf_cache
    endif
    execute "silent setlocal nowrite"
    execute "silent set filetype=text"
endfunction
"}}}
" highlight the current line{{{
function! ToggleHighlightCurrentLine()
    if !exists('b:myhllines')
        let b:myhllines = {}
    endif
    let lnum = line('.')
    if has_key(b:myhllines, lnum)
        silent! call matchdelete(b:myhllines[lnum])
        unlet b:myhllines[lnum]
    else
        let matchid = matchadd('Search', '\%'.lnum.'l')
        let b:myhllines[lnum] = matchid
    endif
endfunction
function! ClearHighlightLines()
    if exists('b:myhllines')
        for value in values(b:myhllines)
            silent! call matchdelete(value)
        endfor
    endif
    let b:myhllines = {}
endfunction
nnoremap <silent> <Space>l :call ToggleHighlightCurrentLine()<CR>
nnoremap <silent> <Space>L :call ClearHighlightLines()<CR>
"}}}
" language support{{{
nnoremap <Leader>r :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        set splitbelow
        silent! exec "!g++ % -o %<"
        :sp
        :res -9
        :term ./%<
    elseif &filetype == 'cpp'
        set splitbelow
        silent! exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -9
        :term ./%<
    elseif &filetype == 'java'
        silent! exec "!javac %"
        :sp
        :res -9
        :term java %:r
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :res -9
        :term python3 %
    elseif &filetype == 'less'
        silent! exec "!lessc % %<.css"
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :res -9
        :term go run %
    endif
endfunc
"}}}
" smooth_scroll{{{
let s:save_cpo = &cpo
set cpo&vim
" Scroll the screen up
function! init#up(dist, duration, speed)
  call s:init('u', a:dist, a:duration, a:speed)
endfunction
" Scroll the screen down
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
noremap <silent> <C-U> :call init#up(&scroll,9,1)<CR>
noremap <silent> <C-D> :call init#down(&scroll,9,1)<CR>
"}}}
"}}}
" ====================================================================
" set{{{
set shell=bash
set history=10000
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=__pycache__,.stversions,*.spl,*.out,%*
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
set wildmenu
set noshowcmd
set noshowmatch
set noshowmode
set nospell
set novisualbell
set smartcase
set smartindent
set smarttab
let &t_ut=''
set encoding=utf-8
set report=0
set ruler
set fillchars=vert:\ ,stl:\ ,stlnc:\
set magic
set laststatus=2
set completeopt=longest,noinsert,menuone,noselect,preview
set terse
set number
set relativenumber
set numberwidth=1
set noeb
set list
set wrap
set autoread
set hlsearch
exec "nohlsearch"
set incsearch
set autoindent
set hidden
set ignorecase
set cindent
set backspace=indent,eol,start
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autochdir
set clipboard+=unnamedplus
set termguicolors
set updatetime=100
set nowritebackup
set nobackup
set shortmess+=c
set signcolumn=yes
"}}}
" ====================================================================
" map {{{
vnoremap ; :
nnoremap Q @q
nnoremap ; :
nnoremap / mr/
nnoremap Y y$
nnoremap > >>
nnoremap < <<
nnoremap <silent> <Space>w :set hlsearch<CR>
nnoremap <silent> <Space>W :set nohlsearch<CR>
nnoremap <silent> <Backspace><Space> :g/^\s*$/d<CR>
nnoremap <silent> yn :let @+ = expand('%')<CR>
nnoremap <silent> yp :let @+ = expand('%:p')<CR>
nnoremap <silent> yd :let @+=getcwd()<CR>
nnoremap <silent> gh K
"}}}
" ====================================================================
" imap{{{
imap <C-F> <Right>
imap <C-B> <Left>
imap <C-A> <Home>
imap <C-E> <End>
imap <C-R> <Nop>
imap <C-V> <Nop>
imap <C-Y> <Nop>
imap <C-O> <Left><Esc>o
imap <C-C> <Esc>
imap <C-K> <Nop>
imap <C-J> <Nop>
imap <C-Z> <Nop>
"}}}
" ====================================================================
" cmd{{{
cnoreabbrev todark set background=dark
cnoreabbrev tolight set background=light
cnoremap <C-A> <Home>
cnoremap <C-S> <Nop>
cnoremap <C-E> <End>
cnoremap <C-L> <Nop>
cnoremap <C-K> <Nop>
cnoremap <C-J> <Nop>
cnoremap <C-Z> <Nop>
cnoremap <C-X> <Nop>
cnoremap <C-V> <Nop>
cnoremap <C-B> <Left>
cnoremap <C-Y> <Nop>
cnoremap <C-O> <Nop>
cnoremap <C-R> <Nop>
cnoremap <C-Q> <Nop>
cnoremap <C-F> <Right>
"}}}
" ====================================================================
" nop{{{
map X <Nop>
map b <Nop>
map B <Nop>
map <Space> <Nop>
map K <Nop>
map J <Nop>
map Z <Nop>
map ZZ <Nop>
map <C-]> <Nop>
map <C-B> <Nop>
map <C-Z> <Nop>
map <C-F> <Nop>
map <C-Y> <Nop>
"}}}
" ====================================================================
" fold{{{
set fdm=marker
set foldenable
set foldcolumn=0
noremap zi za
noremap zn zr
noremap zN zR
map zF <Nop>
map za <Nop>
map zA <Nop>
map zI <Nop>
map zr <Nop>
map zR <Nop>
map zo <Nop>
map zO <Nop>
map zc <Nop>
map zC <Nop>
map zv <Nop>
map zV <Nop>
map zx <Nop>
map zX <Nop>
"}}}
" ====================================================================
" scrolloff{{{
set scrolloff=5
"}}}
" ====================================================================
" save cursor{{{
au BufReadPost * if line("'\"")>1 && line("'\"")<=line("$") | exe "normal! g'\"" | endif
"}}}
" ====================================================================
" substitute{{{
vnoremap <Space>s :s///g<left><left><left>
nnoremap <Space>s :%s///g<left><left><left>
"}}}
" ====================================================================
" windows split{{{
set splitright
set splitbelow
"}}}
" ====================================================================
" windows focus{{{
noremap <silent> <C-L> <C-W>l
noremap <silent> <C-H> <C-W>h
noremap <silent> <C-J> <C-W>j
noremap <silent> <C-K> <C-W>k
"}}}
" ====================================================================
" windows size{{{
nnoremap <silent> zk :res +5<CR>
nnoremap <silent> zj :res -5<CR>
nnoremap <silent> zl :vertical resize-5<CR>
nnoremap <silent> zh :vertical resize+5<CR>
"}}}
" ====================================================================
" windows exchange{{{
nnoremap <silent> <C-X> <C-W>K
nnoremap <silent> <C-V> <C-W>H
nnoremap <silent> <C-T> <C-W>T
"}}}
" ====================================================================
" cursor move{{{
noremap <C-E> $
noremap <C-A> ^
noremap e E
noremap w W
noremap E gE
noremap W B
"}}}
" ====================================================================
" tab switch{{{
nnoremap <silent> <Tab> :tabnext<CR>
nnoremap <silent> <S-Tab> :tabprevious<CR>
"}}}
" ====================================================================
" visual{{{
noremap <silent> vv <C-V>
noremap <silent> gV ggvG$
"}}}
" ====================================================================
" terminal{{{
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
tnoremap <C-O> <C-\><C-N>
nnoremap <silent> <Leader>t :tabnew<CR>:terminal fish<CR>
nnoremap <silent> <Leader>v :vsplit<CR>:terminal fish<CR>
nnoremap <silent> <Leader>x H:split<CR>:res -8<CR>:terminal fish<CR>
"}}}
" ====================================================================
" vim-plug{{{
filetype plugin on
filetype on
filetype indent on
filetype plugin indent on
let g:plug_window = '-tabnew'
call plug#begin('~/.config/nvim/plugged')
" statusline && colorscheme
Plug 'rbong/vim-crystalline'
Plug 'morhetz/gruvbox'
" file manager
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " standby plugin
" undo manager
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
" better operation
Plug 'luochen1990/rainbow' " obvious pairs
Plug 'yggdroot/indentline' " comfortable and obvious code indentline
Plug 'tpope/vim-surround' " '',()[]{}
Plug 'tpope/vim-repeat' " super .
Plug 'tpope/vim-commentary' " annotation code
Plug 'jiangmiao/auto-pairs' " auto pairs
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'} " align
Plug 'chrisbra/Colorizer', {'on': 'ColorHighlight'} " show colors
Plug 'machakann/vim-highlightedyank' " highlight yank
Plug 'terryma/vim-multiple-cursors' " multiple currors
Plug 'voldikss/vim-codelf'
" format
Plug 'sbdchd/neoformat', {'on': 'Neoformat'}
" fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
Plug 'dyng/ctrlsf.vim'
" auto-completetion
Plug 'Shougo/deoplete.nvim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'wellle/tmux-complete.vim' " tmux source for coc
" snippets
Plug 'Shougo/neosnippet.vim'
" tags
Plug 'majutsushi/tagbar'
" debug
" Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" python
Plug 'tmhedberg/SimpylFold',{'for': 'python'}
Plug 'Vimjas/vim-python-pep8-indent',{'for': 'python'}
" js
Plug 'jelera/vim-javascript-syntax', {'for': [ 'javascript', 'html', 'css', 'php', 'less' ]}
" go
" Plug 'fatih/vim-go' , { 'for': 'go', 'tag': '*' }
call plug#end()
"}}}
" ====================================================================
" neosnippet{{{
imap <C-J> <Plug>(neosnippet_expand_or_jump)
smap <C-J> <Plug>(neosnippet_expand_or_jump)
xmap <C-J> <Plug>(neosnippet_expand_target)
set conceallevel=2
set concealcursor=niv
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.config/nvim/snippets'
"}}}
" ====================================================================
" nerdtree{{{
nnoremap <silent> T :NERDTreeToggle<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let NERDTreeWinSize=25
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1
let g:NERDTreeShowIgnoredStatus = 1
let g:NERDTreeShowLineNumbers=1
"}}}
" ====================================================================
" majutsushi/tagbar{{{
nnoremap <silent> <Space>t :TagbarToggle<cr>
let g:tagbar_width = 30
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
let g:tagbar_left = 1
let g:tagbar_map_showproto = '<c-b>'
"}}}
" ====================================================================
" undotree{{{
nnoremap <Space>u :UndotreeToggle<CR>
if empty(glob('~/.cache/tmp/backup'))
silent !mkdir -p ~/.cache/tmp/backup
endif
if empty(glob('~/.cache/tmp/undo'))
silent !mkdir -p ~/.cache/tmp/undo
endif
set backupdir=~/.cache/tmp/backup,.
set directory=~/.cache/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.cache/tmp/undo,.
endif
let g:undotree_DiffAutoOpen=1
let g:undotree_SetFocusWhenToggle=1
let g:undotree_ShortIndicators=1
let g:undotree_WindowLayout=2
let g:undotree_DiffpanelHeight=5
let g:undotree_SplitWidth=19
"}}}
" ====================================================================
" Colorizer{{{
nnoremap <silent> <Space>h :ColorHighlight<CR>
nnoremap <silent> <Space>H :ColorClear<CR>
"}}}
" ====================================================================
" vim-easy-align{{{
vmap e <Plug>(EasyAlign)
"}}}
" ====================================================================
" vim-multiple-cursors{{{
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_word_key = '<Space>m'
let g:multi_cursor_select_all_word_key = 'g<Space>m'
let g:multi_cursor_start_key = '<Space>M'
let g:multi_cursor_select_all_key = 'g<Space>M'
let g:multi_cursor_next_key = 'n'
let g:multi_cursor_prev_key = 'p'
let g:multi_cursor_skip_key = 's'
let g:multi_cursor_quit_key = '<Esc>'
"}}}
" ====================================================================
" neoformat{{{
nmap <silent> <Space>f :Neoformat<CR>
vmap <silent> <Space>f :Neoformat<CR>
let g:neoformat_enabled_c = ['astyle']
let g:neoformat_enabled_cpp = ['astyle']
let g:neoformat_enabled_css = ['cssbeautify']
let g:neoformat_enabled_less = ['prettier']
let g:neoformat_enabled_js = ['jsbeautify']
let g:neoformat_enabled_html = ['htmlbeautify']
let g:neoformat_enabled_json = ['jsbeautify']
let g:neoformat_enabled_python = ['yapf']
" let g:neoformat_enabled_go     = ['']
" let g:neoformat_enabled_php    = ['']
" let g:neoformat_enabled_java   = ['']
"}}}
" ====================================================================
" vim-commentary{{{
auto FileType python,shell,coffee set commentstring=#\ %s
autocmd FileType java,c,cpp set commentstring=//\ %s
map gc <Nop>
map  <Space>c  <Plug>Commentary
nmap <Space>cc <Plug>CommentaryLine
"}}}
" ====================================================================
" vim-crystalline{{{
	function! StatusDiagnostic() abort
	  let info = get(b:, 'coc_diagnostic_info', {})
	  if empty(info) | return '' | endif
	  let msgs = []
	  if get(info, 'error', 0)
	    call add(msgs, 'E' . info['error'])
	  endif
	  if get(info, 'warning', 0)
	    call add(msgs, 'W' . info['warning'])
	  endif
	  return join(msgs, ' ') . ' ' . get(g:, 'coc_status', '')
	endfunction
  function! StatusLine(current, width)
    let l:s = ''
    if a:current
      let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
    else
      let l:s .= '%#CrystallineInactive#'
    endif
    let l:s .= ' %f%h%w%m%r '
    if a:current
      let l:s .= crystalline#right_sep('', 'Fill') . '  %{fugitive#head()}  %{StatusDiagnostic()}  %{g:codelf_status}'
    endif
    let l:s .= '%='
    if a:current
      let l:s .= crystalline#left_sep('', 'Fill')
      let l:s .= crystalline#left_mode_sep('')
    endif
    if a:width > 20
      let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
    else
      let l:s .= ''
    endif
    return l:s
  endfunction
  function! TabLine()
    let l:vimlabel = ''
    return crystalline#bufferline(2, len(l:vimlabel), 1).'%=%#CrystallineTab#' .l:vimlabel
  endfunction
  let g:crystalline_enable_sep = 0
  let g:crystalline_statusline_fn = 'StatusLine'
  let g:crystalline_tabline_fn = 'TabLine'
  let g:crystalline_theme = 'gruvbox'
  set showtabline=2
  set guioptions-=e
"}}}
" ====================================================================
" gruvbox{{{
colorscheme gruvbox
let g:gruvbox_italic = 1
set background=dark
set t_Co=256
"}}}
" ====================================================================
" vim-surround{{{
nmap s ysiw
nmap S yss
vmap s S
"}}}
" ====================================================================
" codelf{{{
imap <silent> <C-L> <Esc>:call codelf#start()<CR>
"}}}
" ====================================================================
" fuzzy finder{{{
" ctrlp{{{
nnoremap <silent> <C-F>f :CtrlPCurFile<CR>
nnoremap <silent> <C-F>h :CtrlPMRUFile<CR>
nnoremap <silent> <C-F>b :CtrlPBuffer<CR>
nnoremap <silent> <C-F>w :CtrlPLine<CR>
nnoremap <silent> <C-F>t :CtrlPBufTag<CR>
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
if executable('rg')
 set grepprg=rg\ --vimgrep\ --no-heading
 set grepformat=%f:%l:%c:%m,%f:%l:%m
 let g:ctrlp_user_command = 'rg %s -i --files --no-heading --max-depth 10'
endif
let g:ctrlp_match_func = {'match' : 'pymatcher#PyMatch' }
let g:ctrlp_use_caching = 1
let dir = ['\.git', '\.hg$', '\.svn$', '\.vimundo$', '\.cache/ctrlp$',
          \    '\.rbenv', '\.gem', 'backup', 'Documents', $TMPDIR,
          \    'vendor']
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/]?(' . join(dir, '|') . ')',
      \ 'file': '\v(\.exe|\.so|\.dll|\.DS_Store|\.db|COMMIT_EDITMSG)$'
      \ }
let g:ctrlp_map = ''
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
let g:ctrlp_by_filename = 1
let g:ctrlp_regexp = 0
let g:ctrlp_reuse_window = 'netrw\|help\|quickfix'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_tabpage_position = 'ac'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_open_multiple_files = 't'
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_tilde_homedir = 1
let g:ctrlp_max_depth = 40
let g:ctrlp_max_files = 10000
let g:ctrlp_max_history = 0
let g:ctrlp_arg_map = 0
let g:ctrlp_path_nolim = 0
let g:ctrlp_mruf_max = 200
let g:ctrlp_default_input = 0
let g:ctrlp_lazy_update = 0
let g:ctrlp_match_current_file = 0
let g:ctrlp_brief_prompt = 0
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*'
let g:ctrlp_match_window = 'bottom,order:btt,min:10,max:10,results:50'
let g:ctrlp_prompt_mappings = {
    \ 'PrtBS()':              ['<Bs>', '<C-H>'],
    \ 'PrtDelete()':          [],
    \ 'PrtDeleteWord()':      ['<C-W>'],
    \ 'PrtClear()':           ['<C-U>'],
    \ 'PrtSelectMove("j")':   ['<C-N>'],
    \ 'PrtSelectMove("k")':   ['<C-P>'],
    \ 'PrtSelectMove("t")':   [],
    \ 'PrtSelectMove("b")':   [],
    \ 'PrtSelectMove("u")':   [],
    \ 'PrtSelectMove("d")':   [],
    \ 'PrtHistory(-1)':       [],
    \ 'PrtHistory(1)':        [],
    \ 'AcceptSelection("e")': ['<CR>'],
    \ 'AcceptSelection("h")': ['<C-X>'],
    \ 'AcceptSelection("t")': ['<C-T>'],
    \ 'AcceptSelection("v")': ['<C-V>'],
    \ 'ToggleRegex()':        [],
    \ 'ToggleByFname()':      ['<C-F>'],
    \ 'ToggleType(1)':        ['<C-J>'],
    \ 'ToggleType(-1)':       ['<C-K>'],
    \ 'PrtExpandDir()':       [],
    \ 'PrtInsert("c")':       [],
    \ 'PrtInsert()':          [],
    \ 'PrtCurStart()':        ['<C-A>'],
    \ 'PrtCurEnd()':          ['<C-E>'],
    \ 'PrtCurLeft()':         ['<C-B>', '<Left>'],
    \ 'PrtCurRight()':        ['<C-F>', '<Right>'],
    \ 'PrtClearCache()':      ['<C-R>'],
    \ 'PrtDeleteEnt()':       ['<C-D>'],
    \ 'CreateNewFile()':      ['<C-I>'],
    \ 'MarkToOpen()':         ['<C-L>'],
    \ 'OpenMulti()':          [],
    \ 'PrtExit()':            ['<Esc>', '<C-C>', '<C-[>'],
    \ }
"}}}
" ctrlsf{{{
nnoremap <C-F>a :CtrlSF 
nnoremap <silent> <C-S>o :CtrlSFOpen<CR>
    let g:ctrlsf_mapping = {
        \ "next": "J",
        \ "prev": "K",
        \ "open": "<CR>",
        \ "openb": "",
        \ "split": "<C-X>",
        \ "vsplit": "<C-V>",
        \ "tab": "<C-T>",
        \ "tabb": "",
        \ "popen": "p",
        \ "popenf": "",
        \ "quit": "q",
        \ "chgmode": "M",
        \ "stop": "<C-C>",
        \ }
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_default_view_mode = 'normal'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_populate_qflist = 1
let g:ctrlsf_parse_speed = 100
let g:ctrlsf_toggle_map_key = '\t'
let g:ctrlsf_extra_backend_args = {
    \ 'pt': '--global-gitignore'
    \ }
let g:ctrlsf_auto_focus = {
    \ 'at': 'start'
    \ }
let g:ctrlsf_extra_root_markers = ['.root']
let g:extra_whitespace_ignored_filetypes = ['ctrlsf']
"}}}
"}}}
" ====================================================================
" Shougo/deoplete.nvim{{{
let g:deoplete#enable_at_startup = 1
"}}}
" ====================================================================
" coc.nvim{{{
let g:coc_global_extensions=[
            \'coc-prettier',
            \'coc-translator',
            \'coc-browser',
            \'coc-java',
            \'coc-phpls',
            \'coc-python',
            \'coc-vimlsp',
            \'coc-html',
            \'coc-json',
            \'coc-css',
            \'coc-tsserver'
            \]
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> <C-N> <Plug>(coc-diagnostic-next-error)
nmap <silent> <C-P> <Plug>(coc-diagnostic-prev-error)
nmap <silent> <space>f <Plug>(coc-format)
vmap <silent> <space>f <Plug>(coc-format-selected)
nmap cn <Plug>(coc-rename)
nmap <silent> t <Plug>(coc-translator-e)
vmap <silent> t <Plug>(coc-translator-ev)
"}}}
" ====================================================================
" indentline{{{
autocmd! User indentLine doautocmd indentLine Syntax
let g:indentLine_char_list = ['|']
let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:indentLine_bufTypeExclude = ['help', 'terminal', 'nofile']
"}}}
" ====================================================================
" vim-fugitive{{{
let g:fugitive_no_maps = 1
nnoremap <silent> <Leader>s H:Gstatus<CR>
nnoremap <silent> <Leader>l :tabnew<CR>:GlLog<CR>
nnoremap <silent> <Leader>c H:Gcommit<CR>
nnoremap <silent> <Leader>bl :Gblame<CR>
vnoremap <silent> <Leader>bl :Gblame<CR><C-W>H
nnoremap <silent> <Leader>push H:split<CR>:res -8<CR>:terminal git push<CR>
nnoremap <silent> <Leader>pull H:split<CR>:res -8<CR>:terminal git pull<CR>
"}}}
" ====================================================================
" vim-gitgutter{{{
let g:gitgutter_signs = 1
let g:gitgutter_async = 1
let g:gitgutter_max_signs = 2048
let g:gitgutter_map_keys = 0
let g:gitgutter_override_sign_column_highlight = 1
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_sign_added = '++'
let g:gitgutter_sign_modified = '+-'
let g:gitgutter_sign_removed = '--'
autocmd BufWritePost * GitGutter
nnoremap <silent> <Leader>pr :GitGutterPreviewHunk<CR>
nnoremap <silent> <Leader>f :GitGutterFold<CR>
nnoremap <silent> <Leader>k :GitGutterPrevHunk<CR>
nnoremap <silent> <Leader>j :GitGutterNextHunk<CR>
nmap <silent> <Leader>a <Plug>(GitGutterStageHunk)
"}}}
" ====================================================================
" auto-pairs{{{
nmap <Space>p <M-p>
let g:AutoPairsFlyMode = 0
"}}}
" ====================================================================
" SimpylFold{{{
" Vimjas/vim-python-pep8-indent
let g:SimpylFold_docstring_preview = 1
let g:python_highlight_all = 1
" let g:python_slow_sync = 0
"}}}
" ====================================================================
" rainbow{{{
let g:rainbow_active = 1
    let g:rainbow_conf = {}
    let g:rainbow_conf.guifgs = ['white', 'yellow', 'darkorange', 'darkgray', 'darkorange']
    let g:rainbow_conf.ctermfgs = ['darkblue', 'darkyellow', 'darkgreen', 'darkgray', 'darkmagenta']
    let g:rainbow_conf.operators = '_,_'
    let g:rainbow_conf.parentheses = ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
    let g:rainbow_conf.separately = { '*': {} }
"}}}
" ====================================================================
" json{{{
autocmd BufNewFile,BufRead *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json setlocal autoindent
  autocmd FileType json setlocal formatoptions=tcq2l
  autocmd FileType json setlocal foldmethod=syntax
augroup END
"}}}
" ====================================================================
" vim-go{{{
" let g:go_def_mapping_enabled                 = 0
" let g:go_template_autocreate                 = 0
" let g:go_textobj_enabled                     = 0
" let g:go_auto_type_info                      = 1
" let g:go_def_mapping_enabled                 = 0
" let g:go_highlight_array_whitespace_error    = 1
" let g:go_highlight_build_constraints         = 1
" let g:go_highlight_chan_whitespace_error     = 1
" let g:go_highlight_extra_types               = 1
" let g:go_highlight_fields                    = 1
" let g:go_highlight_format_strings            = 1
" let g:go_highlight_function_calls            = 1
" let g:go_highlight_function_parameters       = 1
" let g:go_highlight_functions                 = 1
" let g:go_highlight_generate_tags             = 1
" let g:go_highlight_methods                   = 1
" let g:go_highlight_operators                 = 1
" let g:go_highlight_space_tab_error           = 1
" let g:go_highlight_string_spellcheck         = 1
" let g:go_highlight_structs                   = 1
" let g:go_highlight_trailing_whitespace_error = 1
" let g:go_highlight_types                     = 1
" let g:go_highlight_variable_assignments      = 0
" let g:go_highlight_variable_declarations     = 0
"}}}
" ====================================================================
