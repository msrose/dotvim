function! GetHighlight(group)
  let output = execute('hi ' . a:group)
  let parts = split(output, '\s\+')
  let colorvals = {}
  for item in parts
    if match(item, '=') > 0
      let [type, colorval] = split(item, '=')
      let colorvals[type] = colorval
    endif
  endfor
  return colorvals
endfunction

function! MatchHighlight(group, group_to_match, colortypes)
  let l:linenr_hl = GetHighlight(a:group_to_match)
  let l:normal_hl = GetHighlight('Normal')
  for colortype in a:colortypes
    execute 'highlight ' . a:group . ' ' . colortype . '=' . get(l:linenr_hl, colortype, get(l:normal_hl, colortype, 'black'))
  endfor
endfunction

function! StripTrailingWhitespace()
  if exists('b:no_strip_whitespace')
    return
  endif
  %s/\s\+$//e
endfunction

function! QuickfixToggle()
  let nr = winnr('$')
  cwindow
  let nr2 = winnr('$')
  if nr == nr2
    cclose
  endif
endfunction

function! LinterStatus() abort
  if !PluginsInstalled()
    return 'NOALE'
  endif
  let counts = ale#statusline#Count(bufnr(''))
  let errors = counts.error + counts.style_error
  let warnings = counts.total - errors
  let status_string = 'Errors: %d, Warnings: %d'
  return counts.total == 0 ? '' : printf(status_string, errors, warnings)
endfunction

function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

function! PluginsInstalled()
  return isdirectory("plugged")
endfunction
