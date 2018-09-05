" dispatch.vim jobs strategy
scriptencoding utf-8

if has_key(g:, 'autoloaded_dispatch_jobs') | finish | endif

let g:autoloaded_dispatch_jobs = 1

let s:waiting = {}

function! dispatch#jobs#handle(request) abort
  if !(has('job') && has('channel') && a:request.action ==# 'make')
    return 0
  endif

  let l:channel_id = dispatch#jobs#_start_make_job(a:request)
  if empty(l:channel_id) | return 0 | endif

  let s:waiting[l:channel_id] = a:request
  return 1
endfunction

function! dispatch#jobs#_start_make_job(request) abort
  let l:command = dispatch#prepare_make(a:request)
  let l:job_options = {
        \ 'close_cb': function('dispatch#jobs#_close_callback'),
        \ 'exit_cb' : function('dispatch#jobs#_exit_callback'),
        \ 'out_io'  : 'pipe',
        \ 'err_io'  : 'out',
        \ 'in_io'   : 'null',
        \ 'out_mode': 'nl',
        \ 'err_mode': 'nl'}
  let l:job = job_start([&shell, &shellcmdflag, l:command], l:job_options)
  return dispatch#jobs#_channel_id(l:job)
endfunction

function! dispatch#jobs#_channel_id(job) abort
  if job_status(a:job) ==# 'fail'
    return ''
  endif

  let l:channel = job_getchannel(a:job)
  if string(l:channel) ==# 'channel fail'
    return ''
  endif

  let l:channel_info = ch_info(l:channel)
  return string(l:channel_info.id)
endfun

function! dispatch#jobs#_exit_callback(job, ...) abort
  let l:channel_id = dispatch#jobs#_channel_id(a:job)
  if has_key(s:waiting, l:channel_id)
    let l:request = remove(s:waiting, l:channel_id)
    call dispatch#complete(l:request)
  endif
endfun

function! dispatch#jobs#_close_callback(channel) abort
  " trigger vim calling s:ExitHandler()
  call job_status(ch_getjob(a:channel))
endfun
