# Evented - State Machine as Sequence of Event Handlers

## Introduction
Evented is event-sourcing library/framework in which operations are represented as chains of retriable steps. Elements of the execution chain are connected and at the same time delimited with events.
Each step is initiated by some event and emits another event as a result of execution. 

## Recursive Nature of Nature
When it comes to causality it is recursive: there is a cause that has an effect, but that effect is in turn cause for some other effect and so on... Can we model code similarly?

If we look at state-machine (SM), input causes SM to (transition to another state and to) generate output. 
That output can be recursively used as SM input.

Can we split an arbitrary algorithm into (one or more) sequences of simple steps, where each sequence is initiated by an external stimulus/input? Why not?
And if we agree that SM inputs and outputs are events, we got Evented. Mechanism conceptually described by the following flowchart: 
```mermaid
flowchart BT

  

exev([external event])

es[(event store)]

ce([chain processing stops])

eh(event handler)

stl(State transition logic)

sl{{SM interested \n in this event?}}

  

exev --> | persist event | es

es --> sl

  

subgraph chl [Chain-handling logic]

subgraph sm [State Machine]

eh --> |new event| stl

end

sl --> |yes| eh

end

  

sl --> |no| ce

  

stl -.-> |current state| eh

stl --> |new state| stl

sm --> | persist new event | es
```





## Topics to discuss
### API
- `inject_event/2`
- `inject_event_and_wait/2` 
  - Semantic?
  - Wait for what? Wait for next event with the same correlation_id
- `agg_state/2`
  - Peek at the aggregate state from anywhere.
    - This breaks encapsulation of the aggregate.
  - Do we want this ability at all?
  - Emit event every time somebody wants to look at the aggregate state? 
    - Is it too expensive to be used by default?


### Aggregate
- What is it?
  - Consistency boundary.
  - Execution context (BEAM process within which SM executes).
  - State of the SM.
- How do we think about it?
- What do we use it for?


### Network split resilient?


```mermaid
flowchart TB
    HandleEvt1(Handle Evt1 and generate Evt2 and Evt3)
  Evt1 --> es_prim
  subgraph es_prim [event-store in t0]
   StoreEvt1
  end
  es_prim --> agg_t0
  subgraph agg_t0 [Aggregate in t_1]
    HandleEvt1 --> ApplyEvt2
    HandleEvt1 --> ApplyEvt3
  end
  subgraph es [event-store in t2]
    StoreEvt2_and_Evt3(Store Evt2 and Evt3 atomically and consecutively)
  end
    agg_t0 --> es
    es --> agg_t1
    agg_t1 --> agg_t2
  subgraph agg_t1 [Aggregate in t_3]
    HandleEvt2
  end
  subgraph agg_t2 [Aggregate in t_4]
    HandleEvt3
  end

```

