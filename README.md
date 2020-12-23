## Tabnames for lightline.vim

The *lightline-tabnames* plugin extends [lightline.vim](https://github.com/itchyny/lightline.vim)
by itchyny and adds a tab name functionality. New tabs will be initialized with default lightline
behaviour. Tabs can be renamed with a command.

#### Installation

Use a Plugin manager e.g. vim-plug:

1. Add the following configuration to your `.vimrc`.

```
Plug 'bronkopopovic/lightline-tabnames.vim'
```

2. Install with `:PlugInstall`.

#### Configuration

Add the following to your `g:lightline` configuration:

```
'tab_component_function': {
\   'name': 'LightlineTabnamesRender',
\ }
```

Then modify the `g.lightline.tab` configuration and e.g. replace "filename"
with "name":

```
let g:lightline.tab = {
  \ 'active': [ 'tabnum', 'name', 'modified' ],
  \ 'inactive': [ 'tabnum', 'name', 'modified' ]
\ }
```

You can also modify the default name for a tab with an empty buffer by setting:

```
let g:lightlineNoname = '[Empty Tab]'
```

#### Usage

Use the `Tabname <name>` command to rename the current tab.
