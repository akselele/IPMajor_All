defmodule Week04Web.Week04Controller do
    use Week04Web, :controller
  
    def index(conn, _params) do
      render(conn, "index.html")
    end

    def show(conn, %{"messenger" => messenger}) do ##'(conn, %{"messenger" => messenger} = params)' If you need the full map in your method
      render(conn, "show.html", messenger: messenger)
    end
  end   