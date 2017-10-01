defmodule MicroblogWeb.UserController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.User

  def index(conn, _params) do
    user = MicroBlog.list_user()
    render(conn, "index.html", user: user)
  end

  def new(conn, _params) do
    changeset = MicroBlog.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case MicroBlog.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = MicroBlog.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = MicroBlog.get_user!(id)
    changeset = MicroBlog.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = MicroBlog.get_user!(id)

    case MicroBlog.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = MicroBlog.get_user!(id)
    {:ok, _user} = MicroBlog.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
