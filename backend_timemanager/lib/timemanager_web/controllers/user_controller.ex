defmodule TimemanagerWeb.UserController do
  require Logger
  use TimemanagerWeb, :controller
  require String
  alias Timemanager.Api
  alias Timemanager.Api.User
  alias Timemanager.Guardian

  action_fallback TimemanagerWeb.FallbackController

  defmodule JWTError do
    @moduledoc """
    Error raised when a required field is missing.
    """

    defexception message: "JWT-Transgression"
  end

  def index(conn, params) do
    users = Api.list_users(params)
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Api.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show_easy.json", user: user)
    end
  end

  def register(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Api.create_user(user_params) do
      conn
      |> send_resp(:no_content, "")
    end
  end

  def login(conn, %{"email" => email, "password" => password}) do
    case Api.token_sign_in(email, password) do
      {:ok, token, _claims} ->
        conn
        |> render("jwt.json", jwt: token)
      _ ->
        {:error, :unauthorized}
    end
  end

  def show(conn, %{"id" => id}) do
    #user = Guardian.Plug.current_resource(conn)
    user = Api.get_user!(id)
    conn |> render("user.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Api.get_user!(id)

    with {:ok, %User{} = user} <- Api.update_user(user, user_params) do
      render(conn, "show_easy.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Api.get_user!(id)

    with {:ok, %User{}} <- Api.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_team_users(conn, %{"team_id" => team_id}) do
    users = Api.get_team_users(team_id)
    render(conn, "index.json", users: users)
  end

  def get_connected_user(conn, params) do
    jwt_header = List.first(get_req_header(conn,"authorization"))
    size = String.length(jwt_header)
    jwt = String.slice(jwt_header,7, size - 7)
    case Timemanager.Guardian.decode_and_verify(jwt) do
      {:ok, claims} ->
        user = Api.get_user!(claims["sub"]["id"])
        conn |> render("user.json", user: user)
      _ ->
        raise(JWTError)
    end
  end
end
