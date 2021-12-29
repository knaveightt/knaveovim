"  __                                                                           
" /\ \                                                        __                
" \ \ \/'\     ___      __     __  __     __    ___   __  __ /\_\    ___ ___    
"  \ \ , <   /' _ `\  /'__`\  /\ \/\ \  /'__`\ / __`\/\ \/\ \\/\ \ /' __` __`\  
"   \ \ \\`\ /\ \/\ \/\ \L\.\_\ \ \_/ |/\  __//\ \L\ \ \ \_/ |\ \ \/\ \/\ \/\ \ 
"    \ \_\ \_\ \_\ \_\ \__/.\_\\ \___/ \ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\
"     \/_/\/_/\/_/\/_/\/__/\/_/ \/__/   \/____/\/___/  \/__/    \/_/\/_/\/_/\/_/
"
" knaveovim - my neovim config
" Loosley based on https://github.com/jez/vim-as-an-ide
" Loosley based on https://medium.com/geekculture/neovim-configuration-for-beginners-b2116dbbde84
"
" Dependencies:
" A) git
" B) Universal Ctags (ctags) [vim-easytags]
"
" Installation Procedure:
" 0) Install neovim
" 1) Install vim-plug to .local/share autoload directory via
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
"        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
" 2) Decide on colorscheme if needed (I opt to colorize my terminal)
"    Check if this influences vim-airline theme settings
" 3) Patch your terminal font for powerline, nerdfont icons, devicons, etc
"    Preference: https://github.com/ryanoasis/nerd-fonts
"    - Download and move font to ~/.local/share/fonts
"    - Run fc-cache
"    - Change terminal font to patched font
"    - Ensure vim-airline settings has powerline fonts enabled
" 4) Run :PlugInstall
" Good to go!
" _____________________________________________________________________________
" Start of Customizations
set nocompatible

" ---------- Plugin Installation ---------- "
filetype off
call plug#begin('~/.config/nvim/plugged')

" Visual Goodies
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'

" Ease of Use
Plug 'ctrlpvim/ctrlp.vim' " Control + P fuzzy find
Plug 'Raimondi/delimitMate' " match delimiters

" Git Version Control
Plug 'airblade/vim-gitgutter' " gutter symbols
Plug 'tpope/vim-fugitive' " git commands
                          " git add                  --> :Gwrite
                          " git commit               --> :Git commit
                          " git push                 --> :Gpush
                          " git checkout <file name> --> :Gread

" Programming Interface
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'vim-syntastic/syntastic'
Plug 'xolox/vim-misc' " dependency for vim-easytags
Plug 'xolox/vim-easytags'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/a.vim' " :AT opens associated header/source file

" Final Nerd Font Support
Plug 'ryanoasis/vim-devicons'

call plug#end()

" ---------- Basic Settings and Defaults ---------- "
set encoding=utf-8
set backspace=indent,eol,start " allows backspace under many circumstances
set ruler
set number
set showcmd
set incsearch
set hlsearch
hi clear SignColumn " for symbols like syntastic and vim-gitgutter
syntax on

" ---------- Plugin-Specific Settings ---------- "
" [vim-airline]
set laststatus=2 " always show statusbar
let g:airline_powerline_fonts=1 " enable patched powerline font
let g:airline_detect_paste=1 " for PASTE mode
let g:airline#extensions#tabline#enabled=1 " airline for tabs
let g:airline_theme='minimalist' " see https://github.com/vim-airline/vim-airline/wiki/Screenshots 

" [syntastic]
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
	au!
	au FileType tex let b:syntastic_mode = "passive"
augroup END

" [vim-easytags]
set tags=./tags;,~/.vimtags " directories
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" [tagbar]
"autocmd BufEnter * nested :call tagbar#autoopen(0) " placeholder for auto open

" [vim-gitgutter]
let g:airline#extensions#hunks#non_zero_only=1 " only show hunks w/ diffs

" [delimitmate]
let delimitMate_expand_cr = 1
augroup mydelimitmate
	au!
	au FileType markdown let b:delimitMate_nesting_quotes = ["`"]
	au FileType tex let b:delimitMate_quotes = ""
	au FileType tex let b:delimitMate_matchpairs = "(:),[:],{;},`:'"
	au FileType python let b:delimitMate_nesting_quotes = ['"',"'"]
augroup END

" ---------- Keymap Changes ---------- "
let mapleader = ","
" [vim-nerdtree-tabs]
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
" [tagbar]
nmap <silent> <leader>b :TagbarToggle<CR>
" close current buffer but keep split
nmap <leader>d :b#<bar>bd#<CR>
" switch to next buffer but keep split
nmap g. :bn<CR>
" switch to prev buffer but keey split
nmap g, :bp<CR>
" automatically open vimrc config file
nmap <leader>e :e ~/.config/nvim/init.vim<CR>
" move up/down chunks of editor lines vs visual lines
nnoremap gj <C-d>
nnoremap gk <C-u>
nnoremap J gj
nnoremap K gk
" Change J because of a change above
noremap <silent> <leader>J J
" Window/Split navigation (Reminder: C-w and -,+,<,> to resize, q to close)
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-w>j :sp<CR>
noremap <C-w>l :vsp<CR>
