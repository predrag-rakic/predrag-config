## On local machine
maybe 
sudo tailscale up


## On remote machine
### When it is created
Add to `/workspaces/mana (main ✗) $ vi .envrc`
```
export LOCAL_WORKSPACE_FOLDER=/var/lib/docker/codespacemount/workspace/mana
```

Change `BC_DEV_DOMAIN` for each codespace so that they do not colide
```
/workspaces/mana (main ✗) $ cat .envrc.local 
export BC_USER="ppp"
export BC_DEV_DOMAIN="$BC_USER.bloomco.de"
```

### On every execution
```bash
cd /workspaces/mana
./setup.sh
docker-compose up -d
```

ssh to mana (use GitHub CLI):
```
gh cs ssh 
```

- tmux
- mc

### From time to time
