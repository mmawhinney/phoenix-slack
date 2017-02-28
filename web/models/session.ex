defmodule Slack.Session do
    
  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Slack.Repo.get(Slack.User, id)
  end

end