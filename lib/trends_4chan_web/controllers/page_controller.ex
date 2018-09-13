defmodule Trends4chanWeb.PageController do
  use Trends4chanWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
