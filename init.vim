syntax on
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab
set encoding=UTF-8
set guioptions-=e
set guifont=Hack\ Nerd\ Font\ 11
set noshowmode
set clipboard=unnamedplus
set fillchars=eob:\ ,
set hidden
set ignorecase
set smartcase
set nobackup

call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'vimwiki/vimwiki'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'sainnhe/gruvbox-material'
Plug 'plasticboy/vim-markdown'
Plug 'lambdalisue/nerdfont.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'unblevable/quick-scope'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-file-browser.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'mhinz/vim-startify'
Plug 'mfussenegger/nvim-dap'
Plug 'sophacles/vim-processing'
call plug#end()

" Gruvbox Settings
let g:gruvbox_material_transparent_background = 1

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='gruvbox_material'
hi airline_tabfill ctermbg=NONE guibg=NONE

" Colorscheme
" let g:onedark_hide_endofbuffer = 1
" let g:onedark_termcolors = 256
" let g:onedark_terminal_italics = 1
 " colorscheme catppuccin_mocha
colorscheme gruvbox-material

 if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" Buffer and Tab Navigation Keybindings
noremap <S-l> gt
noremap <S-h> gT
nnoremap <PageUp>   :bprevious<CR>
nnoremap <PageDown> :bnext<CR>
nnoremap gb :buffers<CR>:buffer<Space>

" Coc Settings
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" Markdown Preview Settings
let g:mkdp_browser = 'brave-browser'
let g:mkdp_echo_preview_url = 1
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

" Recommended default settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['python']
let g:syntastic_java_checkers = []
let g:loaded_syntastic_java_javac_checker = 1
let g:syntastic_cs_checkers = ['code_checker']

" Remove background color
hi Normal guibg=NONE ctermbg=NONE

" FixCursorHold Settings
let g:cursorhold_updatetime = 100

" Fern Settings
let g:fern#renderer = "nerdfont"
let g:fern#drawer_width = 40
nnoremap <silent> <C-n> :Fern . -drawer -toggle<CR>

" For commenting
nmap <C-/> <Plug>CommentaryLine<CR>
xmap <C-/> <Plug>Commentary<CR>
omap <C-/> <Plug>Commentary<CR>

function! s:init_fern() abort
  " Use 'select' instead of 'edit' for default 'open' action
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer> T <Plug>(fern-action-new-file)
  nmap <buffer> D <Plug>(fern-action-new-dir)
  nmap <buffer> dd <Plug>(fern-action-remove)
  nmap <buffer> O <Plug>(fern-action-open:tabedit)
endfunction

augroup fern-custom
  autocmd! *
  autocmd FileType fern call s:init_fern()
augroup END

" MarkdownImage Settings
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
" there are some defaults for image directory and image name, you can change them
" let g:mdip_imgdir = 'img'
" let g:mdip_imgname = 'image'

" VimWiki Settings
let g:vimwiki_list = [{
      \ 'path': '~/vimwiki',
      \ 'template_path': '~/vimwiki/templates/',
      \ 'template_default': 'default',
      \ 'syntax': 'markdown',
      \ 'ext': '.md',
      \ 'path_html': '~/vimwiki/site_html/',
      \ 'custom_wiki2html': 'vimwiki_markdown',
      \ 'template_ext': '.tpl'}]

let g:vimwiki_global_ext = 0

" Telescope Settings
nnoremap <leader>fr <cmd>Telescope oldfiles<CR>
nnoremap <C-f> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Starify Settings
let g:startify_custom_header = [
      \ '',
      \ '',
      \ ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
      \ ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
      \ ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
      \ ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
      \ ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
      \ ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
      \ '']
