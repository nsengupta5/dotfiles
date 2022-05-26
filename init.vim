syntax on
set number
set relativenumber
set autoindent
set tabstop=4
set shiftwidth=4
set smarttab
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
set list lcs=tab:\|\ 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'joshdick/onedark.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lambdalisue/fern.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/syntastic'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'vimwiki/vimwiki'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'mhinz/vim-startify'
Plug 'ervandew/supertab'
Plug 'lambdalisue/nerdfont.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'sheerun/vim-polyglot'
Plug 'unblevable/quick-scope'
Plug 'ferrine/md-img-paste.vim'
Plug 'honza/vim-snippets'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'karb94/neoscroll.nvim'
Plug 'OmniSharp/omnisharp-vim'
Plug 'edluffy/hologram.nvim'
call plug#end()

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='onedark'
hi airline_tabfill ctermbg=NONE guibg=NONE

" Colorscheme
let g:onedark_hide_endofbuffer = 1
let g:onedark_termcolors = 256
let g:onedark_terminal_italics = 1
colorscheme onedark
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

" Markdown Preview Settings
let g:mkdp_browser = '/opt/brave.com/brave/brave'
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
let g:loaded_syntastic_java_javac_checker = 1
let g:syntastic_cs_checkers = ['code_checker']

" Remove background color
hi Normal guibg=NONE ctermbg=NONE

" Fern Settings
let g:fern#renderer = "nerdfont"
let g:fern#drawer_width = 40
nnoremap <silent> <C-t> :Fern . -drawer -toggle<CR>
nnoremap <silent> <C-n> :Fern . -drawer -reveal=%<CR>

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

" Coc Settings

" use <tab> for trigger completion and navigate to the next complete item
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"     \ coc#refresh()

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

" FZF Config
" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Quickscope Settings
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" Neoscroll Settings
lua require('neoscroll').setup()

map <C-f> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <leader>g :Rg<CR>
nnoremap <leader>t :Tags<CR>
nnoremap <leader>m :Marks<CR>

let g:fzf_tags_command = 'ctags -R'
" Border color
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.8, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --files --hidden"

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Get Files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


" Get text in files with Rg
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" Ripgrep advanced
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" Startify Settings
let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_enable_special = 0
let g:startify_custom_header = [
			\ '     _   __                _              ____          ' ,
			\ '    / | / /__  ____ _   __(_)___ ___     / __ \____  ___ ',
			\ '   /  |/ / _ \/ __ \ | / / / __ `__ \   / / / / __ \/ _ \',
			\ '  / /|  /  __/ /_/ / |/ / / / / / / /  / /_/ / / / /  __/',
			\ ' /_/ |_/\___/\____/|___/_/_/ /_/ /_/   \____/_/ /_/\___/ ',
			\]

" Ranger Settings
let g:rnvimr_ex_enable = 1
nmap <space>r :RnvimrToggle<CR>
" Change the border's color
let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}
