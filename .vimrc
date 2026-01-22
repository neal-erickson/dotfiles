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
" (Note: as of 7/7/2023 this broke on os x...)
"set termguicolors
" Instead using basic included color scheme
colo slate

"Mode Settings -
"https://vim.fandom.com/wiki/Change_cursor_shape_in_different_modes

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"Cursor settings:

"  1 -> blinking block
"  "  2 -> solid block 
"  "  3 -> blinking underscore
"  "  4 -> solid underscore
"  "  5 -> blinking vertical bar
"  "  6 -> solid vertical bar

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

"""""""""""""""""""""""""""""""""""""
" Plugins
"""""""""""""""""""""""""""""""""""""

"" vim-plug configuration - https://github.com/junegunn/vim-plug   
"" Specify a directory for plugins
"" - For Neovim: stdpath('data') . '/plugged'
"" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" NERDTree - file system explorer
" https://github.com/preservim/nerdtree#the-nerdtree-
Plug 'preservim/nerdtree'

" Gruvbox - theme with retro groove, vein of Solarized
" https://github.com/morhetz/gruvbox
Plug 'morhetz/gruvbox'

" Vim-airline: Fancy status tabline
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'

" Themes for the above
" https://github.com/vim-airline/vim-airline-themes
Plug 'vim-airline/vim-airline-themes'

" TODO: Evaluate 'fzf' necessity
"Plug 'junegunn/fzf'

" Initialize plugin system
call plug#end()
"
"" Set theme
"autocmd vimenter * ++nested colorscheme gruvbox
"" set background=light " light/dark
"
"" Set airline statusbar theme
let g:airline_theme = 'gruvbox'
"
let NERDTreeShowHidden=1
"
"" NERDTree shortcuts
"nnoremap <silent> <leader>d :NERDTreeToggle<CR>
"nnoremap <silent> <leader>f :NERDTreeFind<CR>
