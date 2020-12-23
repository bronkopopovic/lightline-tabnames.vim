if exists('g:loaded_lightline_tabnames')
  finish
endif
let g:loaded_lightline_tabnames = 1

let g:lightlineTabnames = []
let g:lightlineNone = 'none'
let g:lightlineNoname = get(g:, 'lightlineNoname', '[No Name]')

augroup lightlineTabnames
    au VimEnter * call LightlineTabnamesInit()
    au TabNewEntered * call LightlineTabnamesInsert(tabpagenr())
    au TabClosed * call LightlineTabnamesRemove(expand('<afile>'))
augroup END

command! -nargs=1 Tabname call LightlineTabnamesRename(<f-args>)

" Initialize tab global name array on vim startup
function! LightlineTabnamesInit() abort
    let i = 0
    while i < tabpagenr('$')
        call LightlineTabnamesAppend()
        let i += 1
    endwhile
endfunction

" Append an empty tab name to the global tab name array
function! LightlineTabnamesAppend() abort
    call add(g:lightlineTabnames, g:lightlineNone)
endfunction

" Add an empty tab name at a specified tab number
function! LightlineTabnamesInsert(tabnum) abort
    if a:tabnum == 1
        let g:lightlineTabnames = [g:lightlineNone] + g:lightlineTabnames
    elseif a:tabnum == len(g:lightlineTabnames) - 1
        let g:lightlineTabnames = g:lightlineTabnames + [g:lightlineNone]
    else
        let i = 0
        let names = []
        while i <= len(g:lightlineTabnames)
            if i < a:tabnum - 1
                call add(names, g:lightlineTabnames[i])
            elseif i == a:tabnum - 1
                call add(names, g:lightlineNone)
            else
                call add(names, g:lightlineTabnames[i-1])
            endif
            let i += 1
        endwhile
        let g:lightlineTabnames = names
    endif
endfunction

" Replace a tab name in the tab global tab name array
function! LightlineTabnamesReplace(tabnum, name) abort
    let g:lightlineTabnames[a:tabnum - 1] = a:name
endfunction

" Remove a tab name from the global tab name array
function! LightlineTabnamesRemove(tabnum) abort
    call remove(g:lightlineTabnames, a:tabnum - 1)
endfunction

" Rename the currently active tab
function! LightlineTabnamesRename(name) abort
    call LightlineTabnamesReplace(tabpagenr(), a:name)
    call lightline#toggle()
    call lightline#toggle()
endfunction

" Lightline function to render the tab names
function! LightlineTabnamesRender(n) abort
    let index = a:n - 1
    if g:lightlineTabnames[index] == g:lightlineNone
      let buflist = tabpagebuflist(a:n)
      let winnr = tabpagewinnr(a:n)
      let _ = expand('#'.buflist[winnr - 1].':t')
      return _ !=# '' ? _ : '[No Name]'
    else
      return g:lightlineTabnames[index]
    endif
endfunction
