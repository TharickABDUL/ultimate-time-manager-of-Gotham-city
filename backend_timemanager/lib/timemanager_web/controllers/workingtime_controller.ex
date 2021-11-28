defmodule TimemanagerWeb.WorkingtimeController do
  require Logger
  use TimemanagerWeb, :controller

  alias Timemanager.Api
  alias Timemanager.Api.Workingtime

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, %{"userID" => id}) do
    query = fetch_query_params(conn)
    workingtimes = Api.list_workingtimes(id, query.params)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"workingtime" => workingtime_params, "userID" => userid}) do
    workingtime_params = Map.put(workingtime_params, "user_id", userid)
    with {:ok, %Workingtime{} = workingtime} <- Api.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"id" => id}) do
    workingtime = Api.get_workingtime!(id)
    render(conn, "show.json", workingtime: workingtime)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Api.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- Api.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Api.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Api.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
