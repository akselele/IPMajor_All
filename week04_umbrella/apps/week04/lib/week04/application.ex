defmodule Week04.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Week04.Repo
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Week04.Supervisor)
  end
end
