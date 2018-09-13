defmodule Trends4chanWeb.UserChannel do
  use Trends4chanWeb, :channel

  alias Trends4chan.Auth.Guardian

  def join("users" <> _user_id, %{"token" => token}, socket) do
    case Guardian.decode_and_verify(token) do
      {:ok, claims} ->
        case Guardian.resource_from_claims(claims) do
          {:ok, user} ->
            {:ok, assign(socket, :current_user, user)}
          {:error, _reason} ->
            :error
        end
       {:error, _reason} ->
          :error
    end
  end

  def leave(_reason, socket) do
    {:ok, socket}
  end
end
