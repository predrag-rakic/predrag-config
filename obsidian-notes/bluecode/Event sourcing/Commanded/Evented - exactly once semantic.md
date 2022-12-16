### The issue
In case of BEAM instance crash it can happen, with the current Commanded implementation (v1.4.1), that output event is persisted, but the input event is not acknowledged.  

### Terminology
- Each Evented event-handler is executed as part of some Commanded command-handler

### Prerequisites
- [easy] Each output-event is persisted with metadata field "parent_event_number", containing event_id of the event that initiated the event-handling.
- [soon to be easy ([there is PR for this ](https://github.com/commanded/commanded/pull/514))] Process-manager has access to event-metadata, so it can pass it into the command-handler
- [not so easy (will require PR in Commanded code)] Command handler has access to the metadata of the last event that was applied to its state before the command handler was invoked.

### Algorithm
- When command-handler receives input-event and its metadata, it first checks if input event_number is the same as parent_event_number of the last event applied to the aggregate state.
- If they are the same: this is a retry of the previously executed handling, output event(s) of which were persisted, but the input event was not acknowledged. Do NOT call the event-handler. Instead, just return empty list (which will cause input-event to be acknowledged) and maybe emit some metric and logging.
- If they are not the same: execute the event-handler.