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
config :ectoW4,
  ecto_repos: [EctoW4.Repo]

config :ectoW4_web,
  ecto_repos: [EctoW4.Repo],
  generators: [context_app: :ectoW4]

# Configures the endpoint
config :ectoW4_web, EctoW4Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hKJDFI4sXBOWJwUO5dXAQNVIKZCs2mZSatLvAL3Uk6uoOcDtnFYXZQcEQ3BeohX1",
  render_errors: [view: EctoW4Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: EctoW4Web.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "8wqiYsdq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
