defmodule Rerem.Repo do
  use Ecto.Repo,
    otp_app: :rerem,
    adapter: Ecto.Adapters.Postgres
end
