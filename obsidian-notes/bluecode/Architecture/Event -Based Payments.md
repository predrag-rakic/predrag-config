```mermaid

sequenceDiagram

autonumber

participant ApiProxy
participant PreAuthAgg
participant PreAuthPM
participant PreAuthTxAgg
participant ClearingApiClientPM
participant ClearingApiClientAgg
%Note over ApiProxy,ClearingApiClientAgg: PreAuth Processing
ApiProxy-->>PreAuthAgg: CreatePreAuth
PreAuthAgg->>PreAuthPM: PreAuthCreated
PreAuthPM-->>PreAuthTxAgg: CreatePreAuthConsumerTx
PreAuthTxAgg->>ClearingApiClientPM: PreAuthConsumerTxCreated
ClearingApiClientPM->>ClearingApiClientAgg: CallClearingApiPreAuth
ClearingApiClientAgg->>ClearingApiClientPM: ClearingApiPreAuthApproved/Declined
ClearingApiClientPM-->>PreAuthTxAgg: Approve/DeclinePreAuthConsumerTx
PreAuthTxAgg->>PreAuthPM: PreAuthConsumerTxApproved/Declined
PreAuthPM-->>PreAuthAgg: Approve/DeclinePreAuth
PreAuthAgg->>ApiProxy: PreAuthApproved/Declined

```