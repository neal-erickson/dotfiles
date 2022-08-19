" Recommendation: https://github.com/romainl/idiomatic-vimrc
 let mapleader=","

" Syntax highlighting on
syntax on
" Always show status bar
set laststatus=2
" Line numbers
set number
set ruler
set cursorline
" No error sounds
set noerrorbells
" when creating a new line, copy the indentation from the line above
set autoindent
" show the matching brackets
set showmatch
" Use fancy new colors... hopefully...
set termguicolors

"""""""""""""""""""""""""""""""""""""
" Search
"""""""""""""""""""""""""""""""""""""
" Ignore case when searching
set ignorecase
set smartcase

" highlight search results (after pressing Enter)
set hlsearch

" highlight all pattern matches WHILE typing the pattern
set incsearch

" when creating a new line, copy the indentation from the line above
set autoindent
set smartindent

" vim-plug configuration - https://github.com/junegunn/vim-plug   
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdtree'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'

" Initialize plugin system
call plug#end()

" Set theme
autocmd vimenter * ++nested colorscheme gruvbox
" set background=light " light/dark

" Set airline statusbar theme
let g:airline_theme = 'gruvbox'

let NERDTreeShowHidden=1

" NERDTree shortcuts
nnoremap <silent> <leader>d :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
