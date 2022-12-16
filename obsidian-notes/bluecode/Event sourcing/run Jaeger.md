docker run --rm \
  -e COLLECTOR_OTLP_ENABLED=true \
  -p 4317:4317 -p 4318:4318 \
  -p 16686:16686 \
  jaegertracing/all-in-one:1.39
