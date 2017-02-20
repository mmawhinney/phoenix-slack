defmodule Slack.RoomChannel do
  use Slack.Web, :channel

  def join("room:1", _params, socket) do
    {:ok, assign(socket, :room_id, 1)}
  end

  def handle_in("new_message", params, socket) do
    broadcast! socket, "new_message", %{
      body: params["body"],
      user: %{username: "anon"}
    }

    {:reply, :ok, socket}
  end

end