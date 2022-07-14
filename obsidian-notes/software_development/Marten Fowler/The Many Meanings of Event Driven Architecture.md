https://www.youtube.com/watch?v=STKCRSUsyP0&ab_channel=GOTOConferences

Event driven system:
1. Event Notification
2. Event-carried State Transfer
3. Event Sourcing - State is ephemeral, can be recreated from the event log
	- Examples:
	  - version controll system
	  - acounting ledger
	- Pros: audit, debugging, historic state, alternative state, memory image
	- Cons: Eventual consistency, versioning
4. CQRS


Con:
- no statement of overal behavior