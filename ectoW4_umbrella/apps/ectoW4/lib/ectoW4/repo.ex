defmodule EctoW4.Repo do
  use Ecto.Repo,
    otp_app: :ectoW4,
    adapter: Ecto.Adapters.MyXQL
end
