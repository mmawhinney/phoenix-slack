defmodule Slack.Post do
  use Slack.Web, :model


  schema "posts" do
    field :body, :string
    field :at, :integer
    belongs_to :user, Slack.User

    timestamps()
  end

  @required [:body, :at]

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required)
    |> validate_required(@required)
  end

end