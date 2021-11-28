defmodule TimemanagerWeb.Router do
  use TimemanagerWeb, :router
  alias Timemanager.Guardian
  alias Timemanager.Plug.CrsfCheck
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {TimemanagerWeb.LayoutView, :root}
    # plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  pipeline :jwt_authenticated do
    plug Guardian.AuthPipeline
  end


  scope "/api", TimemanagerWeb do
    pipe_through :api
    post "/users/register", UserController, :register
    post "/users/login", UserController, :login

    scope "/" do
      pipe_through :jwt_authenticated
      get "/users/me", UserController, :get_connected_user
      resources "/users", UserController, only: [:index, :show, :create, :update, :delete]

      scope "/clocks" do
        post "/:userID", ClockController, :create
        get "/:userID", ClockController, :index
        get "/useless/:userID", ClockController, :show
      end

      scope "/workingtimes" do
        resources "/", WorkingtimeController, only: [:show, :update, :delete]
        get "/users/:userID", WorkingtimeController, :index
        post "/:userID", WorkingtimeController, :create
      end

      scope "/team" do
        post "/:team_id/user/:user_id", TeamController, :join
        get "/:team_id", UserController, :get_team_users
      end

      resources "/teams", TeamController, only: [:index, :show, :create, :update, :delete]
      #resources "/roles", RoleController, only: [:index, :show, :create, :update, :delete]

    end
  end

  scope "/api", TimemanagerWeb do
    pipe_through [:api, :jwt_authenticated]

    get "/users/profil", UserController, :show
  end


  # Other scopes may use custom stacks.
  # scope "/api", TimemanagerWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: TimemanagerWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
