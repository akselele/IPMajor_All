use Mix.Config

# Configure your database
config :ectoW4, EctoW4.Repo,
  username: "root",
  password: "",
  database: "ectow4_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ectoW4_web, EctoW4Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
