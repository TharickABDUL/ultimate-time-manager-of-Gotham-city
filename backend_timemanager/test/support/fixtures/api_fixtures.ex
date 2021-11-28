defmodule Timemanager.ApiFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Timemanager.Api` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        username: "some username"
      })
      |> Timemanager.Api.create_user()

    user
  end

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: "some status",
        time: ~U[2021-10-25 08:58:00Z]
      })
      |> Timemanager.Api.create_clock()

    clock
  end

  @doc """
  Generate a workingtime.
  """
  def workingtime_fixture(attrs \\ %{}) do
    {:ok, workingtime} =
      attrs
      |> Enum.into(%{
        end: ~U[2021-10-25 13:17:00Z],
        start: ~U[2021-10-25 13:17:00Z]
      })
      |> Timemanager.Api.create_workingtime()

    workingtime
  end

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Timemanager.Api.create_team()

    team
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Timemanager.Api.create_role()

    role
  end
end
