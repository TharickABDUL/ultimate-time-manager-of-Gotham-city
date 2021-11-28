defmodule Timemanager.Api.Clock do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "clocks" do
    field :status, :boolean, null: false
    field :time, :utc_datetime, null: false
    belongs_to :user, Timemanager.Api.User

    timestamps()
  end

  @doc false
  def changeset(clock, attrs) do
    clock
    |> cast(attrs, [:time, :status, :user_id])
    |> validate_required([:time, :status, :user_id])
    |>assoc_constraint(:user)
    |> clock_in()
  end

  defp clock_in(changeset) do
    user = get_field(changeset, :user_id)
    if is_nil(user) do
      put_change(changeset, :status, false)
    else
      time = get_field(changeset, :time)
      query_status = from s in "clocks", where: s.user_id == ^user, select: s.status,limit: 1, order_by: [desc: s.id]
      query_last_time = from s in "clocks", where: s.user_id == ^user, select: s.time,limit: 1, order_by: [desc: s.id]
      status = Timemanager.Repo.one(query_status)
      last_time = Timemanager.Repo.one(query_last_time)
      if  status == true do
        Timemanager.Api.create_workingtime(%{end: time,start: last_time,user_id: user})
        put_change(changeset, :status, false)
      else
        put_change(changeset, :status, true)
      end
    end
  end

end
