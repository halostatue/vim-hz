scriptencoding utf-8

if !hz#is#plugged('leaderf') | finish | end

if hz#is#plugged('leaderf')
  nnoremap <silent><unique> <Leader>/ :<C-U>LeaderfHelp<CR>
  nnoremap <silent><unique> <Leader><Leader> :<C-U>LeaderfSelf<CR>

  if hz#is#plugged('leaderf-tjump')
    nnoremap [Space]<C-]> :<C-U>LeaderfTjump <C-R><C-W><CR>
  endif

  if hz#is#plugged('leaderf-github-stars')
    let g:gs#username='halostatue'
  endif

  let g:Lf_RecurseSubmodules = 1
endif
