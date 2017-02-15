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
  
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, @required)
    |> validate_required(@required)
    |> validate_length(:username, min: 1, max: 30)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:username)
  end
  
  @reg_required [:first_name, :last_name, :email, :password, :username]
  
  def registration_changeset(model, params \\ :invalid) do
    model
    |> changeset(params)
    |> cast(params, @reg_required)
    |> validate_required(@reg_required)
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end
  
  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> 
        changeset
    end
  end
  
end
