defmodule Trends4chanWeb.Router do
  use Trends4chanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :ensure_auth do
    plug Trends4chan.Auth.Pipeline
  end

  scope "/api", Trends4chanWeb do
    pipe_through :api

    post "/sign_up", CurrentUserController, :create
    post "/sign_in", CurrentUserController, :sign_in
  end

  scope "/api", Trends4chanWeb do
    pipe_through [:api, :ensure_auth]

    put "/sessions", SessionController, :update
    delete "/sign_out", CurrentUserController, :delete
    get "/user", CurrentUserController, :show
  end
end
