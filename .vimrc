
"The below block is added by the Ultimate VIM configuration (https://github.com/amix/vimr)

set runtimepath+=~/.vim_runtime

source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

try
source ~/.vim_runtime/my_configs.vim
catch
endtry

" tell vim where to search for ctags
set tags=./tags,tags;$HOME

" Remap ctrl-c and ctrl-v for easy copy-paste with the system clipboard
vmap <C-c> "*y     " Yank current selection into system clipboard
nmap <C-c> "*Y     " Yank current line into system clipboard (if nothing is selected)
nmap <C-v> "*p     " Paste from system clipboard

" The below block autogenerates new tagfiles on a write to buffer
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  call DelTagOfFile(f)
  let resp = system(cmd)
endfunction

autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" remap for easy switching between vim splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" automatically start a NERDtree whens starting vim, and put it on the left
autocmd VimEnter * NERDTree
let g:NERDTreeWinPos = "left"


" Write all buffers before navigating from Vim to tmux pane
let g:tmux_navigator_save_on_switch = 2

" Call CurtineIncSw vim plugin to quickly switch between .h and .c implementations that have the same name
map <F5> :call CurtineIncSw()<CR>

" path fuckery - I'm using a proprietary compiler for embedded C development so I think I had to add this in here. 
set path+=/Applications/microchip/xc8/v2.31/pic/include
set path+=/Applications/microchip/xc8/v2.31/pic/

" force the working directory to be the directory of the file currently in focus 
set autochdir

" YouCompleteMe customizaiton
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_completion = 1

" remap forward delete to ctrl-d
inoremap <C-d> <Del>
