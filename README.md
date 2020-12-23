## Tabnames for lightline.vim

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
