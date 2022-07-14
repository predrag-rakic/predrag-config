# Evented from user perspective
(user here is developer (user of the library), not library maintainer)

## Agenda
- What is it
- Design goals
- Usage
- Road map
- How
- Questions
	
## What is Evented	
- Name comes Commanded
	- On top of which it is built
  - Removes commands from the picture (or at least marginalizes them), what is left are events
- DSL

## Design goals
- Based on Commanded
- Boilerplate generation (user-friendly)
- Does the common thing for you if you want it, but not in your way if you don't
- Makes it easy to model processing flow as a sequence of check-pointed actions/handlers
	- Which is a FSM
- Documentation generation (TBD)

## Usage
(show example)
- Hybrid handler
	- in desperate need for better name 
		- (evented-handler not good, easily confused with event-handler)
	- generate logic around aggregate
- Evented app: 
	- generate Commanded application: command routing
	- generates supervisor for Commanded app and process managers

### Requirements
- Each handler has to be retry-able
	- Otherwise, you might get surprised in edge-case situations
	- This is not Evented specific. 
	    It applies to any resilient system (can sustain transitional failures).
## Road map
- Add list of allowed output events to Evented handler clause definition
- Generate documentation
	- Sequence of handlers
	- Sequence of events
	- Inter-aggregate event exchange within the Evented app
	- Maybe, event exchange between different Evented apps
- Stop using AST – replace it with EEx
	- Generate `.ex` files
	- Ability to see what is generated
- Place Evented definitions in files with different extensions (for example: `.ev`)
- Create Evented transpiler - Mix compiler 
	- Execute before Elixir compiler
- Maybe event-proxy: 
	- Import/export events from/to Red Panda

## How
- Evented hybrid handler generates:
	- commands
	- router
	- command handler
	- process manager
- Evented application generates
	- Commanded application
	- Supervisor to supervise Commanded application and all process managers
- Documentation: 
	- We'll see, depending what turns out to be useful

## Questions?