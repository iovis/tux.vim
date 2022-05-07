# Tux.vim

Launch commands in Tmux from Vim

![Tux](https://cdn0.iconfinder.com/data/icons/event-celebration-1/64/85-128.png)

## Installation ##

Use your preferred installation method for Vim plugins.

```vim
Plug 'iovis/tux.vim'
```

```lua
use("iovis/tux.vim")
```

## Usage ##

Launch `:Tux` to run a command in your last pane or create a new one. Use `!` for running it in a new window.

```vim
:Tux[!] {cmd}
```

The command `:TuxRaw` won't escape semicolons.

## Examples ##

Launch `rspec` on the current file

```vim
:Tux rspec %
```

Launch `htop` in a new window

```vim
:Tux! htop
```

Run last command of last pane

```vim
:Tux Up
```

Execute current line in last pane

```vim
:execute 'Tux ' . getline('.')
```

Run `rspec` for current file and line

```vim
:execute 'Tux ' . expand('%') . line('.')
```
