" File:          gitcommit.vim
" Description:   Add JIRA issue ID to git commit messages

if exists('b:loaded_gitcommit_issue_id')
    finish
endif
let b:loaded_gitcommit_issue_id = 1

function! s:InsertIssueId()
  if getline(1) == ''
    let l:branch = system("git rev-parse --abbrev-ref HEAD")
    let l:match = matchlist(l:branch, '\v^([^/]+/)?(\a+-\d+)')
    if len(l:match) >= 3
      let l:branch_type = l:match[1] != '' ? substitute(l:match[1], '/$', ': ', '') : ''
      let l:issue_id = l:match[2]
      let b:commit_message_prefix = l:branch_type . l:issue_id . ':'
      call setline(1, b:commit_message_prefix . ' ')
      call feedkeys("\<End>")
    endif
  endif
endfunction

function! s:EnsureCommitMsg()
  if exists('b:commit_message_prefix') && match(getline(1), b:commit_message_prefix . '\s*$') != -1
    call setline(1, '')
    wq
  endif
endfunction

call s:InsertIssueId()

augroup gitcommit_issue_id
  autocmd BufUnload <buffer> call s:EnsureCommitMsg()
augroup END
