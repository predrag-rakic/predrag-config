```
https://payments-admin.bluecode.com/oban/ui/jobs/12214759

%{"activity_id" => "9fda8416-c8d7-4a34-a26d-33e1e88fd4b8"}

** (UndefinedFunctionError) function nil.contract/0 is undefined. If you are using the dot syntax, such as map.field or module.function(), make sure the left side of the dot is an atom or a map
    nil.contract()
    (token_server 0.1.0) lib/sdk_api/api/lookup_response.ex:106: TokenServer.Api.LookupResponse.to_struct/3
    (token_server 0.1.0) lib/token_server/api/token_api.ex:99: TokenServer.Api.TokenApi.lookup_and_burn/1
    (payments 0.1.0) lib/payments/processor/blue_code/barcode_lookup.ex:52: Payments.Processor.BlueCode.BarcodeLookup.do_lookup_token/1
    (payments 0.1.0) lib/payments/processor/blue_code.ex:166: Payments.Processor.BlueCode.preprocess/1
    (payments 0.1.0) lib/payments/processor/blue_code.ex:92: Payments.Processor.BlueCode.preprocess_only/1
    (payments 0.1.0) lib/payments/v2.ex:33: Payments.V2.payment_preprocess/4
    (payments 0.1.0) lib/payments/activities/queue_workers/preprocessor_worker.ex:42: Payments.Activities.QueueWorkers.PreprocessorWorker.perform/1
	```
	
	Content of crashing line: 
	```
	contract = token.card.contract
	```
	
	Barcode: 98803663990739421133
	
	
	
iex(sdk_api@10.140.241.76)2> alias Payments.Processor.BlueCode.BarcodeLookup
Payments.Processor.BlueCode.BarcodeLookup
iex(sdk_api@10.140.241.76)3> BarcodeLookup.lookup %{token: "98803663990739421133"}
%TokenServer.Api.LookupResponse{
  card: %TokenServer.Api.LookupResponse.CardResponse{
    card_gid: "crd_59b33337-40c1-4224-b7d0-d2d2194d99d8",
    reference: "SJFS277LKY8V",
    state: "deleted"
  },
  card_gid: "crd_59b33337-40c1-4224-b7d0-d2d2194d99d8",
  contract: %TokenServer.Api.LookupResponse.ContractResponse{
    bic: "VBOEATWWXXX",
    bluecode_id: "TZIIUR",
    blz: "18160",
    clearing_processor_id: "0c421d5a-b6e1-4fa8-b389-e01f82648e43",
    contract_gid: "con_32d776ad-b7a3-488c-a1a5-053a9e8db735",
    contract_number: "2a26abc1-65f8-4efa-a1a9-9e8c8f12285f",
    country: "AT",
    currency: "EUR",
    deleted_at: nil,
    issuer_processor: "SPT_HYPO_TIROL",
    issuer_processor_id: "17e20a63-a534-4254-94c3-510fb55964d5",
    legacy_issuer: "SPT_VOBA_W",
    member_id: "ATI0000393",
    state: "active"
  },
  contract_gid: "con_32d776ad-b7a3-488c-a1a5-053a9e8db735",
  empsa_payment_id: nil,
  issuer: %TokenServer.Api.LookupResponse.IssuerResponse{
    bank_code: "VBOEATWWXXX",
    beneficiary_account_number: nil,
    id: "7279bc0d-42d9-4a8f-955c-28ad7b433cca",
    member_id: "ATI0000393",
    name: "Volksbank Wien AG"
  },
  issuer_processor: %TokenServer.Api.LookupResponse.IssuerProcessorResponse{
    clearing_processor_id: "0c421d5a-b6e1-4fa8-b389-e01f82648e43",
    id: "17e20a63-a534-4254-94c3-510fb55964d5",
    name: "ARZ",
    sdd_fraud_protected: false,
    user_confirmation_required: false
  },
  issuing_payment_method_names: ["bluecode"],
  limits: %{
    value: %{p10d: nil, p1d: 20000, p1w: nil, p4d: nil, trx: nil},
    velocity: %{p1d: 10, p1h: 4}
  },
  merchant_token: nil,
  order: nil,
  pass: nil,
  pass_gid: nil,
  result: "token_used",
  scheme: "blue_code",
  sdk_host: "BLUECODE",
  token: %Inspect.Error{
    message: "got KeyError with message \"key :shortcode not found in: %{__struct__: TokenServer.Api.LookupResponse.TokenResponse, barcode: \\\"988___________421133\\\", expires_at: ~U[2022-11-27 19:34:55.211265Z], is_consumer_scanned: nil, state: \\\"used\\\", token_gid: \\\"tok_9becfcb2-dc48-4192-8855-de61172b8269\\\", used_at: ~U[2022-06-10 17:23:38.763463Z]}\" while inspecti
ng %{__struct__: TokenServer.Api.LookupResponse.TokenResponse, barcode: \"98803663990739421133\", expires_at: ~U[2022-11-27 19:34:55.211265Z], is_consumer_scanned: nil, state: \"used\", token_gid: \"tok_9becfcb2-dc48-4192-8855-de61172b8269\", used_at: ~U[2022-06-10 17:23:38.763463Z]}"
  },
  token_gid: "tok_9becfcb2-dc48-4192-8855-de61172b8269",
  vas: %TokenServer.Api.LookupResponse.VasResponse{
    account_bearer_token: "3d79cb71-2043-4b62-993d-9be7e4e61a0f",
    card_gid: nil,
    pass_gid: nil,
    result: nil,
    sdk_host: "BLUECODE",
    token: "98803663990739421133",
    token_state: "used",
    vas_id: "3d79cb71-2043-4b62-993d-9be7e4e61a0f",
    vas_webview_config_id: "BLUECODE_APP",
    wallet_gid: "wlt_5b9dd45c-2433-4fac-ab0f-c88effd23384"
  },
  vas_id: "3d79cb71-2043-4b62-993d-9be7e4e61a0f",
  wallet: %TokenServer.Api.LookupResponse.WalletResponse{
    host: "BLUECODE",
    reference: "OXW72W8G",
    wallet_gid: "wlt_5b9dd45c-2433-4fac-ab0f-c88effd23384"
  },
  wallet_gid: "wlt_5b9dd45c-2433-4fac-ab0f-c88effd23384"
}

	