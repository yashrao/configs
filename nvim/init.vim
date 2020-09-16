set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath

" Specify a directory for plugins                                                                                                           
" - For Neovim: stdpath('data') . '/plugged'                                                                                                
" - Avoid using standard Vim directory names like 'plugin'                                                                                  
call plug#begin('~/.config/nvim/plugged')                                                                                                   
Plug 'davidhalter/jedi-vim' " Make sure you have pynvim installed 'pip3 install --user pynvim'                                              
Plug 'shougo/unite.vim'                                                                                                                     
Plug 'shougo/vimfiler.vim'                                                                                                                  
Plug 'srcery-colors/srcery-vim'                                                                                                             
Plug 'ervandew/supertab' " Lets you use tab for autocomplete                                                                                
Plug 'deoplete-plugins/deoplete-jedi' " Make sure you've installed 'pip3 install --user jedi'                                               
Plug 'sheerun/vim-polyglot'                                                                                                                 
" Initialize plugin system                                                                                                                  
call plug#end()                                                                                                                             
                                                                                                                                            
map <C-f> :VimFilerExplorer<CR>                                                                                                             
set nu                                                                                                                                      
                                                                                                                                            
let g:jedi#completions_enabled = 0 " Want to use deoplete-jedi for completions                                                              
                                                                                                                                            
set termguicolors                                                                                                                           
" Set color here                                                                                                                            
                                                                                                                                            
" the configuration options should be placed before `colorscheme miramare`                                                                  
colorscheme srcery
