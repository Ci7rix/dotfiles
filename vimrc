let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-vinegar'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Initialize plugin system
call plug#end()

autocmd VimEnter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif

set number
set cursorline
set mouse=a
set tabstop=2 shiftwidth=2 expandtab

nnoremap <silent> <C-p> :Files<CR>

let g:nord_bold_vertical_split_line = 1
let g:nord_cursor_line_number_background = 1

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'separator': { 'left': "", 'right': "" },
      \ 'subseparator': { 'left': "", 'right': "" }
      \}

let g:netrw_keepdir = 0
let g:netrw_banner = 0
let g:netrw_localcopydircmd = 'cp -r'
let g:netrw_liststyle = 3
let g:netrw_browse_split = 3
let g:netrw_winsize = 25

colorscheme nord
