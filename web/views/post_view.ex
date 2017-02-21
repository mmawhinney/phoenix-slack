defmodule Slack.PostView do
  use Slack.Web, :view

  def render("post.json", %{post: post}) do
    %{
      id: post.id,
      body: post.body,
      user: render_one(post.user, Slack.UserView, "user.json")
    }
  end
end