set nocompatible
filetype plugin indent off

"------- Neobundle Setting ------- 
if has('vim_starting')
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle'))
endif

NeoBundleFetch 'Shougo/neobundle.vim'

"## Plugins
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'grep.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-rails'
NeoBundleLazy 'vim-ruby/vim-ruby', {
  \ 'autoload' : {'filetypes' : ['ruby', 'eruby']}}
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'chase/vim-ansible-yaml'

"## コード補完
if has('lua')
  NeoBundle 'Shougo/neocomplete.vim'
endif
NeoBundle 'marcus/rsense'
NeoBundle 'supermomonga/neocomplete-rsense.vim'
"## 静的解析
NeoBundle 'scrooloose/syntastic'
"## ドキュメント参照
NeoBundle 'thinca/vim-ref'
NeoBundle 'yuku-t/vim-ref-ri'
"## メソッド定義元へのジャンプ
NeoBundle 'szw/vim-tags'
"## 自動で閉じる
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Townk/vim-autoclose'


NeoBundle 'glidenote/memolist.vim'
NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'vim-scripts/AnsiEsc.vim'


call neobundle#end()

filetype plugin indent on
NeoBundleCheck
"------- Neobundle Setting ------

set number
set title
set ruler
set laststatus=2
set tabstop=4
set shiftwidth=4
set softtabstop=0
set whichwrap=b,s,h,l,<,>,[,]
set cmdheight=2
set laststatus=2
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
set statusline+=%{fugitive#statusline()}
set wildmenu
set showcmd
set hlsearch
set incsearch
set listchars=tab:>\ ,extends:<
set showmatch
set autoindent

colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark

"### NERTree ###
let NERDTreeShowHidden = 1
"autocmd VimEnter * execute 'NERDTree'
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"### Rsense ###
let g:rsenseHome = '/usr/local/bin/rsense'
let g:rsenseUseOmniFunc = 1

"### neocomplete.vim ###
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"### rubocop ###
" syntastic_mode_mapをactiveにするとバッファ保存時にsyntasticが走る
" active_filetypesに、保存時にsyntasticを走らせるファイルタイプを指定する
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1

" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow

" ruby
autocmd BufNewFile,BufRead *.rb nnoremap <C-r> :!ruby %

" unite {{{
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}

" vimshell {{{
nmap <silent> vs :<C-u>VimShell<CR>
nmap <silent> vp :<C-u>VimShellPop<CR>
" }}}

" vimfiler {{{
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')
nnoremap <silent><C-u><C-j> :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>
" }}}

" memolist {{{
let g:memolist_path = expand('~/GoogleDrive/memolist')
let g:memolist_gfixgrep = 1
let g:memolist_unite = 1
let g:memolist_unite_option = "-vertical -start-insert"
nnoremap mn  :MemoNew<CR>
nnoremap ml  :MemoList<CR>
nnoremap mg  :MemoGrep<CR>
" }}}

" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
" }}}

" 最後のカーソル位置を復元する
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif

set clipboard+=unnamed
