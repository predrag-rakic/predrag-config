https://nimblehq.co/blog/the-journey-on-choosing-elixir-background-job-tooling

**TL;DR**

-   Pick [Task](https://hexdocs.pm/elixir/Task.html) or [GenServer](https://hexdocs.pm/elixir/GenServer.html) for simple asynchronous jobs for which data persistence is not required.
-   Pick [Oban](https://github.com/sorentwo/oban) (backed by PostgreSQL) or [Verk](https://github.com/edgurgel/verk) (backed by Redis) for advanced asynchronous jobs for which data persistence is required.