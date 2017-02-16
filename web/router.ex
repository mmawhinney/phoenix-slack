defmodule Slack.Router do
  use Slack.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Slack.Auth, repo: Slack.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Slack do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    
    get "/login", SessionController, :new
    post "/login", SessionController, :create
    delete "/logout/:id", SessionController, :delete
    get "/register", RegistrationController, :new
    post "/register", RegistrationController, :create
    
    # resources "/messages/:channel", MessageController
    
  end

  # Other scopes may use custom stacks.
  # scope "/api", Slack do
  #   pipe_through :api
  # end
end
