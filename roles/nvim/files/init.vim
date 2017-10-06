" ------------------------------------------------------------------------------
" Global Configuration
" ------------------------------------------------------------------------------

" Neovim Config Dir
let $NVIM_CONFIG_DIR = fnamemodify(expand($MYVIMRC), ":h")

" Neovim Data Dir
let $NVIM_DATA_DIR = $HOME . "/.local/share/nvim"

" Change all Leaders to <SPACE>
let mapleader = " "
let maplocalleader = " "

" The time in milliseconds that is waited for a mapped sequence to complete
set timeoutlen=500

" Allow unsaved buffers to be put in the background
set hidden

" Lines the cursor is to the edge before scrolling
set scrolloff=5

" Enable line numbers
set number

" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Smart auto-indent when creating a new line
set smartindent

" Maximum width of text that is being inserted
set textwidth=80

" Do not auto-wrap when using textwidth
set formatoptions-=t

" Don't wrap lines
set nowrap

" Wrap lines at convenient points
set linebreak

" Characters to use in List mode
set listchars=eol:◊,tab:→\ ,trail:۰,extends:»,precedes:«,nbsp:●

" Keywords
set iskeyword+=-

" Prevents two spaces after punctuation on a join
set nojoinspaces

" Better search
set ignorecase
set smartcase

" Command line completion
set wildmode=longest:full,full

" Insert mode completion
set completeopt=menu,longest,preview

" Don't redraw screen
set lazyredraw

" Split windows to below and right
set splitbelow splitright

" Filling chars
" set fillchars=vert:│,fold:\ ,diff:-
set fillchars=vert:\ ,fold:\ ,diff:-

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

" Echo with Highlighting --{{
"
function! Echo(message)
    echohl ModeMsg | echo '--' a:message '--' | echohl None
endfunction
" }}--

" Toggle Color Column Mode --{{
"
function! Toggle_ColorColumn()
    if empty('&colorcolumn') || &colorcolumn != '+1'
        set colorcolumn=+1
    else
        set colorcolumn=
    endif
endfunction
" }}--

" Toggle SignColumn --{{
"
" Switch SignColumn between "auto" and "no"
function! Toggle_SignColumn()
    if &signcolumn == "auto"
        set signcolumn=no
    else
        set signcolumn=auto
    endif
endfunction
" }}--

" Highlight Extra Whitespace --{{
"
function! Highlight_Extra_Whitespace()
    if !exists('b:matchid_extra_whitespace')
        let b:matchid_extra_whitespace = matchadd('Search', '\s\+$')
    else
        call matchdelete(b:matchid_extra_whitespace)
        unlet! b:matchid_extra_whitespace
    endif
    call Echo('Highlight Extra Whitespace: '. (exists('b:matchid_extra_whitespace') ? 'Yes' : 'No'))
endfunction
" }}--

" Highlight Extra Tab while ExpandTab --{{
"
function! Highlight_Extra_Tab()
    if !exists('b:matchid_extra_tab')
        let b:matchid_extra_tab = matchadd('Search', '\t\+')
    else
        call matchdelete(b:matchid_extra_tab)
        unlet! b:matchid_extra_tab
    endif
    call Echo('Highlight Extra Tab: '. (exists('b:matchid_extra_tab') ? 'Yes' : 'No'))
endfunction
" }}--

" BuildComposer --{{
"
function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
        if has('nvim')
            !cargo build --release
        else
            !cargo build --release --no-default-features --features json-rpc
        endif
    endif
endfunction
" }}--

" ------------------------------------------------------------------------------
" Views / Sessions / Swapfiles
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Abbreviations
" ------------------------------------------------------------------------------

" ------------------------------------------------------------------------------
" Auto Commands
" ------------------------------------------------------------------------------

" Open Help Files in a Vertical Split --{{
"
augroup vsplit_help
    autocmd!
    autocmd BufWinEnter *.txt
    \   if &ft == 'help' | wincmd L | endif
augroup end
" }}--

" Jump to Last Known Position --{{
"
augroup jump_lkp
    autocmd!
    autocmd BufWinEnter *
    \   if line("'\"") > 1 && line("'\"") <= line("$") |
    \       execute "normal! g`\"" |
    \       execute "normal! zz" |
    \       execute "normal! zv" |
    \   endif
augroup end
" }}--

" ------------------------------------------------------------------------------
" Filetype Detection
" ------------------------------------------------------------------------------

" Filetype :: YAML --{{
"
augroup ft_yaml
    autocmd!
    autocmd BufNewFile,BufRead *.{yaml,yml}
    \    set tabstop=2 |
    \    set softtabstop=2 |
    \    set shiftwidth=2
augroup end
" }}--

" ------------------------------------------------------------------------------
" Plugin Manager --- Dein
" ------------------------------------------------------------------------------

" Neovim Plugin Manager Base Dir
let s:nvim_bundle_dir = $NVIM_DATA_DIR . "/bundle"

" Required!
execute "set runtimepath+=" . s:nvim_bundle_dir . "/repos/github.com/Shougo/dein.vim"

if dein#load_state(s:nvim_bundle_dir)
    call dein#begin(s:nvim_bundle_dir)

    " Dein handling Dein (Required!)
    call dein#add("Shougo/dein.vim")

    " Autcompletion & Snippets
    call dein#add("SirVer/ultisnips")
    call dein#add("honza/vim-snippets")
    call dein#add("Shougo/deoplete.nvim", {"hook_post_update": ":call dein#remote_plugins()"})
    call dein#add("zchee/deoplete-jedi")
    call dein#add("carlitux/deoplete-ternjs", {"build": "npm install -g tern"})

    " Fuzzy
    call dein#add("Shougo/denite.nvim", {"hook_post_update": ":call dein#remote_plugins()"})

    " Git
    call dein#add("airblade/vim-gitgutter")
    call dein#add("tpope/vim-fugitive")
    call dein#add("gregsexton/gitv", {"on_cmd": "Gitv"})

    " Format
    call dein#add("tpope/vim-speeddating")
    call dein#add("tpope/vim-surround")
    call dein#add("jiangmiao/auto-pairs")
    call dein#add("scrooloose/nerdcommenter")
    call dein#add("junegunn/vim-easy-align")

    " UI
    call dein#add("vim-airline/vim-airline")
    call dein#add("nbetm/vim-airline-themes")
    call dein#add("edkolev/tmuxline.vim")
    call dein#add("scrooloose/nerdtree", {"on_cmd": "NERDTreeToggle"})

    " Code Linting
    call dein#add("w0rp/ale")

    " Color Syntax
    call dein#add("rodjek/vim-puppet")
    call dein#add("pangloss/vim-javascript")
    call dein#add("moll/vim-node")

    " Color Scheme
    call dein#add("morhetz/gruvbox")

    " Other
    " call dein#add("mhinz/vim-grepper")

    " TODO: Reallocate --{{
        " Markdown Preview
        " Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
        " Plug 'vimlab/mdown.vim', { 'do': 'npm install' }

        " Node.js
        " Plug 'neovim/node-host', { 'do': 'npm install -g neovim' }
    " }}--

    " Required by the Plugin Manager
    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on

" ------------------------------------------------------------------------------
" Plugins Configuration
" ------------------------------------------------------------------------------

" gruvbox --{{
"
let g:gruvbox_termcolors = 256
" let g:gruvbox_italic = 1
" let g:gruvbox_italicize_comments = 1
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_number_column = "bg1"
let g:gruvbox_sign_column = "bg1"
let g:gruvbox_color_column = "bg1"
let g:gruvbox_vert_split = "bg1"
" }}--

" NERDTree --{{
"
let g:NERDTreeBookmarksFile = '~/.local/share/nvim/nerdtree/bookmarks'
let g:NERDTreeIgnore = ['\~$', '\.swp$', '\.git$', '\.svn']
let g:NERDTreeChDirMode = 2
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen = 0
let g:NERDTreeMapOpenSplit = 's'
let g:NERDTreeMapOpenVSplit = 'v'
let g:NERDTreeMapToggleHidden = '.'
let g:NERDTreeWinSize = 45

nmap <silent> <F3>            :NERDTreeToggle<CR>
nmap <silent> <leader>n       :NERDTreeToggle<CR>
nmap <silent> <leader>nf      :NERDTreeFind<CR>
" }}--

" NERDCommenter --{{
"
let g:NERDSpaceDelims = 2
let g:NERDDefaultAlign = 'left'
" }}--

" vim-airline --{{
"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#ale#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "gruvbox"
" }}--

" vim-fugitive --{{
"
nmap <silent> <leader>gd    :Gdiff<CR>
nmap <silent> <leader>gs    :Gstatus<CR>
nmap <silent> <leader>ga    :Git add --all \| :Gcommit --amend<CR>
vmap <silent> <leader>dg    :diffget \| diffupdate<CR>
vmap <silent> <leader>dp    :diffput \| diffupdate<CR>
" }}--

" vim-gitgutter --{{
"
let g:gitgutter_async = 1

let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '―'
let g:gitgutter_sign_modified_removed = '–'
" }}--

" Gitv --{{
"
nmap <silent> <leader>gv    :Gitv<CR>
" }}--

" tmuxline --{{
"
let g:tmuxline_preset = {
\    'a': '#S',
\    'win': ['#I', '#W'],
\    'cwin': ['#I', '#W'],
\    'y': ['%Y.%m.%d', '%R'],
\    'z': '#h',
\    'options': {'status-justify': 'left'}
\}
" }}--

" ALE --{{
"
let g:ale_sign_error   = '■'
let g:ale_sign_warning = '■'
" let g:ale_sign_error = '✘'
" let g:ale_sign_warning = 'Δ'

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Linters settings
let g:ale_linters = {
\    'yaml': ['yamllint'],
\    'python': ['pylint', 'pycodestyle'],
\}

let g:ale_yaml_yamllint_options = "-d '{extends: relaxed, rules: {line-length: {max: 120, level: warning}}}'"

let g:ale_python_pycodestyle_options = '--max-line-length=119'
let g:ale_python_pylint_options = '--max-line-length=119'

" Key mappings
nmap <silent> <C-k>      <Plug>(ale_previous_wrap)
nmap <silent> <C-j>      <Plug>(ale_next_wrap)

nmap <silent> <leader>ta :ALEToggle \| call Echo('ALE Enabled: ' . (g:ale_enabled ? 'Yes' : 'No'))<CR>
" }}--

" EasyAlign --{{
"
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}--

" UltiSnips --{{
"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'nbetm-snippets']

let g:UltiSnipsEditSplit = 'vertical'

let g:UltiSnipsExpandTrigger = '<C-Space>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsListSnippets = '<C-L>'
" }}--

" deoplete --{{
"
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:deoplete#sources#jedi#show_docstring = 1

" set completeopt-=preview
autocmd CompleteDone * silent! pclose!
" }}--

" deoplete-ternjs --{{
"
" Use deoplete
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = '0'

" Extra filetypes
let g:tern#filetypes = [
\    'jsx',
\    'javascript.jsx',
\    'vue',
\    '...'
\]
" }}--

" ------------------------------------------------------------------------------
" Key Mappings
" ------------------------------------------------------------------------------

" Wrapped lines goes down/up to next row, rather than next line in file
nnoremap j gj
nnoremap k gk

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Close current window / tab
map <silent> <leader>q      :close \| :wincmd p<CR>
map <silent> <leader>Q      :tabclose<CR>

" Edit the init.vim config file
map <silent> <leader>ev     :tabedit $HOME/.config/nvim/init.vim<CR>

" Source the init.vim config file
map <silent> <leader>sv     :source $HOME/.config/nvim/init.vim<CR>

" Toggle Paste Mode
nnoremap <F2>               :set invpaste paste?<CR>
set pastetoggle=<F2>

" Toggle ColorColumn (rule)
map <silent> <leader>tc     :call Toggle_ColorColumn()<CR>

" Toggle SingColumn (gutter)
map <silent> <leader>tg     :call Toggle_SignColumn()<CR>

" Toggle Highlighting
map <silent> <leader>th     :set hlsearch! \| call Echo('Search Highlight: '. (&hlsearch ? 'Yes' : 'No'))<CR>

" Toggle List Mode
map <silent> <leader>tl     :set list! \| call Echo('List Mode: ' . (&list ? 'Yes' : 'No'))<CR>

" Toggle Wrap
map <silent> <leader>tw     :set wrap! \| call Echo('Text Wrap: ' . (&wrap ? 'Yes' : 'No'))<CR>

" Toggle Line Number
map <silent> <leader>tn     :set number! \| call Echo('Line Number: ' . (&number ? 'Yes' : 'No'))<CR>

" Toggle Highlight Extra Characters
map <silent> <leader>ts     :call Highlight_Extra_Whitespace()<CR>
map <silent> <leader>tt     :call Highlight_Extra_Tab()<CR>

" Toggle Folding
map <silent> <leader>tf     :set foldenable! \| call Echo('Folding: ' . (&foldenable ? 'Yes' : 'No'))<CR>
nmap <silent> ,             za
vmap <silent> ,             za

" Go to the Quickfix window
nmap <silent> <leader>gq    :cwindow 5<CR>

" Go to the Location window
nmap <silent> <leader>gl    :lclose \| lopen 5<CR>

" Strip all trailing whitespace
nmap <silent> <leader>w     :silent! %s/\s\+$// \| let @/='' \| call Echo('Trailing Whitespace Stripped')<CR>

" Tab
inoremap <silent><expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
inoremap <expr> <Tab>       pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>     pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ------------------------------------------------------------------------------
" Color Scheme / Syntax
" ------------------------------------------------------------------------------

" Syntax Enabled
syntax enable

" Enable true colors (24bit color) terminal
if has('termguicolors')
    set termguicolors
endif

" Dark background
set background=dark

" Color scheme
colorscheme gruvbox

" ------------------------------------------------------------------------------
" TODO
" ------------------------------------------------------------------------------

" vim: set tw=80 fdm=marker fmr=--{{,}}-- fdl=0:
