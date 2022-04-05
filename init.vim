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
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'OmniSharp/omnisharp-vim'
Plug 'nickspoons/vim-sharpenup'
Plug 'dense-analysis/ale'
Plug 'ncm2/float-preview.nvim'
Plug 'puremourning/vimspector'
Plug 'APZelos/blamer.nvim'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'folke/which-key.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
call plug#end()

" ***************************************
" WHICHKEY:
lua << EOF
  require("which-key").setup {
  }
local wk = require("which-key")
wk.register({
  ["<F5>"]        = {"<Plug>VimspectorContinue", "Vimspector: Start/Continue debugging."},
  ["<S-F5>"]      = {"<Plug>VimspectorStop", "Vimspector: Stop debugging."},
  ["<C-S-F5>"]    = {"<Plug>VimspectorRestart", "Vimspector: Restart debugging."},
  ["<F6>"]        = {"<Plug>VimspectorPause", "Vimspector: Pause debuggee."},
  ["<F9>"]        = {"<PlugVimspectorToggleBreakpoint>", "Vimspector: Toggle breakpoint."},
  ["<S-F9>"]      = {"<Plug>VimspectorAddFunctionBreakpoint", "Vimspector: Add a function breakpoint."},
  ["<F10>"]       = {"<Plug>VimspectorStepOver", "Vimspector: Step Over"},
  ["<F11>"]       = {"<Plug>VimspectorStepInto", "Vimspector: Step Into"},
  ["<S-F11>"]     = {"<Plug>VimspectorStepOut", "Vimspector: Step out of current function."},

  ["<leader>f"]   = { name = "+Telescope" },
  ["<leader>ff"]  = { "<cmd>Telescope find_files<cr>", "Telescope: Find File" },
  ["<leader>fr"]  = { "<cmd>Telescope oldfiles<cr>", "Telescope: Open Recent File" },
  ["<leader>fg"]  = { "<cmd>Telescope live_grep<cr>", "Telescope: Search string under cursor in your cwd." },

  ["<leader>n"]   = { name = "+Nerdtree" },
  ["<leader>no"]  = { ":NERDTreeToggle<cr>", "Nerdtree: Open tree." },

  ["<F5>"]        = {"<Plug>VimspectorContinue", "Vimspector: Start/Continue debugging."},
  ["<S-F5>"]      = {"<Plug>VimspectorStop", "Vimspector: Stop debugging."},
  ["<C-S-F5>"]    = {"<Plug>VimspectorRestart", "Vimspector: Restart debugging."},
  ["<F6>"]        = {"<Plug>VimspectorPause", "Vimspector: Pause debuggee."},
  ["<F9>"]        = {"<PlugVimspectorToggleBreakpoint>", "Vimspector: Toggle breakpoint."},
  ["<S-F9>"]      = {"<Plug>VimspectorAddFunctionBreakpoint", "Vimspector: Add a function breakpoint."},
  ["<F10>"]       = {"<Plug>VimspectorStepOver", "Vimspector: Step Over"},
  ["<F11>"]       = {"<Plug>VimspectorStepInto", "Vimspector: Step Into"},
  ["<S-F11>"]     = {"<Plug>VimspectorStepOut", "Vimspector: Step out of current function."},

  ["<leader>c"]   = { name = "+Customs"},
  ["<leader>co"]  = { ":setlocal spell! spelllang=en_us<cr>", "Customs: Spell Check." },

  ["<leader>o"]   = { name = "+Omnisharp"},
  ["<leader>og"]  = {"<Plug>{omnisharp_go_to_definition}", "Omnisharp: Go to definition."},
  ["<leader>op"]  = { name = "+Omnisharp: Previews."},
  ["<leader>opd"] = {"<Plug> {omnisharp_preview_definition}", "Omnisharp: Preview definition."},
  ["<leader>opi"] = {"<Plug> {omnisharp_preview_implementation}", "Omnisharp: Preview implementation."},
  ["<leader>od"]  = {"<Plug> {omnisharp_documentation}", "Omnisharp: Show Documentations."},
  ["<leader>of"]  = { name = "+Omnisharp: Find & Fix."},
  ["<leader>ofu"] = {"<Plug> {omnisharp_find_usages}", "Omnisharp: Find usages."},
  ["<leader>ofi"] = {"<Plug> {omnisharp_find_implementations}", "Omnisharp: Find implementations."},
  ["<leader>ofs"] = {"<Plug> {omnisharp_find_symbol}", "Omnisharp: Find Symbol." },
  ["<leader>oft"] = {"<Plug> {omnisharp_find_type}", "Omnisharp: Find Type.", },
  ["<leader>ofl"] = {"<Plug> {omnisharp_type_lookup}", "Omnisharp: Type Lookup."},
  ["<leader>ofx"] = {"<Plug> {omnisharp_fix_usings}", "Omnisharp: Fix Usings..", },
  ["<leader>os"]  = {"<Plug> {omnisharp_signature_help}", "Omnisharp: Signature help.", },
  ["<leader>on"]  = {"<Plug> {omnisharp_rename}", "Omnisharp: Rename."},
  ["<leader>oo"]  = { name = "+Omnisharp: Omnisharp Controls"},
  ["<leader>oor"] = {"<Plug> {omnisharp_restart_server}", "Omnisharp: Restart Server."},
  ["<leader>oos"] = {"<Plug> {omnisharp_start_server}", "Omnisharp: Start Server." },
  ["<leader>ooe"] = {"<Plug> {omnisharp_stop_server}", "Omnisharp: Exit Server."},
  ["<leader>ot"]  = { name = "+Omnisharp: Omnisharp Tests."},
  ["<leader>ott"] = {"<Plug> {omnisharp_run_test}", "Omnisharp: Run Test Under Cursor." },
  ["<leader>otf"] = {"<Plug> {omnisharp_run_tests_in_file}", "Omnisharp: Run All Tests in File.", },
  ["<leader>otd"] = {"<Plug> {omnisharp_debug_test}", "Omnisharp: Debug Test Under Cursor."},

  ["<leader>m"]   = { name = "+Markdown" },
  ["<leader>ms"]  = { "<Plug>MarkdownPreview", "Markdown: Start the Preview" },
  ["<leader>me"]  = { "<Plug>MarkdownPreviewStop", "Markdown: Exit the Preview" },

  ['gD']          = { "<cmd>lua vim.lsp.buf.declaration()<CR>" },
  ['gd']          = { "<cmd>lua vim.lsp.buf.definition()<CR>" },
  ['K']           = { "<cmd>lua vim.lsp.buf.hover()<CR>" },
  ['gi']          = { "<cmd>lua vim.lsp.buf.implementation()<CR>" },
  ['<C-k>']       = { "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
  ['<leader>wa']  = { "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
  ['<leader>wr']  = { "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
  ['<leader>wl']  = { "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
  ['<leader>D']   = { "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
  ['<leader>rn']  = { "<cmd>lua vim.lsp.buf.rename()<CR>" },
  ['<leader>ca']  = { "<cmd>lua vim.lsp.buf.code_action()<CR>" },
  ['gr']          = { "<cmd>lua vim.lsp.buf.references()<CR>" },
  ['<leader>f']   = { "<cmd>lua vim.lsp.buf.formatting()<CR>" }
})
EOF
" ***************************************

" ***************************************
" " NVIMLSPCONFIG:
lua << EOF
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
  sources = {
    { name = 'nvim_lsp' },
  }
}

require'lspconfig'.omnisharp.setup {
  capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
  on_attach = function(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  end,
  cmd = { "/usr/bin/omnisharp", "--languageserver" , "--hostPID", tostring(pid) },
}

local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'rust_analyzer', 'tsserver', lspconfig }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
EOF
" ***************************************

" ***************************************
" GRUVBOX:
augroup ColorschemePreferences
    autocmd!
    autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
    autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
    autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
    autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END
colorscheme gruvbox
" ***************************************

" ***************************************
" BASICS:
set termguicolors
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
set timeoutlen=500
" ***************************************

" ***************************************
" CUSTOMS:
" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
" Replace ex mode with gq
map Q gq
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
" ***************************************

" ***************************************
" NERDTREE:
let g:NERDTreeIgnore = ['^bin$[[dir]]', '^obj$[[dir]]']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
if has('nvim')
    let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
else
    let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
endif
let NERDTreeShowHidden=1
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
" let g:asyncomplete_auto_popup = 1
" let g:asyncomplete_auto_completeopt = 0
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
" ***************************************


" ***************************************
" SHARPENUP:
" All sharpenup mappings will begin with `<Space>os`, e.g. `<Space>osgd` for
" :OmniSharpGotoDefinition
" let g:sharpenup_map_prefix = ','
" let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
" let g:sharpenup_statusline_opts.Highlight = 0

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
" autocmd FileType cs nnoremap <leader>mb :wa!<cr>:OmniSharpBuildAsync<cr>
" autocmd FileType cs nnoremap <leader>mg :OmniSharpGotoDefinition<cr>
" autocmd FileType cs nnoremap <leader>mt :OmniSharpTypeLookup<cr>
" autocmd FileType cs nnoremap <leader>mr :OmniSharpRename<CR>
" autocmd FileType cs nnoremap <leader>mc :OmniSharpCodeFormat<CR>
" autocmd FileType cs nnoremap <leader>md :OmniSharpDocumentation<cr>
" autocmd FileType cs nnoremap <leader>mfi :OmniSharpFindImplementations<cr>
" autocmd FileType cs nnoremap <leader>mft :OmniSharpFindType<cr>
" autocmd FileType cs nnoremap <leader>mfs :OmniSharpFindSymbol<cr>
" autocmd FileType cs nnoremap <leader>mfu :OmniSharpFindUsages<cr>
" autocmd FileType cs nnoremap <leader>mfm :OmniSharpFindMembers<cr>
" autocmd FileType cs nnoremap <leader>mss :OmniSharpStartServer<cr>
" autocmd FileType cs nnoremap <leader>msp :OmniSharpStopServer<cr>
" autocmd FileType cs nnoremap <leader>mxi :OmniSharpFixIssue<cr>
" autocmd FileType cs nnoremap <leader>mxu :OmniSharpFixUsings<cr>
" ***************************************


" ***************************************
" FLOATPREVIEW:
let g:float_preview#docked = 1
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

" ***************************************
" MARKDOWNPREVIEW:
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
" ***************************************
