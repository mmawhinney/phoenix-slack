defmodule Slack.SessionController do
  use Slack.Web, :controller
  
  def new(conn, _params) do
    render conn, "new.html"
  end
  
  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case Slack.Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} -> 
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end
end