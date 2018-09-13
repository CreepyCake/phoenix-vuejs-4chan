defmodule Trends4chanWeb.CurrentUserView do
  use Trends4chanWeb, :view

def render("show.json", %{jwt: jwt, user: user}) do
    %{jwt: jwt, user: user}
  end

  def render("show.json", %{user: user}) do
    %{user: user}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("error.json", %{changeset: changeset}) do
    errors =
      Enum.reduce(changeset.errors, %{}, fn {field, detail}, acc ->
        Map.put(acc, field, ErrorHelpers.render_detail(detail))
      end)

    %{errors: errors}
  end

  def render("error.json", %{current_password: message}) do
    %{
      errors: %{
        current_password: message
      }
    }
  end

  def render("error.json", %{message: message}) do
    %{message: message}
  end

  def render("error.json", _) do
    {:ok, true}
  end

  def render("forbidden.json", %{error: error}) do
    %{message: error}
  end
end
