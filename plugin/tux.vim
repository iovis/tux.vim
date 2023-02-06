if exists('tux_loaded') || v:version < 700
  finish
endif
let tux_loaded = 1

if !exists('g:tux_pane_size')
  let g:tux_pane_size = 30
endif

command! -nargs=+ -complete=shellcmd -bang TuxRaw call <SID>tmuxRawCommand(<q-args>, <bang>0)
command! -nargs=+ -complete=shellcmd -bang Tux    call <SID>tmuxCommand(<q-args>, <bang>0)
command! -nargs=+ -complete=shellcmd -bang TuxBg  call <SID>tmuxBgCommand(<q-args>, <bang>0)

function! s:tmuxRawCommand(command, new_window)
  let l:tmux_command = s:parseCommand(a:command, a:new_window)

  silent execute l:tmux_command
endfunction

" Execute in last pane
" <bang>: new window
function! s:tmuxCommand(command, new_window)
  let l:tmux_command = s:parseCommand(a:command, a:new_window)
  let l:tmux_command = escape(l:tmux_command, ';')

  silent execute l:tmux_command
endfunction

" Execute in new window and clean window on exit
function! s:tmuxBgCommand(command, background)
  let l:tmux_command = '!tmux new-window '

  if a:background
    let l:tmux_command .= '-d '
  endif

  " wait in case of error or ctrl-c
  let l:status = '$?'

  if &shell =~# 'csh\|fish'
    let l:status = '$status'
  endif

  let l:wait = '; test ' . l:status . ' = 0 -o ' . l:status . ' = 130 || exec head -1'


  let l:tmux_command .= '$SHELL -i -c '
  let l:tmux_command .= shellescape(a:command . l:wait)

  silent execute l:tmux_command
endfunction

function! s:parseCommand(command, new_window)
  let l:new_pane = 0

  " Open a window or pane if necessary
  if a:new_window
    silent execute '!tmux new-window'
  elseif trim(system('tmux list-panes | wc -l')) ==# '1'
    let l:new_pane = 1
    silent execute '!tmux split-window -p' . g:tux_pane_size
  endif

  let l:tmux_command = '!tmux send-keys '

  " Execute in last pane if there's one
  if !a:new_window && !l:new_pane
    let l:tmux_command .= '-t \! '
  endif

  let l:tmux_command .= shellescape(a:command)
  let l:tmux_command .= ' Enter'

  return l:tmux_command
endfunction
