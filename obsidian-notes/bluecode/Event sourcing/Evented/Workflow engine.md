I believe that Evented is best described as "workflow engine".
There is a closed, self contained system within Evented application, defined by aggregates and mutation handlers, with strong boundaries between that system and the rest of the world.

From physics perspective:
Initially, system is in "stable state" - no processing.
That is lowest energy (and as such most desirable) state of the system.
Injected event introduces "disturbance" in the system - moves the system out of equilibrium.
Handlers are invoked to stabilize the system, to bring it back to lowest energy state in which there is no handling activity.

Things happening outside Evented application have absolutely no effect on it.
If outside world is to make causal effect on Evented system, it has to inject event into the system.
That can be done only through particular gate - one of the function from "inject_event" family.
  

From that perspective, protocol (RPC vs REST vs Websocket) and consequences of it, is something happening outside the boundary of Evented system and as such irrelevant to the system and Evented library itself.
From that perspective Evented is protocol agnostic.