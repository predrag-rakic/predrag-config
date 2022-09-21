From Aggregate
```
# We get here if request with that pid was already received
def apply(
  %__MODULE__{pid: pid} = agg,
  %EmpsaPaymentRequestReceivedV1point1{request_id: request_id} = e
) do
  arg = %{data: %{pid: pid, request_id: request_id}}

  if retry?(agg, e) do
    # Raise in order to prevent new event being persisted.
    raise RetryNotification.new(arg)
  else
    raise InvalidEmpsaRequestError.new(
      Map.put(arg, :reason, "Same pid but different request_id or request data")
    )
  end
end

############################

defp retry?(agg, event) do
  agg.payment_request_event == event
end
```

From empsa.ex:
```
|> case do
  {:error, %RetryNotification{}} ->
    # TODO: make status call
    {:ok, %{}}

  other ->
    other
end
```