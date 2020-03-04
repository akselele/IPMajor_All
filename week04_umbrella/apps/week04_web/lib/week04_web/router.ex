defmodule Week04Web.Router do
  use Week04Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Week04Web do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello", Week04Controller, :index
    get "/hello/:messenger", Week04Controller, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", Week04Web do
  #   pipe_through :api
  # end
end
