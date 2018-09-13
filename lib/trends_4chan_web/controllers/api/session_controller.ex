defmodule Trends4chanWeb.SessionController do
  use Trends4chanWeb, :controller

  alias Trends4chan.Accounts
  alias Trends4chan.Auth.Guardian

  def create(conn, %{"session" => session_params}) do
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

  def update(conn, %{"session" => session_params}) do
    username = Guardian.Plug.current_resource(conn).username
    user_session = %{
      "username" => username,
      "password" => session_params["current_password"]
    }

    case authenticate(user_session) do
      {:ok, user} ->
        user_params = %{
          "password" => session_params["password"]
        }

        case Accounts.update_user(user, user_params) do
          {:ok, user} ->
            conn
            |> put_status(:updated)
            |> render("show.json", user: user)

          {:error, changeset} ->
            conn
            |> put_status(:unprocessable_entity)
            |> render("error.json", changeset: changeset)
        end

      :error ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", message: "Incorrect password")
    end
  end

  def delete(conn, _) do
    # {:ok, claims} = Guardian.Plug.current_claims(conn)

    IO.inspect Guardian.Plug.current_resource(conn)
    IO.inspect Guardian.Plug.current_token(conn)

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
