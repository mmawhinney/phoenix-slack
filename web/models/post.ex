defmodule Slack.Post do
  use Slack.Web, :model


  schema "posts" do
    field :body, :string
    belongs_to :user, Slack.User

    timestamps()
  end

  @required [:body]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required)
    |> validate_required(@required)
  end

end