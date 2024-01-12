>Given two events A and B present in the event stream in that order, it’s
possible that B relies on A having been processed first. But it’s also entirely
possible that event B makes no such assumptions because the events are com-
pletely independent of one another.

This might sound like nit-picking but I believe it contains sustinski incorrect assumption.

It is irrelevant if events do or do not depend on each other (whatever depend means). What is important in this discussion is if handling of event B causally depends on handling of event A (B depends on consequences of A handling)

Assumption:
- 
- Causal dependency of event processing can be determined just based on topological characteristic of the stream? 
   This is intuitively a stretch for me.

  

================

================

Computer science concurrency theory is applicable to operations, as units of atomic activity. Not on events, because events are not units of