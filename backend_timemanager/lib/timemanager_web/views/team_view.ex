defmodule TimemanagerWeb.TeamView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.TeamView

  def render("index.json", %{teams: teams}) do
    %{data: render_many(teams, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name,
      users: team.users
    }
  end

  def render("show_easy.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team_easy.json")}
  end

  def render("team_easy.json", %{team: team}) do
    %{
      id: team.id,
      name: team.name
    }
  end
end
