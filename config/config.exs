import Config

config :oban_rate_limit, ObanRateLimit.Repo,
  database: "oban_rate_limit_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :oban_rate_limit, ecto_repos: [ObanRateLimit.Repo]

config :oban_rate_limit, Oban,
  repo: ObanRateLimit.Repo,
  plugins: [
    {Oban.Plugins.Cron,
     crontab: [
       {"* * * * *", Worker1}
     ]}
  ],
  engine: Oban.Pro.Queue.SmartEngine,
  queues: [
    default: [
      local_limit: 100,
      rate_limit: [
        allowed: 5,
        period: 10,
        partition: [fields: [:args], keys: [:some_arg_key]]
      ]
    ]
  ]
