"this is a comment
"type :help command to see the vim help docs for that command

"this should be first always according to help docs if going to set it
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPTIONS FOR ALL FILES UNLESS OVERRIDDEN BY FILETYPE
"""""""""""""""""""""""""""""""""""""""""""""""""""""

"if the number of colors supported by terminal is > 1 enable syntax highlighting
if &t_Co > 1
  syntax enable
endif
"enable filetype detection
:filetype on
"number of spaces to shift when using >> or << command in normal mode
set shiftwidth=2
"showmode indicates input or replace mode at bottom
set showmode
"showmatch briefly jumps to the line as you search
set showmatch
"shortcut for toggling paste while in insert mode, press F2 key
set pastetoggle=<f2>
"when backspacing will backspace over eol, autoindent, and start
set backspace=2
"hlsearch for when there is a previous search pattern, highlight all its matches.
set hlsearch
"ruler shows line and char number in bottom right of vim
set ruler
"each line has line number prepended
set number
"expandtab means tabs create spaces in insert mode, softtabstop is the number of spaces created
"tabstop affects visual representation of tabs only
set tabstop=8
set expandtab
set softtabstop=2
set incsearch
"always show status bar at bottom
set laststatus=2
"always show tab bar at the top
"set showtabline=2
"ignore case sensitivity
set ignorecase
"Modify vim terminal colors based on the terminal background being light or dark
"set background=light
set background=dark
"when pressing ENTER will automatically indent the line
set autoindent

""""""""""""""""
" CHARACTER MAPS
""""""""""""""""

":w!! will ask for password when trying to write to system files
"useful if you open a file as a user but need sudo to write to it as root
cmap w!! %!sudo tee > /dev/null %

"""""""""""""""""""""""""""""
" AUTOCMD FILE LOGIC BEHAVIOR
"""""""""""""""""""""""""""""

:autocmd BufNewFile,BufRead .gitconfig_settings setlocal filetype=gitconfig
:autocmd BufNewFile,BufRead *.gradle setlocal filetype=groovy
:autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
"cfengine promises files
:autocmd BufNewFile,BufRead *.cf setlocal filetype=conf
"Set options in a specific way based on what type of file is opened
:autocmd FileType java,xml,python,markdown,make,gitconfig,groovy set shiftwidth=4 tabstop=4 softtabstop=4
:autocmd FileType ruby set shiftwidth=2 tabstop=2 softtabstop=2 textwidth=80
:autocmd FileType c,cpp,java,groovy set cindent
"indent with tabs when following FileTypes are opened
:autocmd FileType make,gitconfig set noexpandtab
"auto newline at 80 characters as you type
:autocmd FileType markdown set textwidth=80
"will highlight trailing white space with grey
:highlight ExtraWhitespace ctermfg=Grey ctermbg=LightGrey
:autocmd ColorScheme * highlight ExtraWhitespace ctermfg=Grey ctermbg=LightGrey
:autocmd BufWinEnter * let w:m2=matchadd('ExtraWhitespace', '\s\+\%#\@<!$', -1)
"highlight lines longer than 80 chars in red
:autocmd BufWinEnter *.md,*.sh let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)

"""""""""""
" FUNCTIONS
"""""""""""

"This executes a command and puts output into a throw away scratch pad
"source: http://vim.wikia.com/wiki/Display_output_of_shell_commands_in_new_window
function! s:ExecuteInShell(command, bang)
  let _ = a:bang != '' ? s:_ : a:command == '' ? '' : join(map(split(a:command), 'expand(v:val)'))
  if (_ != '')
    let s:_ = _
    let bufnr = bufnr('%')
    let winnr = bufwinnr('^' . _ . '$')
    silent! execute  winnr < 0 ? 'belowright new ' . fnameescape(_) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile wrap number
    silent! :%d
    let message = 'Execute ' . _ . '...'
    call append(0, message)
    echo message
    silent! 2d | resize 1 | redraw
    silent! execute 'silent! %!'. _
    silent! execute 'resize ' . line('$')
    silent! execute 'syntax on'
    silent! execute 'autocmd BufUnload <buffer> execute bufwinnr(' . bufnr . ') . ''wincmd w'''
    silent! execute 'autocmd BufEnter <buffer> execute ''resize '' .  line(''$'')'
    silent! execute 'nnoremap <silent> <buffer> <CR> :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . _ . ''', '''')<CR>'
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>g :execute bufwinnr(' . bufnr . ') . ''wincmd w''<CR>'
    nnoremap <silent> <buffer> <C-W>_ :execute 'resize ' . line('$')<CR>
    silent! syntax on
  endif
endfunction

""""""""""
" COMMANDS
""""""""""

command! -complete=shellcmd -nargs=* -bang Scratchpad call s:ExecuteInShell(<q-args>, '<bang>')
command! -complete=shellcmd -nargs=* -bang Scp call s:ExecuteInShell(<q-args>, '<bang>')
