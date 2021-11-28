defmodule TimemanagerWeb.UserView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email,
      role: user.role,
      teams: user.my_teams
    }
  end

  def render("show_easy.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_easy.json")}
  end

  def render("user_easy.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      email: user.email
    }
  end

  def render("jwt.json", %{jwt: token}) do
    %{jwt: token}
  end
end
