## Resources
[https://hexdocs.pm/commanded/Commanded.html](https://hexdocs.pm/commanded/Commanded.html)

## High Availability expectations and processing-flow

Failure handling/High availability concerns in Elixir/Erlang are addressed with crashes and restarts. 
Events fit nicely in the concept.

So, if we want to build the system that gracefully handles failures and is highly available, we need to:
- implement processing flow as sequence of idempotent actions 
- persist check-point after each "idempotent action" 
  - so that (in case of failure) processing can  be continued from that point



I'm talking about failure handling together with HA because mechanism to handle both are the same: crash and restart from last check-point.
HA issues can be thought of as failures of the whole node, for example because of redeployment, EC2 terminating instance, network split, AZ unavailability, ...

### Commanded sourcing in light of check-pointing and process continuation

In Commanded, each "idempotent action" needs to be implemented as separate command-handler.
Output of command-handler is event (or sequence of events) representing processing check-point.
The system will on its own:
- persist event(s)
- initiate event(s) handling
  - including re-initiating event handling for all failed handler executions 

What we need to do is design processing flow so that it consists of:
- command handlers
  - which execute idempotent parts of business logic
- process managers
  - which glue together parts of business logic onto useful sequence

Basically CH (command handler) and PM (process manager) play ping-pong:
- CH receives command_1 and issues event_1
- PM receives event_1 and dispatches command_2
- CH receives command_2 and issues event_2
- ...

If for whatever reason, processing is interrupted, it is automatically continued after timeout (5 sec by default), from the last persisted and not handled event (event whose processing is not acknowledged by PM).
