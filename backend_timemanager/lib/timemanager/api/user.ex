defmodule Timemanager.Api.User do
  use Ecto.Schema
  import Ecto.Changeset
  import EctoCommons.EmailValidator
  import Comeonin.Bcrypt, only: [hashpwsalt: 1]

  @derive {Jason.Encoder, only: [:id, :username, :email]}
  schema "users" do
    field :email, :string, null: false
    field :username, :string, null: false
    field :password_hash , :string, null: false
    field :password, :string, virtual: true
    many_to_many :my_teams, Timemanager.Api.Team, join_through: Timemanager.Api.Inteam, on_replace: :delete
    belongs_to :role, Timemanager.Api.Role


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_email(:email)
    |> unique_constraint(:email)
    |> put_password_hash
    |> cast_assoc(:my_teams)
    |> cast_assoc(:role)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}}
        ->
          put_change(changeset, :password_hash, hashpwsalt(pass))
      _ ->
          changeset
    end
  end

end
