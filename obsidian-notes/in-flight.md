# Evented application EbPayments.Dms.App

  

THIS IS GENERATED FILE

  

!!!!! DO NOT MODIFY !!!!!

  

## List of events:

  

- EbPayments.Command.CreateCapture

- EbPayments.Command.CreatePreAuth

- EbPayments.Command.GetState

- LocalEvents.V0.CaptureCallerAuthorizedV1

- LocalEvents.V0.CaptureCallerNotAuthorizedV1

- LocalEvents.V0.CaptureCreatedV1

- LocalEvents.V0.CaptureDeclinedV1

- LocalEvents.V0.PaymentMethodSelectedV1

- LocalEvents.V0.PaymentMethodSelectionFailedV1

- LocalEvents.V0.PreAuthApprovedV1

- LocalEvents.V0.PreAuthClearingApprovedV1

- LocalEvents.V0.PreAuthClearingDeclinedV1

- LocalEvents.V0.PreAuthClearingRequestCreatedV1

- LocalEvents.V0.PreAuthCreatedV1

- LocalEvents.V0.PreAuthDeclinedV1

- LocalEvents.V0.TokenNotRedeemableV1

- LocalEvents.V0.TokenRedeemableV1

- LocalEvents.V0.TokenRedeemedV1

- LocalEvents.V0.TokenRedemptionFailedV1

- :no_output_event

  

## Event Flowchart

  

```mermaid

flowchart TD

  

EbPayments.Command.CreateCapture-->|EbPayments.Dms.Transfer.TransferHh\nCapture: parse input|LocalEvents.V0.CaptureCreatedV1

EbPayments.Command.CreatePreAuth-->|EbPayments.Dms.Transfer.TransferHh\nPre-auth input validation|LocalEvents.V0.PreAuthCreatedV1

EbPayments.Command.GetState-->|EbPayments.Dms.Transfer.TransferHh\nGet state|:no_output_event

LocalEvents.V0.CaptureCreatedV1-->|EbPayments.Dms.Transfer.TransferHh\nCapture: authorize requester - validate partner|LocalEvents.V0.CaptureCallerAuthorizedV1

LocalEvents.V0.CaptureCreatedV1-->|EbPayments.Dms.Transfer.TransferHh\nCapture: authorize requester - validate partner|LocalEvents.V0.CaptureCallerNotAuthorizedV1

LocalEvents.V0.CaptureCreatedV1-->|EbPayments.Dms.Transfer.TransferHh\nCapture: authorize requester - validate partner|LocalEvents.V0.CaptureDeclinedV1

LocalEvents.V0.PaymentMethodSelectedV1-->|EbPayments.Dms.Transfer.TransferHh\nRedeem token|LocalEvents.V0.TokenRedeemedV1

LocalEvents.V0.PaymentMethodSelectedV1-->|EbPayments.Dms.Transfer.TransferHh\nRedeem token|LocalEvents.V0.TokenRedemptionFailedV1

LocalEvents.V0.PaymentMethodSelectionFailedV1-->|EbPayments.Dms.Transfer.TransferHh\n|LocalEvents.V0.PreAuthDeclinedV1

LocalEvents.V0.PreAuthClearingApprovedV1-->|EbPayments.Dms.Transfer.TransferHh\n|LocalEvents.V0.PreAuthApprovedV1

LocalEvents.V0.PreAuthClearingDeclinedV1-->|EbPayments.Dms.Transfer.TransferHh\n|LocalEvents.V0.PreAuthDeclinedV1

LocalEvents.V0.PreAuthClearingRequestCreatedV1-->|EbPayments.TransferProcessor.BC.ClearingApiLegacy.ClearingApiEv\nMake synchronous clearing API call|LocalEvents.V0.PreAuthClearingApprovedV1

LocalEvents.V0.PreAuthClearingRequestCreatedV1-->|EbPayments.TransferProcessor.BC.ClearingApiLegacy.ClearingApiEv\nMake synchronous clearing API call|LocalEvents.V0.PreAuthClearingDeclinedV1

LocalEvents.V0.PreAuthCreatedV1-->|EbPayments.Dms.Transfer.TransferHh\nToken lookup|LocalEvents.V0.TokenNotRedeemableV1

LocalEvents.V0.PreAuthCreatedV1-->|EbPayments.Dms.Transfer.TransferHh\nToken lookup|LocalEvents.V0.TokenRedeemableV1

LocalEvents.V0.TokenNotRedeemableV1-->|EbPayments.Dms.Transfer.TransferHh\n|LocalEvents.V0.PreAuthDeclinedV1

LocalEvents.V0.TokenRedeemableV1-->|EbPayments.Dms.Transfer.TransferHh\nSelect payment method|LocalEvents.V0.PaymentMethodSelectedV1

LocalEvents.V0.TokenRedeemableV1-->|EbPayments.Dms.Transfer.TransferHh\nSelect payment method|LocalEvents.V0.PaymentMethodSelectionFailedV1

LocalEvents.V0.TokenRedeemedV1-->|EbPayments.Dms.Transfer.TransferHh\nCreate Clearing API request|LocalEvents.V0.PreAuthClearingRequestCreatedV1

LocalEvents.V0.TokenRedemptionFailedV1-->|EbPayments.Dms.Transfer.TransferHh\n|LocalEvents.V0.PreAuthDeclinedV1

```