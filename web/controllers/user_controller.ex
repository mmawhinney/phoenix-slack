defmodule Slack.UserController do
  
  use Slack.Web, :controller
  
  def index(conn, _params) do
    users = Repo.all(Slack.User)
    render conn, "index.html", users: users
  end
  
end