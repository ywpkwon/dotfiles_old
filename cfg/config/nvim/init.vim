" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:

syntax on

" ---------------------------------------------------
" Change leader key to space: This should be prior to plugins
" since plugin setting may set key bindings using the leader key.
" ---------------------------------------------------
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = " "           " Leader is the space key
let g:mapleader = " "
let maplocalleader = "'"
let g:maplocalleader = "'"
nnoremap <SPACE> <Nop>

" ---------------------------------------------------
" which-vim-key setting
" ---------------------------------------------------
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>
" Define prefix dictionary
let g:which_key_map =  {}
autocmd VimEnter * call which_key#register('<Space>', "g:which_key_map")

" ---------------------------------------------------
" Plugins
" ---------------------------------------------------
call plug#begin('~/.vim/plugged')

" ================= looks and GUI stuff ================== "

"Plug 'vim-airline/vim-airline'                      " make statusline awesome
"Plug 'vim-airline/vim-airline-themes'               " themes for statusline
"Plug 'khatiba/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'ryanoasis/vim-devicons'
Plug 'joshdick/onedark.vim'                         " colortheme
Plug 'morhetz/gruvbox'                              " colortheme
Plug 'junegunn/seoul256.vim'                        " colortheme
Plug 'sonph/onehalf', {'rtp': 'vim/'}               " colortheme
Plug 'jonathanfilip/vim-lucius'                     " nice white colortheme
Plug 'honza/vim-snippets'                           " snippets
Plug 'RRethy/vim-illuminate'                        " highlight all words under cursor
Plug 'nathanaelkane/vim-indent-guides'              " show indentation
" vim-indent-guides: {{{
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
" }}}
" ================= Functionalities ================= "

" auto completion, Language servers stuff
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" COC: {{{
    " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    " delays and poor user experience.
    set updatetime=300

    " Always show the signcolumn, otherwise it would shift the text each time
    " diagnostics appear/become resolved.
    set signcolumn=yes

    let g:coc_global_extensions = [
      \ 'coc-snippets',
      \ 'coc-python',
      \ 'coc-json',
      \ 'coc-yaml',
      \ 'coc-texlab',
      \ 'coc-spell-checker',
      \ 'coc-prettier',
      \]

    " Use <c-space> to trigger completion.
    inoremap <silent><expr><c-space> coc#refresh()

    " Diagnostics navigation.
    nmap <silent> g<Up>   <Plug>(coc-diagnostic-prev)
    nmap <silent> g<Down> <Plug>(coc-diagnostic-next)

    " GoTo code navigation.
    nmap <silent> gd      <Plug>(coc-definition)
    nmap <silent> gy      <Plug>(coc-type-definition)
    nmap <silent> gi      <Plug>(coc-implementation)
    nmap <silent> gr      <Plug>(coc-references)

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>
    function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
            execute 'h '.expand('<cword>')
        else
            call CocAction('doHover')
        endif
    endfunction

    " Highlight the symbol and its references when holding the cursor.
    "autocmd CursorHold * silent call CocActionAsync('highlight')
    "autocmd CursorHoldI * silent call CocActionAsync('showSignatureHelp')

    " Formatting selected
    nmap <F6>  :call CocAction('format')<CR>
    vmap <F6>  <Plug>(coc-format-selected)

    """ Use tab for trigger completion with characters ahead and navigate.
    """ NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
    """ other plugin before putting this into your config.
    inoremap <silent><expr> <TAB>
          \ pumvisible() ? "\<C-n>" :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

    " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position
    inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    "inoremap <silent><expr> <TAB>
    "    \ pumvisible() ? coc#_select_confirm() :
    "    \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
    "    \ <SID>check_back_space() ? "\<TAB>" :
    "    \ coc#refresh()

    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'

    "" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
    "" position. Coc only does snippet and additional edit on confirm.
    "if has('patch8.1.1068')
    "  " Use `complete_info` if your (Neo)Vim version supports it.
    "  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    "else
    "  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    "endif
" }}}
"Plug 'dense-analysis/ale'
"Plug 'w0rp/ale'                                     " python linters
" ALE: {{{
"    nmap <silent> <C-k> <Plug>(ale_previous_wrap)
"    nmap <silent> <C-j> <Plug>(ale_next_wrap)
" }}}

" Plug 'davidhalter/jedi-vim'                       " jedi for python
Plug 'Vimjas/vim-python-pep8-indent'                " better indenting for python
Plug 'tpope/vim-commentary'                         " comment-out by gc
" Plug 'ncm2/ncm2'                                  " awesome autocomplete plugin
" Plug 'roxma/nvim-yarp'                            " dependency of ncm2
" Plug 'ncm2/ncm2-bufword'                          " buffer keyword completion
" Plug 'ncm2/ncm2-path'                             " filepath completion
" Plug 'HansPinckaers/ncm2-jedi'                    " fast python completion (use ncm2 if you want type info or snippet support)
" ncm2: {{{
"    autocmd BufEnter * call ncm2#enable_for_buffer()
"    set completeopt=menuone,noselect,noinsert
"    " make it FAST
"    let ncm2#popup_delay = 5
"    let ncm2#complete_length = [[1,1]]
"    let g:ncm2#matcher = 'substrfuzzy'
" }}}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'majutsushi/tagbar'                            " show tags in a bar (functions etc) for easy browsing
"Plug 'twieekmonster/impsort.vim'                   " color and sort imports

" fuzzy stuff
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'
" {{{
    let $BAT_THEME='Monokai Extended'
    " Command to be executed after file list creation
    " let g:fzf_preview_filelist_postprocess_command = ''
    " let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" ls —color'          " Use dircolors
    let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" exa --color=always' " Use exa
    let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
    let g:fzf_preview_grep_preview_cmd = '~/.config/nvim/preview_fzf_grep'
" }}}
Plug 'wsdjeg/FlyGrep.vim'                           " awesome grep on the fly
Plug 'ctrlpvim/ctrlp.vim'                           " fuzzy search files
" {{{
    " ctrl p options
    let g:ctrlp_custom_ignore = '\v\.(npy|jpg|pyc|so|dll)$'
    let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
" }}}

" nerd tree
Plug 'scrooloose/nerdtree'                          " file list
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'      " to highlight files in nerdtree

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'                       " show git changes to files in gutter
" Vim_gitgutter: {{{
    " vimgutter options
    let g:gitgutter_override_sign_column_highlight = 0
    let g:gitgutter_map_keys = 0
" }}}

" cpp
Plug 'bfrg/vim-cpp-modern'
"Plug 'sheerun/vim-polyglot'
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'jaxbot/semantic-highlight.vim'

" other
Plug 'liuchengxu/vim-which-key'
Plug 'mhinz/vim-startify'                           " cool start up screen
Plug 'christoomey/vim-tmux-navigator'               " seamless vim and tmux navigation
Plug 'ianding1/leetcode.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'lilydjwg/colorizer'
Plug 'junegunn/goyo.vim'                            " focus mode
" {{{
    let g:goyo_width = 120
    let g:goyo_linenr = 1
" }}}
"Plug 'axelf4/vim-strip-trailing-whitespace'        " remove trailing whitespace (lines only you touched)
Plug 'tweekmonster/wstrip.vim'                      " remove trailing whitespace (lines only you touched + realtime highlight)
" {{{
    let g:wstrip_auto = 1                           " Globally enabled for all filetypes
" }}}
Plug 'junegunn/vim-easy-align'
" {{{
    " Start interactive EasyAlign in visual mode (e.g. vipga)
    xmap ga <Plug>(EasyAlign)

    " Start interactive EasyAlign for a motion/text object (e.g. gaip)
    nmap ga <Plug>(EasyAlign)
" }}}
Plug 'easymotion/vim-easymotion'
" Easymotion: {{{
  let g:EasyMotion_do_mapping = 0 " Disable default mappings

  let g:which_key_map.m = { 'name' : '+easy-motion' }
  " to move to {char}
  map  <leader>mf <Plug>(easymotion-bd-f)
  nmap <leader>mf <Plug>(easymotion-overwin-f)

  " to move to {char}{char}
  map  <leader>ms <Plug>(easymotion-bd-f2)
  nmap <leader>ms <Plug>(easymotion-overwin-f2)

  " Move to line
  map  <leader>ml <Plug>(easymotion-bd-jk)
  nmap <leader>ml <Plug>(easymotion-overwin-line)

  " Move to word
  map  <leader>mw <Plug>(easymotion-bd-w)
  nmap <leader>mw <Plug>(easymotion-overwin-w)

  " To faciliate jumping from insert mode:
  " (If one function is allowed, I guess it would be overwin-w)
  map   <c-b>     <Plug>(easymotion-overwin-w)
  imap  <c-b>     <ESC><Plug>(easymotion-overwin-w)

  " Gif config
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)

  " These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
  " Without these mappings, `n` & `N` works fine. (These mappings just provide
  " different highlight method and have some other features )
  " map  n <Plug>(easymotion-next)
  " map  N <Plug>(easymotion-prev)

  "map <Leader><Leader>w <Plug>(easymotion-w)
  " Turn on case-insensitive feature
  let g:EasyMotion_smartcase = 1

" }}}
Plug 'rbgrouleff/bclose.vim'           " prerequisite for ranger.vim
Plug 'francoiscabrol/ranger.vim'       " vim + ranger integration
" ranger.vim: {{{
  let g:ranger_map_keys = 0
  map  <leader>or :RangerCurrentDirectory<Cr>
  map  <leader>oR :RangerWorkingDirectory<Cr>
" }}}
call plug#end()

" path to your python
let g:python3_host_prog = '/usr/bin/python3'
let g:python_host_prog = '/usr/bin/python2'

filetype plugin indent on

set fileformat=unix
set shortmess+=c

set autoindent        " take indent for new line from previous line
set smartindent       " enable smart indentation
set autoread          " reload file if the file changes on the disk
au CursorHold * checktime

set mouse=a           " change cursor per mode
set number            " always show current line number
set smartcase         " case sensitive when a query has capital
set ignorecase        " this should be set for 'smartcase' to work
set wrapscan          " begin search from top of file when nothing is found anymore

set expandtab
set tabstop=4
set shiftwidth=4
                      " set fillchars+=vert:\  " remove chars from seperators
set softtabstop=4

set history=1000      " remember more commands and search history

set nobackup          " no backup or swap file, live dangerously
set noswapfile        " swap files give annoying warning

set breakindent       " preserve horizontal whitespace when wrapping
set showbreak=..
set lbr               " wrap words
set nowrap            " i turn on wrap manually when needed

set scrolloff=3       " keep three lines between the cursor and the edge of the screen

set undodir=~/.vim/undodir
set undofile          " save undos
set undolevels=10000  " maximum number of changes that can be undone
set undoreload=100000 " maximum number lines to save for undo on a buffer reload

set noshowmode        " keep command line clean
set noshowcmd

set laststatus=2      " always slow statusline

set splitright        " i prefer splitting right and below
set splitbelow

set hlsearch          " highlight search and search while typing
set incsearch
set cpoptions+=x      " stay at seach item when <esc>

set noerrorbells      " remove bells (i think this is default in neovim)
set visualbell
set t_vb=
set relativenumber
set viminfo='20,<1000 " allow copying of more than 50 lines to other applications

set cursorline        " highlight the current line for the cursor
set listchars=tab:>-,trail:~,space:·,extends:>,precedes:<


"----------------------------------------------
" Which vim key for CoC
"----------------------------------------------
let g:which_key_map.x = { 'name' : '+coc' }
let g:which_key_map.x.l = { 'name' : 'latex' }
nnoremap <leader>xlb :CocCommand latex.ForwardSearch<CR>
nnoremap <leader>xlb :CocCommand latex.ForwardSearch<CR>
nmap     <leader>xn  <Plug>(coc-rename)

"----------------------------------------------
" Navigation
"----------------------------------------------
" Move between buffers with Shift + arrow key...
nnoremap <leader>bk :bprevious<cr>
nnoremap <leader>bj :bnext<cr>

nnoremap <S-Right> :bnext<cr>
nnoremap <S-Left>  :bprevious<cr>
nnoremap <S-Up>    :lprev<cr>
nnoremap <S-Down>  :lnext<cr>

" ... but skip the quickfix when navigating
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" tabs:
nnoremap <leader>tn :tabnew<Space>
nnoremap <leader>tj :tabnext<CR>
nnoremap <leader>tk :tabprev<CR>
"nnoremap th :tabfirst<CR>
"nnoremap tl :tablast<CR>

noremap <leader>1 1<c-w><c-w>
noremap <leader>2 2<c-w><c-w>
noremap <leader>3 3<c-w><c-w>
noremap <leader>4 4<c-w><c-w>
noremap <leader>5 5<c-w><c-w>
noremap <leader>6 6<c-w><c-w>
noremap <leader>7 7<c-w><c-w>
noremap <leader>8 8<c-w><c-w>
noremap <leader>9 9<c-w><c-w>

noremap <Tab> <C-w>w
"imap <C-o> <esc>o
"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Closing splits
nnoremap <leader>q :lcl<cr>:q<cr>
let g:which_key_map.w = {
      \ 'name' : '+windows'               ,
      \ 'd' : ['<C-W>c'                   , 'delete-window'],
      \ '-' : ['<C-W>s'                   , 'split-window-below'],
      \ '|' : ['<C-W>v'                   , 'split-window-right'],
      \ '2' : ['<C-W>v'                   , 'layout-double-columns'],
      \ 'h' : ['<C-W>h'                   , 'window-left'],
      \ 'j' : ['<C-W>j'                   , 'window-below'],
      \ 'l' : ['<C-W>l'                   , 'window-right'],
      \ 'k' : ['<C-W>k'                   , 'window-up'],
      \ 'H' : ['<C-W>5<'                  , 'expand-window-left'],
      \ 'J' : ['resize +5'                , 'expand-window-below'],
      \ 'L' : ['<C-W>5>'                  , 'expand-window-right'],
      \ 'K' : ['resize -5'                , 'expand-window-up'],
      \ '=' : ['<C-W>='                   , 'balance-window'],
      \ 'z' : [':call ZoomWindowToggle()' , 'zoom-window-toggle'],
      \ '?' : ['Windows'                  , 'fzf-window'],
      \ 'w' : [':w'                       , 'save-file'],
      \ 'q' : ['<C-W>q'                   , 'close-file'],
      \ 'Q' : [':q!'                      , 'close-file!'],
      \ }

" <leader>wz will do the same but let's have this too
nnoremap Z :call ZoomWindowToggle()<cr>

" window zoom (toggle between max and equal)
let g:window_is_zoomed = 0
function! ZoomWindowToggle()
 if g:window_is_zoomed
   execute "normal \<c-w>="
   let g:window_is_zoomed = 0
 else
   execute "normal \<c-w>\|"
   execute "normal \<c-w>_"
   let g:window_is_zoomed = 1
 endif
endfunction

"----------------------------------------------
" Airline
"----------------------------------------------
" Airline: {{{
" Add window number
"function! WindowNumber(...)
"    let builder = a:1
"    let context = a:2
"    call builder.add_section('airline_a', '  %{tabpagewinnr(tabpagenr())} ')
"    return 0
"endfunction
"
"call airline#add_statusline_func('WindowNumber')
"call airline#add_inactive_statusline_func('WindowNumber')
"
"let g:airline_theme='transparent'
""let g:airline_powerline_fonts = 1
"let g:airline_section_y = ""
"let g:airline#extensions#tabline#enabled = 1
"
"" Airline settings
"" do not show error/warning section
"let g:airline_section_error = ""
"let g:airline_section_warning = ""
"
"if !exists('g:airline_symbols')
"    let g:airline_symbols = {}
"endif
" }}}

" Lightline: {{{
  let g:lightline = {
    \   'colorscheme': 'onedark',
    \   'active': {
    \     'left':[ [ 'mode', 'paste' ],
    \              [ 'gitbranch', 'readonly', 'filename', 'modified', 'statusdiag' ]
    \     ]
    \   },
    \   'tab': {
    \     'active': ['tabnum'],
    \     'inactive': ['tabnum']
    \   },
    \   'tabline': {
    \     'left': [ ['buffers'] ],
    \     'right': [ ]
    \   },
    \   'component': {
    \     'lineinfo': '☰  %3l:%-2v',
    \   },
    \   'component_function': {
    \     'gitbranch': 'fugitive#head',
    \     'statusdiag': 'StatusDiagnostic',
    \   }
    \ }
  let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
  let g:lightline.component_type   = {'buffers': 'tabsel'}
  let g:lightline.separator = {
    \   'left': '', 'right': ''
    \}
  let g:lightline.subseparator = {
    \   'left': '', 'right': ''
    \}
  set showtabline=2  " Show tabline
  set guioptions-=e  " Don't use GUI tabline

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
    return join(msgs, ' ')
  endfunction

  function! MyBufferlineRefresh()
    call bufferline#refresh_status()
    let rlen = 4*tabpagenr('$') + len(&fenc) + 8
    call bufferline#trim_status_info(&columns - rlen)
    return ''
  endfunction
"}}}


"----------------------------------------------
" Misc
"----------------------------------------------
set clipboard=unnamedplus
set pumheight=10

" mapping Esc
imap     <F13> <Esc>
cnoremap <Esc> <C-c>
inoremap <c-c> <ESC>

" map S to replace current word with pasteboard
nnoremap S "_diwP
nnoremap cc "_cc

" map paste, yank and delete to named register so the content
" will not be overwritten (I know I should just remember...)
nnoremap x "_x
vnoremap x "_x

" paste multiple times
xnoremap p pgvy

" home / end (matching with b, e)
nnoremap B ^
nnoremap E $

" avoid esc
inoremap jk <ESC>

" break muscle memory (only for normal mode)
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>

"So I can move around in insert
inoremap <C-k> <C-o>gk
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-j> <C-o>gj

"So I can move in command
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

"Make it easier to indent a visual selection several times.
xnoremap > >gv
xnoremap < <gv

" nohighlight
nnoremap <leader>c :nohlsearch<Bar>:echo<CR>

" FlyGrep settings
nnoremap <leader>s :FlyGrep<cr>

"Automagically resize splits when the host is resized
autocmd VimResized * wincmd =

" Fzf
let g:which_key_map.f = { 'name' : '+FzF' }
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Colors<CR>
nnoremap <leader>fg :GFiles<CR>
nnoremap <leader>fs :GFiles?<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <leader>fw :Windows<CR>

" FzfPreview
let g:which_key_map.F = { 'name' : '+FzFPreview' }
nnoremap <leader>Fp :FzfPreviewProjectFiles<CR>
"nnoremap <leader>fg :FzfPreviewGitFiles<CR>
nnoremap <leader>Fs :FzfPreviewGitStatus<CR>
nnoremap <leader>Fb :FzfPreviewBuffers<CR>
nnoremap <leader>Fj :FzfPreviewJumps<CR>
nnoremap <leader>Fl :FzfPreviewLines<CR>
nnoremap <leader>Fd :FzfPreviewLocationList<CR>
nnoremap <leader>Ff :FzfPreviewProjectGrep -add-fzf-arg=--nth=3 .<CR>
nnoremap <leader>Ffr :FzfPreviewProjectGrep -resume .<CR>



" " ale options
" let g:ale_python_flake8_options = '--ignore=E129,E501,E302,E265,E241,E305,E402,W503'
" let g:ale_python_pylint_options = '-j 0 --max-line-length=120'
" let g:ale_list_window_size = 4
" let g:ale_sign_column_always = 0
" let g:ale_open_list = 1
" let g:ale_keep_list_window_open = '1'

" let g:ale_sign_error = '‼'
" let g:ale_sign_warning = '∙'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = '0'
" let g:ale_lint_on_save = '1'
" nmap <silent> <C-M> <Plug>(ale_previous_wrap)
" nmap <silent> <C-m> <Plug>(ale_next_wrap)

" mapping to make movements operate on 1 screen line in wrap mode
function! ScreenMovement(movement)
   if &wrap
      return "g" . a:movement
   else
      return a:movement
   endif
endfunction

onoremap <silent> <expr> j ScreenMovement("j")
onoremap <silent> <expr> k ScreenMovement("k")
onoremap <silent> <expr> 0 ScreenMovement("0")
onoremap <silent> <expr> ^ ScreenMovement("^")
onoremap <silent> <expr> $ ScreenMovement("$")
nnoremap <silent> <expr> j ScreenMovement("j")
nnoremap <silent> <expr> k ScreenMovement("k")
nnoremap <silent> <expr> 0 ScreenMovement("0")
nnoremap <silent> <expr> ^ ScreenMovement("^")
nnoremap <silent> <expr> $ ScreenMovement("$")

" jedi options
" let g:jedi#auto_initialization = 1
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#show_call_signatures = "1"
" let g:jedi#show_call_signatures_delay = 0
" let g:jedi#show_call_signatures_modes = 'i'  " ni = also in normal mode
" let g:jedi#enable_speed_debugging=0
" let g:jedi#use_tabs_not_buffers = 0  " use buffers instead of tabs
" let g:jedi#goto_command = "<leader>jg"
" let g:jedi#goto_assignments_command = "<leader>ja"
" let g:jedi#goto_definitions_command = "<leader>jd"
" let g:jedi#goto_stubs_command = "<leader>js"
" let g:jedi#documentation_command = "<leader>jh"
" let g:jedi#usages_command = "<leader>ju"
" let g:jedi#completions_command = "<C-Space>"
" let g:jedi#rename_command = "<leader>jr"

" Impsort option
"hi pythonImportedObject ctermfg=142 guifg=#afaf00
"hi pythonImportedFuncDef ctermfg=81
"hi pythonImportedClassDef ctermfg=87
"let g:impsort_highlight_imported=0

" " Remove all trailing whitespace by pressing C-S
" nnoremap <C-S> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>
" autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

" move between defs python:
" NOTE: this break shortcuts with LL
nnoremap [[ [m
nnoremap ]] ]m

nnoremap <silent><nowait> [ [[
nnoremap <silent><nowait> ] ]]

function! MakeBracketMaps()
    nnoremap <silent><nowait><buffer> [ :<c-u>exe 'normal '.v:count.'[m'<cr>
    nnoremap <silent><nowait><buffer> ] :<c-u>exe 'normal '.v:count.']m'<cr>
endfunction

augroup bracketmaps
    autocmd!
    autocmd FileType python call MakeBracketMaps()
augroup END

" neovim options
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <C-a> <Esc>
nnoremap <C-x> <Esc>

" quckfix / location autoclose
autocmd BufWinEnter quickfix nnoremap <silent> <buffer>
            \   q :cclose<cr>:lclose<cr>
autocmd BufEnter * if (winnr('$') == 1 && &buftype ==# 'quickfix' ) |
            \   bd|
            \   q | endif

"----------------------------------------------
" Toggling
"----------------------------------------------
let s:activatedh = 0
function! ToggleOverlengh()
    if s:activatedh == 0
        highlight OverLength ctermbg=red ctermfg=white guibg=#792929
        match OverLength /\%81v.\+/
        let s:activatedh = 1
    else
        match none
        let s:activatedh = 0
    endif
endfunction
autocmd VimEnter * call ToggleOverlengh()    " let's turn on in the beginning

let s:activated_ws = 0
function! ToggleWhiteSpace()
    if s:activated_ws == 0
        let s:activated_ws = 1
        set list
    else
        let s:activated_ws = 0
        set nolist
    endif
endfunction

let g:which_key_map.o = {
      \ 'name' : '+toggle',
      \ 'w' : [':call ToggleWhiteSpace()', 'toggle whitespace'],
      \ 'o' : [':call ToggleOverlengh()', 'toggle overlength'] ,
      \ 'n' : ['NERDTreeToggle', 'toggle NERDTree'],
      \ 't' : ['TagbarToggle', 'toggle Tagbar'],
      \ 'i' : ['IndentGuidesToggle', 'toggle indent guildes']
      \ }

"----------------------------------------------
" Colors
"----------------------------------------------
" True color
" Correct RGB escape codes for vim inside tmux
"if !has('nvim') && $TERM ==# 'screen-256color'
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum"
let &t_8b = "\e[48;2;%lu;%lu;%lum"
"endif

" colorscheme options
"let g:lucius_style="dark"
"let g:lucius_contrast="low"
"colorscheme lucius
"set background=light

let g:gruvbox_contrast_dark = 'soft'
colorscheme gruvbox
set background=dark

"colorscheme xcodedark
"let g:seoul256_srgb = 1
"let g:seoul256_background = 236
"colorscheme seoul256

" Useful to know about color setting:
" color setting should be lower than colorscheme
" hi SomeGroupName  guifg=#XXXXXX guibg=#XXXXXX gui=underline,bold,italic ctermfg=XXX ctermbg=XiXX cterm=underline,bold,italic
"                          └┴┴┴┴┤        └┴┴┴┴┤     └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤         └┴┤         └┴┤       └┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┴┤
"    gui-vim font color hex code│             │   gui-vim special styles│           │           │ console-vim special styles│
"    ───────────────────────────┘             │   ──────────────────────┘           │           │ ──────────────────────────┘
"            gui-vim background color hex code│     console-vim font term color code│           │
"            ─────────────────────────────────┘     ────────────────────────────────┘           │
"                                                         console-vim background term color code│

" color setting should be lower than colorscheme
" semshi options: {{{
  function MyCustomHighlights()
      hi semshiLocal           ctermfg=209 guifg=#ff875f
      hi semshiGlobal          ctermfg=214 guifg=#ffaf00
      hi semshiImported        ctermfg=172 guifg=#d78700 cterm=bold gui=bold
      hi semshiParameter       ctermfg=75  guifg=#5fafff
      hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
      hi semshiFree            ctermfg=97  guifg=#875faf
      hi semshiBuiltin         ctermfg=217 guifg=#ffafaf
      hi semshiAttribute       ctermfg=49  guifg=#00ff87
      hi semshiSelf            ctermfg=249 guifg=#b2b2b2
      hi semshiUnresolved      ctermfg=148 guifg=#afd700 cterm=underline gui=underline
      hi semshiSelected        ctermfg=231 guifg=#ffffff ctermbg=60 guibg=#5f5f87

      hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
      hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
  endfunction

  autocmd FileType python call MyCustomHighlights()
  "autocmd ColorScheme * call MyCustomHighlights()

  let g:semshi#excluded_hl_groups = ['local', 'attribute', 'builtin']
  let g:semshi#no_default_builtin_highlight = v:false
" }}}

" Highlight current word (twin words) by CoC
" I'm not using it since vim_illuminate seems better option
hi CocHighlightText ctermfg=231 guifg=#ffffff ctermbg=60 guibg=#df5f87

" vim_illuminate: {{{
  let g:Illuminate_delay = 250
  let g:Illuminate_highlightUnderCursor = 0   " Don't highlight word under cursor (default: 1)
  let g:Illuminate_ftHighlightGroups = {
      \ 'vim:blacklist': ['vimVar', 'vimString', 'vimLineComment',
      \                   'vimFuncName', 'vimFunction', 'vimUserFunc', 'vimFunc'],
      \ 'python:blacklist': ['pythonComment', 'pythonStatement', 'pythonConditional',
      \                      'pythonBuiltinFunc', 'pythonString'],
      \ 'c:blacklist': ['cInclude', 'cConditional', 'cType', 'cRepeat', 'cStructure',
      \                 'cComment', 'cCommentL']
      \ }
  let g:Illuminate_ftblacklist = ['nerdtree']
  hi illuminatedWord ctermfg=231 guifg=#ffffff ctermbg=60 guibg=#5f5f87
" }}}

" Create menus based on existing mappings
" nnoremap <silent> <leader>oq  :copen<CR>
" nnoremap <silent> <leader>ol  :lopen<CR>
" let g:which_key_map.o = {
"       \ 'name' : '+open',
"       \ 'q' : 'open-quickfix'    ,
"       \ 'l' : 'open-locationlist',
"       \ }

let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 's' : [':Gstatus', 'git status']  ,
      \ 'd' : [':Gdiffsplit', 'git diff'] ,
      \ }

" leetcode
let g:leetcode_solution_filetype = 'python3'
let g:leetcode_username = 'kwonbin@gmail.com'
let g:leetcode_browser = 'chrome'
let g:which_key_map.l = { 'name' : '+leetcode' }
nnoremap <leader>ll :LeetCodeList<cr>
nnoremap <leader>lt :LeetCodeTest<cr>
nnoremap <leader>ls :LeetCodeSubmit<cr>
nnoremap <leader>li :LeetCodeSignIn<cr>


" Identify the syntax highlighting group used at the cursor (Debugging purpose)
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . "> trans<"
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
