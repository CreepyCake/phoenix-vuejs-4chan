defmodule Trends4chanWeb.Router do
  use Trends4chanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Trends4chanWeb do
    pipe_through :api
  end
end
