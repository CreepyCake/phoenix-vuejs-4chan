defmodule Trends4chanWeb.UserSocket do
  use Phoenix.Socket

  ## Channels
  channel "users:*", Trends4chanWeb.UserChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
