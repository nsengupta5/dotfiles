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
Plug 'itchyny/lightline.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'preservim/nerdtree'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sensible'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mengelbrecht/lightline-bufferline'
Plug 'scrooloose/syntastic'
Plug 'ryanoasis/vim-devicons'
Plug 'Pocco81/TrueZen.nvim'
Plug 'jiangmiao/auto-pairs'
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

" Lightline settings
let g:lightline = {
  \ 'colorscheme': 'onedark',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'FugitiveHead'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' },
  \ 'tabline': {
  \   'left': [ ['buffers'] ]
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ }
  \ }

let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#shorten_path = 0
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#icon_position = 'first'
let g:lightline#bufferline#unnamed      = '[No Name]' 


autocmd VimEnter * call SetupLightlineColors()
function SetupLightlineColors() abort
  let l:pallete = lightline#palette()
  let l:pallete.normal.left[1][3] = 'NONE'
  call lightline#colorscheme()
endfunction

" Remove background color
hi Normal guibg=NONE ctermbg=NONE

" grip setup
let vim_markdown_preview_github=1

" Remap NERDTree 
nnoremap <C-n> :NERDTree<CR>
