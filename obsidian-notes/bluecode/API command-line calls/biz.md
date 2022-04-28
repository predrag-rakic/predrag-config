### Create merchant token:
```
curl --location --request POST 'https://merchant-api.bluecode.biz/v4/merchant_token' \
--header 'Content-Type: application/json' \
--header 'Authorization: Basic QkxVRUNPREVfMTg6ZjAyNGNhMjMtY2IxYi00NDE4LWExNjgtYWQzZDMxM2RhMzlm' \
--form 'branch_ext_id="outlettest"' \
--form 'token="27289358"' \
--form 'scan_date_time="2020-06-25T09:08:21Z"' \
--form 'source="pos"' \
--form 'terminal="my-terminal"' \
--form 'entry_mode="scan"'
```
