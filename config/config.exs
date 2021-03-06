# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rerem,
  ecto_repos: [Rerem.Repo]

config :rerem, Rerem.Repo,
  migration_primary_key: [name: :id, type: :binary_id]

# Configures the endpoint
config :rerem, ReremWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qaIqXKQqh6AaXK+oHHxm0w1qxq0EsoktNYUBJyeiV8hTyEOi3LCoWDP2lxTIAJUV",
  render_errors: [view: ReremWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Rerem.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
