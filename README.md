# WesEssex: [Wes](http://github.com/wooga/wes) on top of Elixir

A  key value store over for players (users on a game) in Elixir.
It integrates [Wes](http://github.com/wooga/wes) as Actors behind an http server.

There are `player_sessions` (wes channels) and `players` (wes actors).

### Intention

The intention behind this mock was to get the feel of doing day to day things in elixir
- reading header values
- json body requests
- json response
- writing tests against the http server
- and above all trying to use Wes from Elixir

## Using the app

Amazon S3 persistency could be configured using through configs found in `config/config.exs`
Otherwise, exchange:

```
  db_mod: :wes_db_s3,
  db_conf: [{:bucket, "bucket-name-here"}]
```

for:

```
  db_mod: :wes_db_null,
  db_conf: []
```

### Get dependencies
`mix deps.get && mix compile`

### Run tests
`mix run `

### Run the server
`mix run --no-halt`

### Amazon Beanstalk

Included in the repo there's a `Dockerfile` which was used to try and deploy the app to Amazon Beanstalk.

### TODO

- `WessEx.ex` starts the genservers manually
- The stats module being used is `wes_stats_null`. Whie using `wes_stats_ets` there's a problem to locate the ets table.
