defmodule ObanRateLimit.Repo do
  use Ecto.Repo,
    otp_app: :oban_rate_limit,
    adapter: Ecto.Adapters.Postgres
end
