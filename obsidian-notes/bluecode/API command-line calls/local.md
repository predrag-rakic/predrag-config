### Create merchant token:

```
curl --location --request POST 'https://merchant-api.prakic.bloomco.de/v4/merchant_token' \
-u BANANA_SPLIT:now-regard-unit-ornament \
--header 'Content-Type: application/json' \
--form 'branch_ext_id="outlettest"' \
--form 'token="25145519"' \
--form 'scan_date_time="2020-06-25T09:08:21Z"' \
--form 'source="pos"' \
--form 'terminal="my-terminal"' \
--form 'entry_mode="scan"'