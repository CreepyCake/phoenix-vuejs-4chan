defmodule Trends4chanWeb.CurrentUserController do
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

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end

  def sign_in(conn, %{"session" => session_params}) do
    case authenticate(session_params) do
      {:ok, user} ->
        {:ok, jwt, _claims} = Guardian.encode_and_sign(user)

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user)

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: "Invalid username or password")
    end
  end

  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out
    |> render("delete.json")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render("forbidden.json", error: "Not authenticated")
  end

  defp authenticate(%{"username" => username, "password" => password}) do
    user = Accounts.get_user_by(username: username)

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> false
      _ -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
