""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Initialize variables

let s:NVIM                = has('gui_running') || has('nvim')

let b:VM_Selection        = {}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Custom variables
"NOT YET: sublime_mappings

call vm#plugs#init()
let g:VM                                  = {'is_active': 0, 'extend_mode': 0, 'motions_enabled': 0}

let g:VM.default_mappings                 = get(g:VM, 'default_mappings', 1)
let g:VM.motions_at_start                 = get(g:VM, 'motions_at_start', 1)
let g:VM.cursors_skip_shorter_lines       = get(g:VM, 'cursors_skip_shorter_lines', 1)

let g:VM.custom_noremaps                  = get(g:VM, 'custom_noremaps', {',': ';', ';': ','})
let g:VM.custom_remaps                    = get(g:VM, 'custom_remaps', [])
let g:VM.extend_by_default                = get(g:VM, 'extend_by_default', 0)
let g:VM.sublime_mappings                 = get(g:VM, 'sublime_mappings', 1)
let g:VM.custom_mappings                  = get(g:VM, 'custom_mappings', 0)
let g:VM.keep_collapsed_while_moving_back = get(g:VM, 'keep_collapsed_while_moving_back', 1)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set up highlighting

let g:VM_Selection_hl                     = get(g:, 'VM_Selection_hl',     'Visual')
let g:VM_Mono_Cursor_hl                   = get(g:, 'VM_Mono_Cursor_hl',   'DiffChange')
let g:VM_Normal_Cursor_hl                 = get(g:, 'VM_Normal_Cursor_hl', 'DiffAdd')
let g:VM_Message_hl                       = get(g:, 'VM_Message_hl',       'WarningMsg')

exe "highlight link MultiCursor ".g:VM_Normal_Cursor_hl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Global mappings

if g:VM.sublime_mappings
    nmap <silent> <M-C-Down>  <Plug>(VM-Select-Down)
    nmap <silent> <M-C-Up>    <Plug>(VM-Select-Up)
    nmap <silent> <S-Right>   <Plug>(VM-Motion-l)
    nmap <silent> <S-Left>    <Plug>(VM-Motion-h)
    nmap <silent> <C-S-Right> <Plug>(VM-Motion-w)
    nmap <silent> <C-S-Left>  <Plug>(VM-Motion-b)
    nmap <silent> <M-C-Right> <Plug>(VM-Motion-E)
    nmap <silent> <M-C-Left>  <Plug>(VM-Fast-Back)
endif

if g:VM.default_mappings
    nmap <silent> g<space>   <Plug>(VM-Add-Cursor-At-Pos)
    nmap <silent> g<cr>      <Plug>(VM-Add-Cursor-At-Word)

    nmap <silent> <M-A>      <Plug>(VM-Select-All)
    xmap <silent> <M-A>      <Plug>(VM-Select-All)
    nmap <silent> <M-j>      <Plug>(VM-Add-Cursor-Down)
    nmap <silent> <M-k>      <Plug>(VM-Add-Cursor-Up)

    nmap <silent> s]         <Plug>(VM-Find-I-Word)
    nmap <silent> s[         <Plug>(VM-Find-A-Word)
    nmap <silent> s}         <Plug>(VM-Find-I-Whole-Word)
    nmap <silent> s{         <Plug>(VM-Find-A-Whole-Word)
    xmap <silent> s]         <Plug>(VM-Find-A-Subword)
    xmap <silent> s[         <Plug>(VM-Find-A-Whole-Subword)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup plugin-visual-multi-global
    au!
    au BufLeave    * call s:buffer_leave()
    au BufEnter    * call s:buffer_enter()
augroup END

fun! s:buffer_leave()
    if !empty(get(b:, 'VM_Selection', {}))
        call vm#funcs#reset(1)
    endif
endfun

fun! s:buffer_enter()
    let b:VM_Selection = {}
endfun

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

