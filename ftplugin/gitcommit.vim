" File:          gitcommit.vim
" Description:   Add JIRA issue ID to git commit messages

if exists('b:loaded_gitcommit_issue_id')
    finish
endif
let b:loaded_gitcommit_issue_id = 1

function! s:InsertIssueId()
  if getline(1) == ''
    let l:branch = system("git rev-parse --abbrev-ref HEAD")
    let b:issue_id = substitute(branch, '^\([^-]\+-\d\+\)*-*.*', '\1', '')
    if !empty(b:issue_id)
      call setline(1, b:issue_id . ': ')
      call feedkeys("\<End>")
    endif
  endif
endfunction

function! s:EnsureCommitMsg()
  if exists('b:issue_id') && getline(1) == b:issue_id . ': '
    cquit
  endif
endfunction

call s:InsertIssueId()

augroup gitcommit_issue_id
  autocmd BufUnload <buffer> call s:EnsureCommitMsg()
augroup END
