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
config :auth,
  ecto_repos: [Auth.Repo]

config :auth_web,
  ecto_repos: [Auth.Repo],
  generators: [context_app: :auth]

config :auth_web, AuthWeb.Guardian,
  issuer: "auth_web",
  secret_key: "v4aO4NfXrlS+MWbZdcmjPSHyLLtt8WtvoZYzAhQ47CkNxtK3FPjRpwzmbHgB+f7J" # paste input here  

# Configures the endpoint
config :auth_web, AuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "ojenBbuRXbzf7aUQxf7mWR5gZ3lc1UxWtI+mtsCOOddU8HJ8jz/EDatfoof+/787",
  render_errors: [view: AuthWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: AuthWeb.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "fQqOIvWM"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
