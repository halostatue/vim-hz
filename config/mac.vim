scriptencoding utf-8

if !hz#is#mac() | finish | endif

" Almost everything that applies to Unix configs applies here, too.
call hz#config#source('unix')
