## Payment request flow (high level)
```mermaid
flowchart LR
merchant(Merchant)
ap(Acquiring Partner)
apr(Acquiring Processor)
ipr(Issuing/Clearing Processor)
bridge(EMPSA Bridge)
alipay(Alipay)
subgraph Scheme Services
  ts(Token Server)
  subgraph Payments Gateway
	  td(Transfer Disatcher)
    subgraph Transfer Processors
	    bc_tp(BC Processor)
	    empsa_tp(EMPSA Processor)
	    alipay_tp(Alipay Processor)
    end

    td --> bc_tp
		td --> empsa_tp
		td --> alipay_tp
  end
  td<-->|Barcode Lookup|ts
end

merchant -.-> ap -.-> apr
merchant
-->apr
-->|Payments API|td
bc_tp-->|BC Clearing API|ipr
empsa_tp -->|Empsa API| bridge
alipay_tp -->|Alipay API| alipay
```

## Payments API
- Caller is Acquiring Processor but
- Caller is authenticated as Acquiring Partner on whose behalf Acquiring Processor is making the call!

### Transfer-initiate request processing
Talking about SMS payment and DMS pre_auth request
```mermaid
flowchart LR
auth(Caller Authentication)
ipms(Iss Payment Method Names selection)
apms(Acq Payment Method Selection)
pp(Payment Processing)
auth-->|Acq Partner|ipms
-->|Iss PM Names|apms
-->|Payment Method and Acq Membership|pp
```

#### Caller Authentication
- Simplified version, without Acq Processor (there is only one Acq Processor currently).
- Public key associated with Acquirer (Acq Partner) entity in Acquibase.
- Private key associated with Partner (Acq Partner) entity in PGW

### Issuing Payment Method Name Selection

- PGW asks TS "What are PM names available for this token"?
- TS responds with list of PM names available for provided token (if token is valid).

#### Acquiring Payment Method Selection

- Filter input PM list and keep only PMs that are available to issuer.
- Get all acq_memberships available to acq partner and metch them against acq_memberships offered in PMs list. 
- First matching PM wins.

### Dictionary
- Acq Payment Method consists of:
  -  Acq PM Configuration and 
  -  Acq Membership
- Acq PM Configuration determines:
  - Transfer Processor (ex Payment Processor - Transfer Processor is probably better because that processore processes refunds also).
- Transfer Processor contains list of available schemes.
  - Do we need this? To make sure Alipay acq membership is not used on BC Transfer Processor?
  