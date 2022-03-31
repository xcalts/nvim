let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'gruvbox-community/gruvbox'
Plug 'ap/vim-css-color'
Plug 'tpope/vim-commentary'
Plug 'folke/which-key.nvim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vimwiki/vimwiki'
Plug 'OmniSharp/omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ncm2/float-preview.nvim'
Plug 'puremourning/vimspector'
Plug 'APZelos/blamer.nvim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()


" ***************************************
" COLORS:
augroup ColorschemePreferences
    autocmd!
    autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
    autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
    autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END
if has('termguicolors')
    set termguicolors
endif
set background=dark
colorscheme gruvbox
" ***************************************

" ***************************************
" BASICS:
nnoremap c "_c
set nocompatible
if !exists('g:syntax_on') | syntax enable | endif
filetype indent plugin on
syntax on
set encoding=utf-8
set number relativenumber
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=-1
set tabstop=8
set textwidth=80
set title
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set hlsearch
set incsearch
set laststatus=2
set nonumber
set noruler
set noshowmode
set signcolumn=yes
set updatetime=1000
set wildmode=longest,list,full
set completeopt=menuone,noinsert,noselect

" ***************************************
" CUSTOMS:
" ***************************************
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Spell-check set to <leader>o, 'o' for 'orthography':
map <leader>o :setlocal spell! spelllang=en_us<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Replace ex mode with gq
map Q gq
" Check file in shellcheck:
map <leader>s :!clear && shellcheck -x %<CR>
" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>
" Compile document, be it groff/LaTeX/markdown/etc.
map <leader>c :w! \| !compiler "<c-r>%"<CR>
" Open corresponding .pdf/.html or preview
map <leader>p :!opout <c-r>%<CR><CR>
" Runs a script that cleans out tex build files whenever I close out of a .tex file.
autocmd VimLeave *.tex !texclear %
" Ensure files are read as what I want:
autocmd BufRead,BufNewFile /tmp/calcurse*,~/.calcurse/notes/* set filetype=markdown
autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
autocmd BufRead,BufNewFile *.tex set filetype=tex
" Save file as sudo on files that require root permission
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
" Automatically deletes all trailing whitespace and newlines at end of file on save. & reset cursor position
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
" When shortcut files are updated, renew bash and ranger configs with new material:
autocmd BufWritePost bm-files,bm-dirs !shortcuts
" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid -f dwmblocks }
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
highlight! link DiffText MatchParen
endif
" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
if s:hidden_all  == 0
    let s:hidden_all = 1
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
else
    let s:hidden_all = 0
    set showmode
    set ruler
    set laststatus=2
    set showcmd
endif
endfunction
nnoremap <leader>h :call ToggleHiddenAll()<CR>
" ***************************************

" ***************************************
" NERD TREE:
map <leader>n :NERDTreeToggle<CR>
let g:NERDTreeIgnore = ['^bin$[[dir]]', '^obj$[[dir]]']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
    let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif
" ***************************************


" ***************************************
" WHICH KEY:
lua << EOF
  require("which-key").setup {
  }
EOF
" ***************************************

" ***************************************
" ALE:
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_info = '·'
let g:ale_sign_style_error = '·'
let g:ale_sign_style_warning = '·'
let g:ale_linters = { 'cs': ['OmniSharp'] }
" ***************************************

" ***************************************
" ASYNCOMPLETE:
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" ***************************************


" ***************************************
" SHARPENUP:
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :OmniSharpGotoDefinition
let g:sharpenup_map_prefix = '<Space>os'
let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END
" ***************************************

" ***************************************
" LIGHTLINE:
let g:lightline = {
\ 'colorscheme': 'gruvbox',
\ 'active': {
\   'right': [
\     ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok'],
\     ['lineinfo'], ['percent'],
\     ['fileformat', 'fileencoding', 'filetype', 'sharpenup']
\   ]
\ },
\ 'inactive': {
\   'right': [['lineinfo'], ['percent'], ['sharpenup']]
\ },
\ 'component': {
\   'sharpenup': sharpenup#statusline#Build()
\ },
\ 'component_expand': {
\   'linter_checking': 'lightline#ale#checking',
\   'linter_infos': 'lightline#ale#infos',
\   'linter_warnings': 'lightline#ale#warnings',
\   'linter_errors': 'lightline#ale#errors',
\   'linter_ok': 'lightline#ale#ok'
  \  },
  \ 'component_type': {
  \   'linter_checking': 'right',
  \   'linter_infos': 'right',
  \   'linter_warnings': 'warning',
  \   'linter_errors': 'error',
  \   'linter_ok': 'right'
\  }
\}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "
" }}}
" ***************************************

" ***************************************
" OMNISHARP:
let g:OmniSharp_want_snippet = 1
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_popup_position = 'atcursor'
let g:OmniSharp_popup_options = {
\ 'winhl': 'Normal:NormalFloat'
\}
let g:OmniSharp_popup_mappings = {
\ 'sigNext': '<C-n>',
\ 'sigPrev': '<C-p>',
\ 'pageDown': ['<C-f>', '<PageDown>'],
\ 'pageUp': ['<C-b>', '<PageUp>']
\}
let g:OmniSharp_highlight_groups = {
\ 'ExcludedCode': 'NonText'
\}
let g:OmniSharp_start_without_solution = 1
autocmd FileType cs nnoremap <leader>mb :wa!<cr>:OmniSharpBuildAsync<cr>
autocmd FileType cs nnoremap <leader>mg :OmniSharpGotoDefinition<cr>
autocmd FileType cs nnoremap <leader>mt :OmniSharpTypeLookup<cr>
autocmd FileType cs nnoremap <leader>mr :OmniSharpRename<CR>
autocmd FileType cs nnoremap <leader>mc :OmniSharpCodeFormat<CR>
autocmd FileType cs nnoremap <leader>md :OmniSharpDocumentation<cr>
autocmd FileType cs nnoremap <leader>mfi :OmniSharpFindImplementations<cr>
autocmd FileType cs nnoremap <leader>mft :OmniSharpFindType<cr>
autocmd FileType cs nnoremap <leader>mfs :OmniSharpFindSymbol<cr>
autocmd FileType cs nnoremap <leader>mfu :OmniSharpFindUsages<cr>
autocmd FileType cs nnoremap <leader>mfm :OmniSharpFindMembers<cr>
autocmd FileType cs nnoremap <leader>mss :OmniSharpStartServer<cr>
autocmd FileType cs nnoremap <leader>msp :OmniSharpStopServer<cr>
autocmd FileType cs nnoremap <leader>mxi  :OmniSharpFixIssue<cr>
autocmd FileType cs nnoremap <leader>mxu :OmniSharpFixUsings<cr>
" ***************************************


" ***************************************
" FLOATPREVIEW:
let g:float_preview#docked = 1
" ***************************************

" ***************************************
" VIMSPECTOR:
let g:vimspector_enable_mappings = 'HUMAN'
" ***************************************

" ***************************************
" ULTISNIPS:
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" ***************************************

" ***************************************
" BLAMER:
let g:blamer_enabled = 1
" ***************************************
