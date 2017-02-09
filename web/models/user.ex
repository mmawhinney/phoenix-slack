defmodule Slack.User do
  use Slack.Web, :model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :username, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    
    timestamps
  end
  
  @required [:first_name, :last_name, :username, :email]
  
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:username, min: 1, max: 30)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
  end
  
end
