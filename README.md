# vim-gitcommit-issue-id
Add issue ID to commit messages

This plugin extracts e.g. JIRA issue ID from branch names and adds it as a prefix to the commit message.

Some example branch names and generated prefixes:

| Branch Name             | Generated Prefix   |
|-------------------------|--------------------|
| `branch-without-id`     |         |
| `FOO-123`               | `FOO-123: `        |
| `FOO-123-bar`           | `FOO-123: `        |
| `fix/FOO-123/bar`       | `fix: FOO-123: `   |
| `chore/FOO-123/upgrade` | `chore: FOO-123: ` |