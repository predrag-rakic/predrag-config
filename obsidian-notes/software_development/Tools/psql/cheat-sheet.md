## Eventstore DB

Search for events
```
WITH events_with_json_data AS (
   SELECT *,  encode(data, 'escape')::jsonb AS "data_json" 
   FROM events 
   ORDER BY created_at DESC
)
SELECT event_type, jsonb_pretty(data_json) 
FROM events_with_json_data
WHERE data_json ->> 'pre_auth_id' = '2eb8f6ad-0b82-4722-9ba7-88406c66fe98';
```
