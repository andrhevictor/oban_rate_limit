defmodule ObanRateLimit.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ObanRateLimit.Repo,
      {Oban, Application.fetch_env!(:oban_rate_limit, Oban)}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ObanRateLimit.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
