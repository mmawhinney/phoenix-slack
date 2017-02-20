defmodule Slack.RoomChannel do
  use Slack.Web, :channel

  def join("room:1", _params, socket) do
    {:ok, assign(socket, :room_id, 1)}
  end

  def handle_in("new_message", params, socket) do
#    changeset =
#      user
#      |> build_assoc(:posts)
#      |> Slack.Post.changeset(params)

    changeset = Slack.Post.changeset(%Slack.Post{}, params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        broadcast_post(socket, "new_message", params)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  def broadcast_post(socket, event, params) do
    broadcast! socket, event, %{
      body: params["body"],
      user: %{username: "anon"}
    }
  end

end