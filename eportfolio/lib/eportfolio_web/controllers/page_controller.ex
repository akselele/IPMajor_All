defmodule EportfolioWeb.PageController do
  use EportfolioWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def contact(conn, _params) do
    render(conn, "contact.html")
  end

  def cv(conn, _params) do
    render(conn, "cv.html")
  end

  def cv_print(conn, _params) do
    conn = put_layout conn, false
    render(conn, "cv_print.html")
  end
end