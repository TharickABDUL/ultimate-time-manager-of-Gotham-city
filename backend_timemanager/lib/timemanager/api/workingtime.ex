defmodule Timemanager.Api.Workingtime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :utc_datetime, null: false
    field :start, :utc_datetime, null: false
    belongs_to :user, Timemanager.Api.User

    timestamps()
  end

  @doc false
  def changeset(workingtime, attrs) do
    workingtime
    |> cast(attrs, [:start, :end, :user_id])
    |> validate_required([:start, :end, :user_id])
    |> assoc_constraint(:user)
  end
end
