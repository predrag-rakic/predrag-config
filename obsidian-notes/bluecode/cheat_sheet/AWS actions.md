 ## List GitHub Actions caches for a repository
```
curl \
-H "Accept: application/vnd.github+json" \
-H "Authorization: Bearer <TOKEN>"\
-H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/bluecodecom/scheme-services/actions/caches
```
  
  
## Delete GitHub Actions caches for a repository (using a cache key)  
```
curl \
-X DELETE \
-H "Accept: application/vnd.github+json" \
-H "Authorization: Bearer <TOKEN>"\
-H "X-GitHub-Api-Version: 2022-11-28" \
https://api.github.com/repos/bluecodecom/scheme-services/actions/caches?key=Linux-test-deps-863151680f17ebcfe92223b428f9e8ae40d0aee9234bc2876e0229f3f42d04e2
```