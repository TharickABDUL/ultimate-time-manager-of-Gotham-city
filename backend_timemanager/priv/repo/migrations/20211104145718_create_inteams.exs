defmodule Timemanager.Repo.Migrations.CreateInteams do
  use Ecto.Migration

  def change do
    create table(:inteams) do
      add(:team_id, references(:teams, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)

      timestamps()
    end
  end
end
