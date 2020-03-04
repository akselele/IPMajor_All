# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :week04,
  ecto_repos: [Week04.Repo]

config :week04_web,
  ecto_repos: [Week04.Repo],
  generators: [context_app: :week04]

# Configures the endpoint
config :week04_web, Week04Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "q9Koo+WH4q3mVIflp+9+Tupg8XZKdgl0wa93GpJE0okHa+vuLAAqjPA2HaWsn7gM",
  render_errors: [view: Week04Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Week04Web.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "ZUC+Atu0"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
