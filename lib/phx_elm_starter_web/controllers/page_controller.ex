defmodule PhxElmStarterWeb.PageController do
  use PhxElmStarterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
