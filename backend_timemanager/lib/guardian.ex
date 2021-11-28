defmodule Timemanager.Guardian do
  require Logger
  use Guardian, otp_app: :timemanager
  alias Timemanager.Api

  def subject_for_token(user, _claims) do
    sub = %{id: user.id, role_id: user.role_id, email: user.email, username: user.username}
    #Logger.debug "Sub value: #{inspect(sub)}"
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    user = claims["sub"]
    resource = Api.get_user!(user["id"])
    {:ok,  resource}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
