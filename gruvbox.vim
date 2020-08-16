function! crystalline#theme#gruvbox#set_theme() abort
    call crystalline#generate_theme({
          \ 'NormalMode':  [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'VisualMode':  [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'InsertMode':  [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'ReplaceMode': [[246, 239], ['#EBDBB2', '#3c3836']],
          \ '':            [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'Inactive':    [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'Fill':        [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'Tab':         [[246, 239], ['#a89984', '#504945']],
          \ 'TabType':     [[246, 239], ['#EBDBB2', '#3c3836']],
          \ 'TabSel':      [[235, 246], ['#282828', '#a89984']],
          \ 'TabFill':     [[235, 235], ['#00FFFFFF', '#00FFFFFF']],
          \ })
endfunction

" vim:set et sw=2 ts=2 fdm=marker:
