
## Steps
- Create card to be reconnected, if it does not exist
  - Attach it to whatever contract.
- Find card to be reconnected
  - For example, through contract admin page
```
SELECT * FROM cards WHERE contract_id = '718def5a-f58c-4baf-9842-f36e93eee6da';
```

-  Find contract to connect to existing card
  - For example, using `card_id` in token found by barcode
```
SELECT * FROM tokens WHERE barcode = '98802731025038261440';

SELECT * FROM cards WHERE id = '2f872610-e7ee-47dd-bf7c-abf17fb6e2cc';
```

- Attach contract to card
```
UPDATE cards SET contract_id= 'e5cdb7d3-f45d-4f97-85cf-295ae8fa9106' WHERE id = '03b24a7e-cc8a-4f9a-a1ba-292cc95eee86';
```
