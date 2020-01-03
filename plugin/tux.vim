if exists('tux_loaded') || v:version < 700
  finish
endif
let tux_loaded = 1

if !exists('g:tux_pane_size')
  let g:tux_pane_size = 30
endif

command! -nargs=+ -complete=shellcmd -bang Tux call <SID>tmuxCommand(<q-args>, <bang>0)

function! s:tmuxCommand(command, new_window)
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
  let l:tmux_command = escape(l:tmux_command, ';')

  silent execute l:tmux_command
endfunction
