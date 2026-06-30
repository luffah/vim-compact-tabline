" compact_tabline.vim -- to have all tabs visibles
" @Author:      luffah (luffah AT runbox com)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2026-06-30
" @Last Change: 2026-06-30
" @Revision:    1

"@description
"Tabline is a practical view of edited buffers but when editing many files
"this become hard to read and many tabs can disappear from view.
"The idea of this plugin is to bring a simple solution to see all openned tabs

if !exists("+showtabline")
    finish
endif

"@global g:compact_tabline_name_substs
"List of [from, to] substitutions used to shorten tab name
"Default contains generic technical english terms.
let g:compact_tabline_name_substs = [
 \ ['\([-_.+]\)[-_.+]\+', '\1'],
 \ ['attribut[a-z]*', 'attr'],
 \ ['generat[a-z]*', 'gen'],
 \ ['migrat[a-z]*', 'mig'],
 \ ['spec[a-z]*', 'spec'],
 \ ['term[a-z]*', 'term'],
 \ ['inv[a-z]*', 'inv'],
 \ ['templat[a-z]*', 'tpl'],
 \ ['projec\?t', 'prj'],
 \ ['model[a-z]*', 'mdl'],
 \ ['change', 'chg'],
 \ ['website', 'web'],
 \ ['\(^\|[-_.+]\)view', 'V'],
 \ ['\(^\|[-_.+]\)test', 'T'],
 \ ['\(^\|[-_.+]\)report', 'R'],
 \ ['\(cloud\|carbon\)', 'C'],
 \ ['copy', 'cp'],
 \ ['right', 'rt'],
 \ ['left', 'lt'],
 \ ['next', 'nx'],
 \ ['prev[a-z]*', 'pv'],
 \ ['page', 'pg'],
 \ ['site', 'si'],
 \ ['\(point\|post\)', 'pt'],
 \ ['res[a-z]*', 'res'],
 \ ['input', 'in'],
 \ ['output', 'out'],
 \ ['view', 'v'],
 \ ['test', 't'],
 \ ['in\([-_.+]\|$\)', 'i\1'],
 \ ['out\([-_.+]\|$\)', 'o\1'],
 \ ['ing\([-_.+]\|$\)', 'g\1'],
 \ ['ion\([-_.+]\|$\)', 'n\1'],
 \ ['age\([-_.+]\|$\)', 'g\1'],
 \ ['ment\([-_.+]\|$\)', 't\1'],
 \ ['search', 'srch'],
 \ ['share', 'shr'],
 \ ['shop', 'shp'],
 \ ['doc[a-z]*', 'doc'],
 \ ['cat[a-z]*', 'cat'],
 \ ['part[a-z]*', 'part'],
 \ ['ticket', 'tkt'],
 \ ['tab[a-z]*', 'tab'],
 \ ['pub[a-z]*', 'pub'],
 \ ['cli[a-z]*', 'cli'],
 \ ['acc[a-z]*', 'acc'],
 \ ['ord[a-z]*', 'ord'],
 \ ['term', 'trm'],
 \ ['spec', 'sp'],
 \ ['bind', 'bd'],
 \ ['line', 'ln'],
 \ ['card', 'cd'],
 \ ['job', 'jb'],
 \ ['company', 'co'],
 \ ['product', 'pr'],
 \ ['sto[a-z]*', 'st'],
 \ ['pick[a-z]*', 'pk'],
 \ ['purch[a-z]*', 'pc'],
 \ ['sal[a-z]*', 'sl'],
 \ ['mov[a-z]*', 'mv'],
 \ ['\(^\|[-_.+]\)conn[a-z]*', '\1cn'],
 \ ['\(^\|[-_.+]\)contrac\?t[a-z]*', 'K'],
 \ ['tab', 't'],
 \ ['srch', 'S'],
 \ ['\(pay\|paid\|part\|pt\)', 'p'],
 \]

"@global g:compact_tabline_hi_tab
"Default highlight used to color an inactive tab (<color>). See |hi|
"Default: 'TabLine'
let g:compact_tabline_hi_tab = get(g:, 'compact_tabline_hi_tab', 'TabLine')

"@global g:compact_tabline_hi_current_tab
"Highlight used to color an active tab (<color>). See |hi|
"Default: 'TabLineSel'
"If you need a custom render for this define a new hi TablineSelCustom, 
"and don't forget to replace TabLineSel to TablineSelCustom in |g:compact_tabline_current_tab_format|
let g:compact_tabline_hi_current_tab = get(g:, 'compact_tabline_hi_current_tab', 'TabLineSel') 

"@global g:compact_tabline_hi_ft_prefix
"Highlight prefix to use for coloring an inactive tab with determined filetype (<color>).
"Default: 'TabLineFT'
"Example: TabLineFT  +  python  -> highlight TablineFTpython is used if exists
"Note: use :let b:tabline_hi to use a specific color
"See |hi|
let g:compact_tabline_hi_ft_prefix = get(g:, 'compact_tabline_hi_ft_prefix', 'TabLineFT') 

"@global g:compact_tabline_double_of_current_right_arrow
"When double tabs (same buffer) is detected the arrow to use to target a tab after current.
"Default: '⏵'
let g:compact_tabline_double_of_current_right_arrow = get(g:, 'compact_tabline_double_of_current_right_arrow', '⏵') 

"@global g:compact_tabline_double_of_current_left arrow
"When double tabs (same buffer) is detected the arrow to use to target a tab before current.
"Default: '⏴'
let g:compact_tabline_double_of_current_left_arrow = get(g:, 'compact_tabline_double_of_current_left_arrow', '⏴') 

"@global g:compact_tabline_tab_buffer_sep
"Separator to use between multiple buffer names in one tab 
"Default: '¦'
let g:compact_tabline_tab_buffer_sep = get(g:, 'compact_tabline_tab_buffer_sep', '¦') 

"@global g:compact_tabline_empty_buffer_name
"Name to use for an undefined buffer name.
"Default: '<bufnr><1stline>'
"See |compact_tabline#format|
let g:compact_tabline_empty_buffer_name = get(g:, 'compact_tabline_empty_buffer_name', '<bufnr><1stline>') 

"@global g:compact_tabline_line_start
"Define how starts the tabline.
"In order to optimize space, you have to define this with |g:compact_tabline_line_start_deco_width|
"Default: '%#TabLineFill#'
"See |compact_tabline#format|
let g:compact_tabline_line_start = get(g:, 'compact_tabline_line_start', '%#TabLineFill#') 

"@global g:compact_tabline_line_start_deco_width
"Tell the real visible width a the start part
"Default: 0
let g:compact_tabline_line_start_deco_width = get(g:, 'compact_tabline_line_start_deco_width', 0) 

"@global g:compact_tabline_line_start_addons
"A list of [<space_to_reserve>, lambda function] to add extra content at the start of line
let g:compact_tabline_line_start_addons = get(g:, 'compact_tabline_line_start_addons', []) 

"@global g:compact_tabline_line_end
"Define how ends the tabline.
"In order to optimize space, you have to define this with |g:compact_tabline_line_end_deco_width|
"Default: '%#TabLineFill#%<%='
let g:compact_tabline_line_end = get(g:, 'compact_tabline_line_end', '%#TabLineFill#%<%=') 
"@global g:compact_tabline_line_end_deco_width
"Default: 0
let g:compact_tabline_line_end_deco_width = get(g:, 'compact_tabline_line_end_deco_width', 0) 

"@global g:compact_tabline_line_end_addons
"A list of [<space_to_reserve>, lambda function] to add extra content at the end of line
let g:compact_tabline_line_end_addons = get(g:, 'compact_tabline_line_end_addons', []) 

"@global g:compact_tabline_tab_format
"Template for an inactive tab
"In order to optimize space, you have to define this with |g:compact_tabline_tab_deco_width|
"Default: '<color><tabnr><name>%#TabLineFill# '
"See |compact_tabline#format|
let g:compact_tabline_tab_format = get(g:, 'compact_tabline_tab_format', '<color><tabnr><name>%#TabLineFill# ')

"@global g:compact_tabline_tab_deco_width
"An estimation of space used by decorating elements (except name) in inactive tab.
"Default: 3
let g:compact_tabline_tab_deco_width = get(g:, 'compact_tabline_tab_deco_width', 3) 

"@global g:compact_tabline_current_tab_format
"Template for active tab
"In order to optimize space, you have to define this with |g:compact_tabline_current_tab_deco_width|
"Default: '%#TabLineSel# <name>▕<color>▒%#TabLineFill# '
"See |compact_tabline#format|
let g:compact_tabline_current_tab_format = get(g:, 'compact_tabline_current_tab_format', '%#TabLineSel# <name>▕<color>▒%#TabLineFill# ')

"@global g:compact_tabline_current_tab_deco_width
"An estimation of space used by decorating elements (except name) in inactive tab.
"Default: 4
let g:compact_tabline_current_tab_deco_width = get(g:, 'compact_tabline_current_tab_deco_width', 4) 

"@global g:compact_tabline_use_autoupdated_b_use
"**Used tab** is a tab with b:use=1.
"1 if b:use variable shall be used and autoupdated
"Default : 1
"This is automatically set when : you open or save the file or insert content.
"This state variable can be restored if you add '!' in shada. |shada-!|
let g:compact_tabline_use_autoupdated_b_use = get(g:, 'compact_tabline_use_autoupdated_b_use', 1) 

"@global g:compact_tabline_used_tab_content_minwidth
"Minimum width of the content of an used tab.
"See |Used tab|.
"Default: 2
let g:compact_tabline_used_tab_content_minwidth = get(g:, 'compact_tabline_used_tab_content_minwidth', 2) 

"@global g:compact_tabline_used_tab_content_maxwidth
"Maximum width of the content of an used tab.
"See |Used tab|.
"Default: 24
let g:compact_tabline_used_tab_content_maxwidth = get(g:, 'compact_tabline_used_tab_content_maxwidth', 24) 

"@global g:compact_tabline_unused_tab_content_width
"Minimum width of the content of an unused tab.
"See |Used tab|.
"Default: 1
let g:compact_tabline_unused_tab_content_width = get(g:, 'compact_tabline_unused_tab_content_width', 1) 

"@global g:compact_tabline_unused_tab_content_maxwidth
"Maximum width of the content of an unused tab.
"See |Used tab|.
"Default: 2
let g:compact_tabline_unused_tab_content_maxwidth = get(g:, 'compact_tabline_unused_tab_content_maxwidth', 2)  " used if there is space left in tabline


"@function compact_tabline#format(fstring, name, color, tab, curtab, buf, curbuf)
"Function that replace special words with their value:
" - <name>       : short file name
" - <color>      : highlight color (take no space)
" - <1stline>    : first line of the buffer
" - <tabnr>      : tab number in superscript style
" - <cur_tabnr>  : active tab number in superscript style
" - <bufnr>      : buf number in subscript style
" - <cur_bufnr>  : active buf number in subscript style
function! compact_tabline#format(in, name, color, tab, curtab, buf, curbuf)
    let l:in = substitute(substitute(a:in, '<name>', a:name, ''), '<color>', a:color, 'g')
    if l:in =~ '<1stline>'
        let l:in = substitute(l:in, '<1stline>', getbufline(a:buf, 1)[0], '')
    endif
    if l:in =~ '<tabnr>'
        let l:in = substitute(l:in, '<tabnr>', s:numtosmallchar(a:tab, 0, 1), '')
    endif
    if l:in =~ '<cur_tabnr>'
        let l:in = substitute(l:in, '<cur_tabnr>', s:numtosmallchar(a:curtab, 0, 1), '')
    endif
    if l:in =~ '<bufnr>'
        let l:in = substitute(l:in, '<bufnr>', s:numtosmallchar(a:buf, 0, 0), '')
    endif
    if l:in =~ '<cur_bufnr>'
        let l:in = substitute(l:in, '<cur_bufnr>', s:numtosmallchar(a:curbuf, 0, 0), '')
    endif
    return l:in
endfu

function! compact_tabline#ShortFilename(bufnr, n, maxchr, active)
    let l:n = fnamemodify(a:n, ':t')
    if l:n =~ '^\d\+\(\.[a-z]\{1,4\}\)\?$' && a:n =~ '/.*/'
        let l:n = split(a:n, '/')[-2] .'/'. l:n
    endif
    if l:n == ''
        return ''
    elseif len(l:n) > a:maxchr
        let l:n = substitute(l:n, '\.[a-zA-Z0-9]\+$', '', '') 
        for l:i in g:compact_tabline_name_substs
            if len(l:n) <= a:maxchr
                break
            endif
            let l:n = substitute(l:n, l:i[0], l:i[1],'g')
        endfor
        let l:sep = ''
        if l:n =~ '_'
            let l:sep = '_'
        elseif l:n =~ '-'
            let l:sep = '-'
        elseif l:n =~ '.*\..*\.'
            let l:sep = '.'
        endif

        if len(l:sep)
            let l:spl = split(l:n, escape(l:sep, '.'))
            let l:idxs = range(len(l:spl))
            let l:len = len(l:n)
            if l:n =~ '\d'
                if l:len > a:maxchr
                    let l:len = 0
                    for l:i in l:idxs
                        let l:spl[l:i] = substitute(l:spl[l:i], '^\([a-zA-Z]\{3\}\)[^0-9]\+\([0-9]*\).*', '\1\2', '')
                        let l:len = 1 + len(l:spl[l:i])
                    endfor
                endif
                if l:len > a:maxchr
                    let l:len = 0
                    for l:i in l:idxs
                        let l:spl[l:i] = substitute(l:spl[l:i], '^\([a-zA-Z]\)[^0-9]*\([0-9]\+\).*', '\1\2', '')
                        let l:len = 1 + len(l:spl[l:i])
                    endfor
                endif
            endif
            if l:len > a:maxchr
                let l:lendiff=l:len - a:maxchr
                for l:wdth in [3, 2, 1]
                    if l:lendiff <= 0
                        break
                    endif
                    for l:i in l:idxs
                        if l:lendiff <= 0
                            break
                        endif
                        let l:len = 0
                        let l:bef= 1 + len(l:spl[l:i])
                        let l:spl[l:i] = substitute(l:spl[l:i], '\([a-zA-Z]\{'.l:wdth.'\}\).*', '\1', '')
                        let l:len = 1 + len(l:spl[l:i])
                        let l:lendiff -= (l:bef - l:len)
                    endfor
                endfor
            endif
            let l:n = join(l:spl, l:sep)
            if len(l:n) > a:maxchr
                let l:n = join(l:spl, '')
            endif
        endif
    endif
    return l:n
endfu

function! s:gettabinfo(tab, curtab, curbuf, orig_tabbuf, maxchr)
    let l:buflist = tabpagebuflist(a:tab)
    let l:winnr = tabpagewinnr(a:tab)
    let l:names = []
    let l:color =''
    let l:maxchr = a:maxchr
    let l:active = (a:curtab == a:tab)
    let l:curbufdirection = 0
    if l:active
        if len(l:buflist) > 1
            let l:bidx = index(l:buflist, a:curbuf)
            let l:curbufdirection = l:bidx > 0 ? 1 : -1
        endif
        let l:buflist = [a:curbuf]
    else
        let l:maxchr=max([(a:maxchr / len(buflist)), 0]) 
    endif
    for l:bufnr in l:buflist
        let l:hi = getbufvar(l:bufnr, 'tabline_hi')
        let l:ft = getbufvar(l:bufnr, '&ft')
        let l:bactive = (l:bufnr == a:curbuf)
        if len(l:hi)
            let l:color = '%#'.l:hi.'#'
        else
            let l:hlid = g:compact_tabline_hi_ft_prefix.l:ft
            if !hlID(l:hlid)
                let l:hlid = g:compact_tabline_hi_tab
            endif
            let l:color = '%#'.l:hlid.'#'
        endif

        let l:orig_tabbuf_nr = get(a:orig_tabbuf, l:bufnr, -1)
        if l:orig_tabbuf_nr == -1
            let a:orig_tabbuf[l:bufnr] = a:tab
        else
            if ! l:active
                if l:bactive
                    let l:color='%#'.g:compact_tabline_hi_current_tab.'#'
                endif
                if l:bactive && l:maxchr > 0
                    let l:dch = g:compact_tabline_double_of_current_left_arrow
                    if l:bactive && a:curtab > a:tab 
                        let l:dch = g:compact_tabline_double_of_current_right_arrow
                    endif
                    let l:file = l:dch . (l:maxchr > 1 ? ' ': '')
                    call add(l:names, l:file . '')
                else
                    call add(l:names, '')
                endif
                continue
            endif
        endif
        let l:file = bufname(l:bufnr)
        if l:file == ''
            let l:file = bufname(l:buflist[0])
        endif
        let l:file = compact_tabline#ShortFilename(l:bufnr, l:file, l:maxchr, l:active)
        if l:file == ''
            let l:file = compact_tabline#format(g:compact_tabline_empty_buffer_name, '', '', a:tab, a:curtab, l:bufnr, a:curbuf)
        endif
        let l:file = join(split(l:file, '\zs')[0:a:maxchr-1], '')
        if l:curbufdirection == -1
            let l:file = l:file.g:compact_tabline_tab_buffer_sep
        elseif l:curbufdirection == 1
            let l:file = g:compact_tabline_tab_buffer_sep.l:file
        endif
        call add(l:names, l:file . repeat(' ', l:maxchr - len(split(l:file, '\zs'))))
    endfor
    return [join(l:names, g:compact_tabline_tab_buffer_sep), l:color, l:buflist]
endfu

function! s:numtosmallchar(i, r, s)  " number, align_right, superscript
    if a:s
        let l:map = ['⁰','¹','²','³','⁴','⁵','⁶','⁷','⁸','⁹']
    else
        let l:map = ['₀','₁','₂','₃','₄','₅','₆','₇','₈','₉']
    endif
    let l:dec = a:i / 10
    if (l:dec > 0)
        return get(l:map, l:dec, l:dec). get(l:map, a:i % 10, a:i)
    endif
    if a:r
        return ' '.get(l:map, a:i, a:i)
    endif
    return get(l:map, a:i, a:i).' '
endfunction

if g:compact_tabline_use_autoupdated_b_use
    " require shada to contain '!'
    fu! s:store_used_buffers()
        let g:COMPACT_TABLINE_STORE_USED_BUFFERS_FOR_STARTUP = []
        for l:i in range(1, tabpagenr('$'))
            let l:bufnr = tabpagebuflist(l:i)[0]
            if getbufvar(tabpagebuflist(l:i)[0], 'use', 0)
                call add(g:COMPACT_TABLINE_STORE_USED_BUFFERS_FOR_STARTUP, l:bufnr)
            endif
        endfor
    endfu
    fu! s:restore_used_buffers()
        if exists('g:COMPACT_TABLINE_STORE_USED_BUFFERS_FOR_STARTUP')
            for l:bufnr in g:COMPACT_TABLINE_STORE_USED_BUFFERS_FOR_STARTUP
                call setbufvar(l:bufnr, 'use', 1)
            endfor
            unlet g:COMPACT_TABLINE_STORE_USED_BUFFERS_FOR_STARTUP
        endif
    endfu
    augroup compact_tabline_bufusage
        au!
        au CursorHold,InsertLeave,BufWritePre,BufRead * if ! exists('SessionLoad') | let b:use = 1 | redrawtabline | endif
        au VimLeavePre * call s:store_used_buffers()
    augroup END
endif

function! compact_tabline#TabLine()
    let l:curtab = tabpagenr()
    let l:b = bufnr('%')
    let l:max = tabpagenr('$')
    let l:curbuf = bufnr()
    let l:s = ''
    let l:orig_tabbuf = {l:curbuf : l:curtab}
    let l:spaceleft = &columns - g:compact_tabline_line_start_deco_width - g:compact_tabline_tab_deco_width
    for l:lambda in g:compact_tabline_line_start_addons
        let l:s .= l:lambda[1]()
        let l:spaceleft -= l:lambda[0]
    endfor
    for l:lambda in g:compact_tabline_line_end_addons
        let l:spaceleft -= l:lambda[0]
    endfor
    let l:deco_width = g:compact_tabline_tab_deco_width
    let l:active_deco_width = g:compact_tabline_current_tab_deco_width
    let l:active_deco_width_add = l:active_deco_width-l:deco_width
    let l:tabline_used_tab_minwidth = g:compact_tabline_tab_deco_width + g:compact_tabline_used_tab_content_minwidth
    let l:tabline_used_tab_maxwidth = g:compact_tabline_tab_deco_width + g:compact_tabline_used_tab_content_maxwidth
    let l:tabline_unused_tab_maxwidth = g:compact_tabline_tab_deco_width + g:compact_tabline_unused_tab_content_maxwidth
    let l:tabline_unused_tab_width = g:compact_tabline_tab_deco_width + g:compact_tabline_unused_tab_content_width
    let l:curname = ''
    let l:active_todo = 1
    if g:compact_tabline_use_autoupdated_b_use
        call s:restore_used_buffers()
        let l:used = 0
        let l:unused = 0
        let l:used_tab = {}
        for l:i in range(1, l:max)
            if getbufvar(tabpagebuflist(l:i)[0], 'use', 0) || (l:i == l:curtab)
                let l:used_tab[l:i] = 1
                let l:used += 1
            else
                let l:used_tab[l:i] = 0
                let l:unused += 1
            endif
        endfor
    else
        let l:unused = 0
        let l:used = l:max
    endif
    let l:unused_maxchr = l:tabline_unused_tab_width
    if  float2nr(round((l:spaceleft-(l:active_deco_width)-(l:unused*l:unused_maxchr))/l:used)) >  l:tabline_used_tab_maxwidth
        let l:unused_maxchr = l:tabline_unused_tab_maxwidth
    endif
    let l:used_maxchr = max([
                \ l:tabline_used_tab_minwidth,
                \ min([
                \   float2nr(round((l:spaceleft-(l:active_deco_width)-(l:unused*l:unused_maxchr))/l:used)),
                \   l:tabline_used_tab_maxwidth
                \     ])
                \ ])
    for l:i in range(1, l:max)
        let l:active = (l:i == l:curtab)
        let l:is_used = g:compact_tabline_use_autoupdated_b_use ? ( l:used_tab[l:i] || l:active ) : 1
        if l:is_used
            let l:used -= 1
        else
            let l:unused -= 1
        endif
        let l:maxchr = l:is_used ? l:used_maxchr : l:unused_maxchr
        if l:active
            let l:active_todo = 0
            let l:cute_width = g:compact_tabline_current_tab_deco_width
            let l:cute_format = g:compact_tabline_current_tab_format
            let l:maxchr += l:active_deco_width_add
        else
            let l:cute_width = g:compact_tabline_tab_deco_width
            let l:cute_format = g:compact_tabline_tab_format
        endif 
        if l:is_used && l:spaceleft > ((l:active_todo?l:active_deco_width:0) + l:used*l:used_maxchr + l:unused*l:unused_maxchr)
            let l:maxchr += 1
        endif
        let l:info = s:gettabinfo(l:i, l:curtab, l:curbuf, l:orig_tabbuf, l:maxchr - l:cute_width)
        let l:file = l:info[0]
        let l:color = l:info[1]
        if l:active
            let l:curname = l:file
            let l:curcolor = l:color
        endif
        let l:spaceleft -= (len(l:file) + l:cute_width)
        let l:s .= compact_tabline#format(l:cute_format, l:file, l:color, l:i, l:curtab, l:info[2][0], l:curbuf)
    endfor
    let l:s = compact_tabline#format(g:compact_tabline_line_start, l:curname, l:curcolor, l:curtab, l:curtab, l:curbuf, l:curbuf) 
                \ . l:s
                \ . compact_tabline#format(g:compact_tabline_line_end, l:curname, l:curcolor, l:curtab, l:curtab, l:curbuf, l:curbuf)
    for l:lambda in g:compact_tabline_line_end_addons
        let l:s .= l:lambda[1]()
    endfor
    return l:s
endfunction
set showtabline=2
set tabline=%!compact_tabline#TabLine()
