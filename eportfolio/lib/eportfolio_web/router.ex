defmodule EportfolioWeb.Router do
  use EportfolioWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug EportfolioWeb.Plugs.Locale
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EportfolioWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/contact", PageController, :contact
    get "/cv", PageController, :cv
    get "/cv_print", PageController, :cv_print
  end

  # Other scopes may use custom stacks.
  # scope "/api", EportfolioWeb do
  #   pipe_through :api
  # end
end
