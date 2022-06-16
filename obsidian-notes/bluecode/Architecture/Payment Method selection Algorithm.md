## Payment request flow (high level)
```mermaid
flowchart LR
b_acq_proc(EMPSA Bridge as acq procesor)
  br_iss_proc(EMPSA Bridge as issuing proc)
merchant(Merchant)
ap(Acquiring Partner)
apr(Acquiring Processor)
  br_clr_proc(EMPSA Bridge as clearing proc)
alipay(Alipay)
cpr(Clearing Processor)
br_iss_proc <--> |Pairing|ts

subgraph Scheme Services
  subgraph Token Server
		dispatcher
    ts(Vault)
		
	end
  subgraph Payments Gateway
	  td(Transfer Disatcher)
		empsa_bcai(EMPSA controller - bcai)
    subgraph Transfer Processors
      subgraph Acquiring
				empsa_tp(EmpsaProcessor - bcaa)
	      alipay_tp(Alipay Processor)
      end
      subgraph Issuing
        bc_tp(BC Processor)
      end
    end

		td --> empsa_tp
		td --> alipay_tp
    td --> bc_tp
  end
  td<-->|Barcode Lookup|ts
end

apr<-->dispatcher

merchant -.-> ap -.-> apr
merchant
-->apr
-->|Payments API|td
empsa_tp -->|Empsa API| br_clr_proc
alipay_tp -->|Alipay API| alipay
bc_tp-->|BC Clearing API|cpr

b_acq_proc-->empsa_bcai
empsa_bcai-->td

```

## Payments API
- Caller is Acquiring Processor but
- Caller is authenticated as Acquiring Partner on whose behalf Acquiring Processor is making the call!

### Transfer-initiate request processing
Talking about SMS payment and DMS pre_auth request
```mermaid
flowchart TB
auth(Caller Authentication)
ipms(Iss Payment Method Names lookup)
apms(Acq Payment Method Selection)
pp(Payment Processing)
auth-->|Acq Partner|ipms
-->|Iss PM Names, <Iss Scheme>|apms
-->|Payment Method and Acq Membership|pp
```

#### Caller Authentication
- Simplified version, without Acq Processor (there is only one Acq Processor currently).
- Public key associated with Acquirer (Acq Partner) entity in Acquibase.
- Private key associated with Partner (Acq Partner) entity in PGW

### Issuing Payment Method Name Selection

- PGW asks TS "Here is a token, what do you know about it?" 
  
- TS responds with list of Iss proc scheme and list of PM names available for provided token (if token is valid).

#### Acquiring Payment Method Selection

- Filter input PM list and keep only PMs that are available to issuer.
- Get all acq_memberships available to acq partner and metch them against acq_memberships offered in PMs list. 
- First matching PM wins.

### Dictionary
- Acq Payment Method consists of:
  -  Acq PM Configuration and 
  -  Acq Membership
- Acq PM Configuration determines:
  - Transfer Processor (ex Payment Processor - Transfer Processor is probably better name because that processore processes refunds also).
- I  