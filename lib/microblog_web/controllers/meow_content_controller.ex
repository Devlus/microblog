defmodule MicroblogWeb.MeowContentController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.MeowContent

  def index(conn, _params) do
    meow_content = MicroBlog.list_meow_content()
    render(conn, "index.html", meow_content: meow_content)
  end

  def new(conn, _params) do
    changeset = MicroBlog.change_meow_content(%MeowContent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meow_content" => meow_content_params}) do
    case MicroBlog.create_meow_content(meow_content_params) do
      {:ok, meow_content} ->
        conn
        |> put_flash(:info, "Meow content created successfully.")
        |> redirect(to: meow_content_path(conn, :show, meow_content))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meow_content = MicroBlog.get_meow_content!(id)
    render(conn, "show.html", meow_content: meow_content)
  end

  def edit(conn, %{"id" => id}) do
    meow_content = MicroBlog.get_meow_content!(id)
    changeset = MicroBlog.change_meow_content(meow_content)
    render(conn, "edit.html", meow_content: meow_content, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meow_content" => meow_content_params}) do
    meow_content = MicroBlog.get_meow_content!(id)

    case MicroBlog.update_meow_content(meow_content, meow_content_params) do
      {:ok, meow_content} ->
        conn
        |> put_flash(:info, "Meow content updated successfully.")
        |> redirect(to: meow_content_path(conn, :show, meow_content))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", meow_content: meow_content, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meow_content = MicroBlog.get_meow_content!(id)
    {:ok, _meow_content} = MicroBlog.delete_meow_content(meow_content)

    conn
    |> put_flash(:info, "Meow content deleted successfully.")
    |> redirect(to: meow_content_path(conn, :index))
  end
end
