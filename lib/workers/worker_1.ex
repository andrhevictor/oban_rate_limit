defmodule Worker1 do
  @moduledoc false
  use Oban.Pro.Worker, queue: :default, max_attempts: 3

  @impl Oban.Pro.Worker
  def process(_job) do
    now = Time.utc_now() |> Time.truncate(:second)

    IO.inspect("[Worker1] #{inspect(now)}")

    Enum.map(1..10, fn _ ->
      Worker2.new(%{"some_arg_key" => 1}) |> Oban.insert()
    end)

    :ok
  end
end
