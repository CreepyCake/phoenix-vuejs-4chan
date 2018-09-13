defmodule Trends4chanWeb.RegistrationView do
  use Trends4chanWeb, :view

  alias Trends4chanWeb.ErrorHelpers

  def render("error.json", %{changeset: changeset}) do
    errors =
      Enum.reduce(changeset.errors, %{}, fn {field, detail}, acc ->
        Map.put(acc, field, ErrorHelpers.render_detail(detail))
      end)

    %{errors: errors}
  end
end
