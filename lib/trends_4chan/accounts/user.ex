defmodule Trends4chan.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Poison.Encoder, only: [:id, :username]}


  schema "users" do
    field :password_hash, :string
    field :username, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> validate_length(:username, min: 5, max: 15)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:username, message: "Username already taken")
    |> hash_password
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> changeset
    end
  end
end
