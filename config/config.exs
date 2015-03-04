use Mix.Config

# To use s3, change the config to have
#      db_mod: :wes_db_s3,
#      db_conf: [{:bucket, "bucket-name-here"}]
config :wes,
  [
    actors: [
      [
        id: :player,
        lock_mod: :wes_lock_ets,
        lock_conf: [],
        cb_mod: Player,
        db_mod: :wes_db_null,
        db_conf: []
      ]
    ],
    channels:
    [
      [ id: :player_session,
        lock_mod: :wes_lock_ets,
        lock_conf: [],
        lock_timeout_interval: 60000,
        message_timeout: 50000,
        save_timeout: 10000,
        stats_mod: :wes_stats_null
      ]
    ]
  ]

  config :s3,
  [
  credentials: [{:access_key, "ACCES_KEY"}, {:secret_access_key, "SECRET_ACCESS_KEY"}]
  ]


