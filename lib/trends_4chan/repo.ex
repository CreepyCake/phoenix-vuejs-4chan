defmodule Trends4chan.Repo do
  use Ecto.Repo, otp_app: :trends_4chan

  @doc """
  Dynamically loads the repository url from the
  DATABASE_URL environment variable.
  """
  def init(_, opts) do
    {:ok, Keyword.put(opts, :url, System.get_env("DATABASE_URL"))}
  end
end
