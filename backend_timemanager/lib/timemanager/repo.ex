defmodule Timemanager.Repo do
  import Ecto.Queryable
  use Ecto.Repo,
    otp_app: :timemanager,
    adapter: Ecto.Adapters.Postgres
end
