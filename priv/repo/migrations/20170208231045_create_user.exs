defmodule Slack.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :username, :string, null: false
      add :email, :string
      add :password_hash, :string
      
      timestamps
    end
    
    create unique_index(:users, [:username])
  end
end
