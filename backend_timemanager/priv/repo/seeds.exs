# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Timemanager.Repo.insert!(%Timemanager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Timemanager.Repo.insert! %Timemanager.Api.Role{
  name: "Admin"
}

Timemanager.Repo.insert! %Timemanager.Api.Role{
  name: "Manager"
}

Timemanager.Repo.insert! %Timemanager.Api.Role{
  name: "Worker"
}
