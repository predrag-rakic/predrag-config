## Intro
Evented from user perspective:
- What is it
- Design goals
- Usage
- Road map
- Questions
	
## What is Evented	
- Name comes Commanded
	- On top of which it is built
  - Removes commands from the picture (or at least marginalizes them)
- DSL

## Design goals
- Based on Commanded
- Boilerplate generation (user-friendly)
- Does the common thing for you if you want it, but not in your way if you don't
- Makes it easy to model processing flow as a sequence of check-pointed actions/handlers
	- Which is a FSM
- Documentation generation (TBD)

## Requirements
- Each handler has to be retry-able
	- Otherwise, you might get surprised in edge-case situations

## Usage
(show example)
- Hybrid handler: generate logic around aggregate
- Evented app: 
	- generate Commanded application: command routing
	- generates supervisor for Commanded app and process managers

## Road map
- Stop using AST – replace it with EEx
	- Ability to see what is generated
- Create Mix compiler
	- Execute before Elixir compiler
- Add list of allowed output events to Evented handler definition
- Generate documentation
	- sequence of handlers
	- sequence of events
	- inter-aggregate event exchange within the Evented app
	- Maybe event exchange between different Evented apps

## Questions?