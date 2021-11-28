defmodule Timemanager.Api.Inteam do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "inteams" do
    belongs_to :user, Timemanager.Api.User
    belongs_to :team, Timemanager.Api.Team
    timestamps()
  end
end
