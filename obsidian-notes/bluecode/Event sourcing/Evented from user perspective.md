# Evented from user perspective
(user here is developer - user of the library)


## Context
Architectural decisions:
- Event-based system 
- Hierarchical event space
- Application based on Commanded and Event-store (persistence in PostgreSQL)

### Event space
Current architectural agreement is that event space is not flat.
It is hierarchical.
Currently, there are two levels of hierarchy:
- Public events: content of Red Panda
- Local events: application (or group of applications) specific
	- There is nothing preventing us from splitting local events space into multiple (flat or hierarchical) sub-spaces.
	- For example: scheme-services parent space, containing TS and PGW sub-spaces.

## Rationale to make Evented
- Data processing checkpoints
- Boilerplate code generation

### Data processing with checkpoints
Data processing flow consists of a sequence of steps.
After each step, a checkpoint is generated. 
It provides the ability to resume processing from the last checkpoint, in case of interruption (crash).
Checkpoint is an event.

Theoretically, any event-based system inherently supports a checkpoint mechanism.
There is a guarantee that if event handling fails, it will be retried.

But in order to generate a sequence of handlers, each of which will generate an event (as a result of processing) to invoke the next handler in sequence. And to have all that in a user-friendly way, a lot more has to be done. 

### Boilerplate code generation
Boilerplate code:
- Handlers around each aggregate 
- Application and supervisor




### Event store/broker 

But only event-store provides a fine-grained **consistency boundary** (aggregate) that fits perfectly on BEAM process model.
And Elixir library on top of event-store that seems reasonably popular is Commanded.





===== cut ===
An event-based system inherently supports a audit mechanism: in order to advance processing, an event has to be emitted.

One might assume that it also inherently supports a checkpoint mechanism, but that's not necessarily true in any event-based system. One has to work to make that true.
Commanded provides such guaranties, but not in user-friendly way.

=========

### Minor benefits
  - Difference between commands and events? 
		- There are no commands any more -> issue solved
