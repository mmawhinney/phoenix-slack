defmodule Slack.UserController do
  use Slack.Web, :controller
  plug :authenticate_user when action in [:index]
  
  def index(conn, _params) do
    users = Repo.all(Slack.User)
    render conn, "index.html", users: users
  end
  
  # def delete(conn, %{"id" => id}) do
  #   user = Repo.get_by!(Slack.User, id: id)
  #   Repo.delete!(user)
  #   conn
  #   |> put_flash(:info, "Deleted user successfully")
  #   |> redirect(to: user_path(conn, :index))
  # end
  
end