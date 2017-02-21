defmodule Slack.UserView do
  use Slack.Web, :view

  def render("user.json", %{user: user}) do
    %{id: user.id, username: user.username}
  end

end