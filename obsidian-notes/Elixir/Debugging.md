
# Search the logs for crash stack-trace

When looking for crashes (in remote processes also), look for log line of type `error` with message starting with `** (`. In `less` search expression is:
```
error] \*\* \(
```

# Debugging the code

## pry
- Compile time change
- Aliases and imports are available
```
require IEx
IEx.pry()
```

##  IEx.break!
- Can be invoked in runtime without recompilation
- Aliases and imports are not available
- Look at `h IEx.break!`
```
break! BreakTest, :hello, 0, 2