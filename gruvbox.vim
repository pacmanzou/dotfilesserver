function! crystalline#theme#gruvbox#set_theme() abort
    call crystalline#generate_theme({
          \ 'NormalMode':  [[246, 239], ['#EBDBB2', '#45413b']],
          \ 'InsertMode':  [[235, 109], ['#8be9fd', '#282828']],
          \ 'VisualMode':  [[235, 208], ['#FAD000', '#282828']],
          \ 'ReplaceMode': [[235, 108], ['#00FF00', '#282828']],
          \ '':            [[246, 239], ['#EBDBB2', '#45413b']],
          \ 'Inactive':    [[246, 239], ['#EBDBB2', '#45413b']],
          \ 'Fill':        [[246, 239], ['#EBDBB2', '#45413b']],
          \ 'Tab':         [[246, 239], ['#a89984', '#504945']],
          \ 'TabType':     [[246, 239], ['#EBDBB2', '#45413b']],
          \ 'TabSel':      [[235, 246], ['#282828', '#a89984']],
          \ 'TabFill':     [[235, 235], ['#00FFFFFF', '#00FFFFFF']],
          \ })
endfunction

" vim:set et sw=2 ts=2 fdm=marker:
