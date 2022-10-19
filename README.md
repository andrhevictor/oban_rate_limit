# ObanRateLimit

It seems like the rate limit does not work well when one of the workers in the queue doesn't have the `arg` being used in the `rate_limit` config.

In this repo we have two workers in the same `default` queue: `Worker1` and `Worker2`.
The queue has rate_limit configured to use the arg `some_arg_key`.
`Worker1` is a Cron based worker and doesn't have any args. It creates 10 `Worker2` jobs with the `some_arg_key` arg setted.

## Expected behavior

The job that does not have the key should not be rate limited, but the job that has the key should still follow the rate limit defined.
In this case, `Worker1` should run whenever there is a job, but `Worker2` should still follow the rate limit as it has the `some_arg_key` key in the args.

## Repro

1. Configure the app following the **Installation** section
2. Run `iex -S mix`
3. Every minute a cron job will run, creating 1 `Worker1` job.
4. You'll see in the logs that all 10 `Worker2` jobs are processed instantly, ignoring the rate limit.

## Workaround

It can be fixed by providing the `some_arg_key` to `Worker1`.

On `config/config.exs` change line 16 to:

```elixir
{"* * * * *", Worker1, args: %{some_arg_key: nil}}
```

Doing that it works as expected

## Installation

- `git clone`
- `mix ecto.create`
- `mix ecto.migrate`

## Versions being used

| Dependency | Current | Latest | Status     |
| ---------- | ------- | ------ | ---------- |
| ecto_sql   | 3.9.0   | 3.9.0  | Up-to-date |
| oban_pro   | 0.12.6  | 0.12.6 | Up-to-date |
| postgrex   | 0.16.5  | 0.16.5 | Up-to-date |
