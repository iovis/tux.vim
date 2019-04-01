# Tux.vim

Launch commands in Tmux from Vim

![Tux](https://cdn0.iconfinder.com/data/icons/event-celebration-1/64/85-128.png)

## Installation ##

Use your preferred installation method for Vim plugins.

With [vim-plug](https://github.com/junegunn/vim-plug) that would mean to add
the following to your vimrc:

```vim
Plug 'iovis9/tmux.vim'
```

## Usage ##

Launch `:Tux` to run a command in your last pane or create a new one. Use `!` for running it in a new window.

```vim
:Tux[!] {cmd}
```

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
