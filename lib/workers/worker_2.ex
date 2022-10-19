defmodule Worker2 do
  @moduledoc false
  use Oban.Pro.Worker, queue: :default, max_attempts: 3

  @impl Oban.Pro.Worker
  def process(%Job{args: %{"some_arg_key" => some_arg_key}}) do
    now = Time.utc_now() |> Time.truncate(:second)

    IO.inspect("[Worker2] #{inspect(now)} some_arg_key = #{some_arg_key}")

    :ok
  end
end
