# vim-kubernetes

This package provides kubernetes YAML snippets (requires
[ultisnips](https://github.com/sirver/UltiSnips), as well as a number of
integrations with kubectl (requires that you actually have kubectl installed and
on your `PATH`).

## Quick Start

If you are using Vundle, add this to your `~/.vimrc`:

```vim
Plugin 'andrewstuart/vim-kubernetes'
```

If you are using pathogen, clone this repo to your `~/.vim/bundle`

## Current integrations:

### Functions/Commands
For the current buffer (including modifications not on disk)
- `:KubeApply`
- `:KubeDelete`
- `:KubeCreate`

And for the current directory (read from disk)
- `:KubeApplyDir`
- `:KubeDeleteDir`

If you would like to bind any of these to a shortcut, you can do something like
the following in your `~/.vimrc`:

```vim
au FileType yaml nmap <leader>r :KubeApply<CR>
```
