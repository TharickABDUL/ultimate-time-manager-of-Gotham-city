defmodule TimemanagerWeb.TeamController do
  use TimemanagerWeb, :controller

  alias Timemanager.Api
  alias Timemanager.Api.Team

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    teams = Api.list_teams()
    render(conn, "index.json", teams: teams)
  end

  def create(conn, %{"team" => team_params}) do
    with {:ok, %Team{} = team} <- Api.create_team(team_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.team_path(conn, :show, team))
      |> render("show_easy.json", team: team)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Api.get_team!(id)
    render(conn, "show.json", team: team)
  end

  def update(conn, %{"id" => id, "team" => team_params}) do
    team = Api.get_team!(id)

    with {:ok, %Team{} = team} <- Api.update_team(team, team_params) do
      render(conn, "show.json", team: team)
    end
  end

  def delete(conn, %{"id" => id}) do
    team = Api.get_team!(id)

    with {:ok, %Team{}} <- Api.delete_team(team) do
      send_resp(conn, :no_content, "")
    end
  end

  def join(conn, %{"team_id" => team_id, "user_id" => user_id}) do
    user = Api.get_user!(user_id)
    case Api.join_team(team_id, user) do
      {:ok, _} -> json conn, :ok
      {:error, _} -> json conn, :error
    end
  end
end
