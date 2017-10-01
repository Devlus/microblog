defmodule MicroblogWeb.StalkController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.Stalk

  def index(conn, _params) do
    stalk = MicroBlog.list_stalk()
    render(conn, "index.html", stalk: stalk)
  end

  def new(conn, _params) do
    changeset = MicroBlog.change_stalk(%Stalk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stalk" => stalk_params}) do
    case MicroBlog.create_stalk(stalk_params) do
      {:ok, stalk} ->
        conn
        |> put_flash(:info, "Stalk created successfully.")
        |> redirect(to: stalk_path(conn, :show, stalk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stalk = MicroBlog.get_stalk!(id)
    render(conn, "show.html", stalk: stalk)
  end

  def edit(conn, %{"id" => id}) do
    stalk = MicroBlog.get_stalk!(id)
    changeset = MicroBlog.change_stalk(stalk)
    render(conn, "edit.html", stalk: stalk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stalk" => stalk_params}) do
    stalk = MicroBlog.get_stalk!(id)

    case MicroBlog.update_stalk(stalk, stalk_params) do
      {:ok, stalk} ->
        conn
        |> put_flash(:info, "Stalk updated successfully.")
        |> redirect(to: stalk_path(conn, :show, stalk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stalk: stalk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stalk = MicroBlog.get_stalk!(id)
    {:ok, _stalk} = MicroBlog.delete_stalk(stalk)

    conn
    |> put_flash(:info, "Stalk deleted successfully.")
    |> redirect(to: stalk_path(conn, :index))
  end
end
