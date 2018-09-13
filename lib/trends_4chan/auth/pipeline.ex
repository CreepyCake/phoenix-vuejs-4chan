defmodule Trends4chan.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :trends_4chan,
    module: Trends4chan.Auth.Guardian,
    error_handler: Trends4chan.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
