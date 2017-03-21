defmodule Slack.PageController do
  use Slack.Web, :controller

  def index(conn, _params) do
    redirect conn, to: "/messages"
  end
end
