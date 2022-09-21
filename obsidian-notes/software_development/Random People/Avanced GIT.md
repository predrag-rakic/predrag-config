https://betterprogramming.pub/8-advanced-git-commands-university-wont-teach-you-fe63b483d34b

### Searching
```
$ git rev-list --all | xargs git grep -F ‘’
```

### Clean up local branches
Remove local already removed from remote repository:
```
git config --global fetch.prune true
```

Remove merged branches
```
git branch --merged master | grep -v "master" | xargs -n 1 git branch -d
```