defmodule Slack.RoomChannel do
  use Slack.Web, :channel
  alias Slack.PostView

  def join("room:1", _params, socket) do
    posts = Repo.all(
      from p in Slack.Post,
      order_by: [asc: p.inserted_at],
      preload: [:user]
    )
    resp = %{posts: Phoenix.View.render_many(posts, PostView, "post.json")}
    {:ok, resp, assign(socket, :room_id, 1)}
  end

  def handle_in("new_message", params, socket) do
    user = Repo.get(Slack.User, socket.assigns.user_id)
    changeset =
      user
      |> build_assoc(:posts)
      |> Slack.Post.changeset(params)

    case Repo.insert(changeset) do
      {:ok, post} ->
        broadcast_post(socket, post)
        {:reply, :ok, socket}
      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  def broadcast_post(socket, post) do
    new_post = Repo.preload(post, :user)
    rendered_post = PostView.render("post.json", %{post: new_post})
    broadcast! socket, "new_message", rendered_post
  end

end
