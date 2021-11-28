defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role_id, references(:roles, on_delete: :delete_all)
      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
