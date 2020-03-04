defmodule Week04Web.PageController do
  use Week04Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
