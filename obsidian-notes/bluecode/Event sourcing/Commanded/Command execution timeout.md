## Command execution timeout semantic
From Commanded [docs](https://github.com/commanded/commanded/blob/master/guides/Commands.md#command-handlers) :
> Command handlers execute in the context of the dispatch call, as such they are limited to the timeout period specified...

That statement is false.

Commanded has timeout associated with command execution, that is true.
By default, it is set to 5 seconds, that is also true.
When command processing takes longer than expected, command dispatch-call returns :aggregate_execution_timeout, consistent with the docs.
But aggregate:
- continues execution of the "timed-out" command handler indefinitely and
- can even persist events at the end of the processing (that supposedly timed-out).

Which means that command handlers are **not** limited to the timeout period specified.
I find this semantic confusing and misleading (on its own, regardless of the docs).

What happens when command-initiator receives :aggregate_execution_timeout?
It initiates retry, at least once,to try to overcome transient issues.
But "initial processing" still executes in the aggregate and this "retry" command will be executed only after ongoing processing finishes (and all other commands dispatched in between).
"Initial processing" can persist events and after that the "retry processing" can persist its own events, which will almost certainly cause bugs.

I see no mechanism to deal with this issue, except to set timeout to :infinity (which defeats the purpose of timeout).