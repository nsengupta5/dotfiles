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
Plug 'tpope/vim-surround'
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
Plug 'lambdalisue/fern-git-status.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'Pocco81/TrueZen.nvim'
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
Plug 'ferrine/md-img-paste.vim'
call plug#end()

colorscheme onedark

" Recommended default settings for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['python']

" Airline Settings
let g:airline#extensions#tabline#enabled = 1

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
