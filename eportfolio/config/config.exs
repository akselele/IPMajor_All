# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :eportfolio, EportfolioWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1l3cos4EEpm4N4+qDB2OJ1PtNHnSFNFZiE6U3u4vLDGsc+uZnpmJZwfvhkt0fSrD",
  render_errors: [view: EportfolioWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Eportfolio.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "OKlPlFd1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :eportfolio, EportfolioWeb.Gettext,
  locales: ~w(en nl), # nl stands for Dutch.
  default_locale: "en"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
