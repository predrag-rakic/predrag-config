# Evented - Event Sourcing without Commands

## Introduction

## Events and commands

Traditionally there is clear differentiation between commands and events. Commands represent the intention to do something. Events represent the fact (that something happened) in the past.
So, there is obvious causal relationship between a command and event (or set of events) generated because of the command. If we move a step back and look at the bigger picture, there is also causal relationship between some event and any particular command.
There is circular causal relationship between commands and events: command causes event and that event in turn causes some other command which causes next event and so on…

### Handling of Events and Commands

Only the events are (ever) lasting. Commands are volatile ???? (continue)

## Concept
We decided to abstract away command part totaly from the model available to the user and ???(to be continued...)