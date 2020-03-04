defmodule Week04.Repo do
  use Ecto.Repo,
    otp_app: :week04,
    adapter: Ecto.Adapters.MyXQL
end
