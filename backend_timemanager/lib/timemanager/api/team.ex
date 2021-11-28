defmodule Timemanager.Api.Team do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :name]}
  schema "teams" do
    field :name, :string
    many_to_many :users, Timemanager.Api.User, join_through: Timemanager.Api.Inteam, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> cast_assoc(:users)
  end
end
