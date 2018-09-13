defmodule Trends4chanWeb.RegistrationController do
  use Trends4chanWeb, :controller

  alias Trends4chan.Accounts
  alias Trends4chan.Auth.Guardian
  alias Trends4chanWeb.SessionView

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        |> render(SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end
end
