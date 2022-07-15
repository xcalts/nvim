" bQqqr' Neovim Init.vim

" =VimPlug=

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-json', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-prettier', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-eslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-tslint', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-css', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-lists', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-highlight', {'do': 'yarn install --frozen-lockfile'}
Plug 'vim-airline/vim-airline'
Plug 'rcarriga/nvim-notify'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'puremourning/vimspector'
Plug 'folke/which-key.nvim'
Plug 'APZelos/blamer.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
Plug 'numToStr/Comment.nvim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

" =WhichKey=

lua << EOF
require("which-key").setup {}
local wk = require("which-key")
wk.register({
  ["<F5>"]       = { "<Plug>VimspectorContinue", "Vimspector: start/continue debugging." },
  ["<S-F5>"]     = { "<Plug>VimspectorStop", "Vimspector: stop debugging." },
  ["<CS-F5"]     = { "<Plug>VimspectorRestart", "Vimspector: restart debugging." },
  ["<F6>"]       = { "<Plug>VimspectorPause", "Vimspector: pause debugger." },
  ["<F9>"]       = { "<PlugVimspectorToggleBreakpoint>", "Vimspector: toggle breakpoint." },
  ["<F10>"]      = { "<Plug>VimspectorStepOver", "Vimspector: step over." },
  ["<F11>"]      = { "<Plug>VimspectorStepInto", "Vimspector: step into." },
  ["<S-F11>"]    = { "<Plug>VimspectorStepOut", "Vimspector: step out of current function." },

  ["<leader>n"]  = { "<cmd>NvimTreeToggle<cr>", "NvimTree: open and close tree." },

  ["<leader>c"]  = { name = "+Customs" },
  ["<leader>co"] = { ":setlocal spell! spelllang=en_us<cr>", "Customs: check spell." },

  ["<leader>g"]  = { name = "+Coc"},
  ["<F12>"]      = { "<Plug>(coc-implementation)", "Coc: go to implementation." },
  ["<S-F12>"]    = { "<Plug>(coc-references)", "Coc: find references." },
  ["<F2>"]       = { "<Plug>(coc-rename)", "Coc: rename symbol." },

  ["<leader>f"]  = { name = "+Telescope"},
  ["<leader>ff"] = { "<cmd>Telescope find_files<cr>", "Telescope: lists files in your cwd." },
  ["<leader>fg"] = { "<cmd>Telescope live_grep<cr>", "Telescope: search for a string in your cwd live." },
  ["<leader>fb"] = { "<cmd>Telescope buffers<cr>", "Telescope: lists open buffers in current instance." },

  ["<leader>t"]  = { name = "+Toggleterm" },
  ["<leader>tt"] = { "<cmd>ToggleTerm size=20 dir=. direction=horizontal<cr>", "ToggleTerm: spawn a terminal." },
  ["<leader>tg"] = { "<cmd>lua _lazygit_toggle()<cr>", "ToggleTerm: spawn lazygit." },
  ["<A-,>"]    = { "<cmd>BufferPrevious<cr>", "" },
  ["<A-.>"]    = { "<cmd>BufferNext<cr>", "" },
  ["<A-w>"]     = { "<cmd>BufferClose<cr>", "" },
})
EOF

" =NvimTree=

lua << EOF
require("nvim-tree").setup()

local nvim_tree_events = require('nvim-tree.events')
local bufferline_state = require('bufferline.state')

nvim_tree_events.on_tree_open(function ()
  bufferline_state.set_offset(31, "File Tree")
end)

nvim_tree_events.on_tree_close(function ()
  bufferline_state.set_offset(0)
end)
EOF

" =Comment=

lua << EOF
require('Comment').setup()
EOF

" =Toggleterm=

lua << EOF
require("toggleterm").setup {}
local lazygit = require("toggleterm.terminal").Terminal:new({
  cmd = "lazygit",
  dir = "git_dir",
  direction = "float",
  float_opts = {
    border = "double",
  },
  -- function to run on opening the terminal
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  -- function to run on closing the terminal
  on_close = function(term)
    vim.cmd("Closing terminal")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end
EOF

" =Coc=

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>
function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')



" =Keybindings=

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" =Basics=

let mapleader =","
colorscheme gruvbox
set background=dark
set termguicolors
set number
nnoremap c "_c
set nocompatible
if !exists('g:syntax_on') | syntax enable | endif
filetype indent plugin on
syntax on
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
set noruler
set noshowmode
set signcolumn=yes
set updatetime=1000
set wildmode=longest,list,full
set completeopt=menuone,noinsert,noselect
set timeoutlen=500
set hidden

" =Customs=

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
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

" =Notifications

lua << EOF
local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

local coc_diag_record = {}

function coc_diag_notify(msg, level)
  local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
  -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
  if coc_diag_record ~= {} then
    notify_opts["replace"] = coc_diag_record.id
  end
  coc_diag_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_diag_record(window)
  coc_diag_record = {}
end
EOF

function! s:DiagnosticNotify() abort
  let l:info = get(b:, 'coc_diagnostic_info', {})
  if empty(l:info) | return '' | endif
  let l:msgs = []
  let l:level = 'info'
   if get(l:info, 'warning', 0)
    let l:level = 'warn'
  endif
  if get(l:info, 'error', 0)
    let l:level = 'error'
  endif

  if get(l:info, 'error', 0)
    call add(l:msgs, ' Errors: ' . l:info['error'])
  endif
  if get(l:info, 'warning', 0)
    call add(l:msgs, ' Warnings: ' . l:info['warning'])
  endif
  if get(l:info, 'information', 0)
    call add(l:msgs, ' Infos: ' . l:info['information'])
  endif
  if get(l:info, 'hint', 0)
    call add(l:msgs, ' Hints: ' . l:info['hint'])
  endif
  let l:msg = join(l:msgs, "\n")
  if empty(l:msg) | let l:msg = ' All OK' | endif
  call v:lua.coc_diag_notify(l:msg, l:level)
endfunction

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
  call v:lua.coc_status_notify(l:status, l:level)
endfunction

function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()
