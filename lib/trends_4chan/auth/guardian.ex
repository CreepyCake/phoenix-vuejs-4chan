defmodule Trends4chan.Auth.Guardian do
  use Guardian, otp_app: :trends_4chan

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = Trends4chan.Accounts.get_user!(id)
    {:ok,  user}
  end
end
