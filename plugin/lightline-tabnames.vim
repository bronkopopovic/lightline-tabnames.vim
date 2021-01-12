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
    au TabClosed * call remove(g:lightlineTabnames, expand('<afile>') - 1)
augroup END

command! -nargs=1 Tabname call LightlineTabnamesRename(<f-args>)

" Initialize tab global name array on vim startup
function! LightlineTabnamesInit() abort
    let i = 0
    while i < tabpagenr('$')
        call add(g:lightlineTabnames, g:lightlineNone)
        let i += 1
    endwhile
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

" Rename the currently active tab
function! LightlineTabnamesRename(name) abort
    let g:lightlineTabnames[tabpagenr() - 1] = a:name
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
