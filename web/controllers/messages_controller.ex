defmodule Slack.MessagesController do
  use Slack.Web, :controller
  plug :authenticate_user when action in [:index]

  alias Slack.User

  def index(conn, _params) do
    changeset = User.changeset(%User{})
    render conn, "index.html", changeset: changeset
  end
end