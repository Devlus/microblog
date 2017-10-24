defmodule MicroblogWeb.MeowController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.Meow

  def index(conn, _params) do
    IO.puts("Got here")
    IO.inspect(_params)
    meow = MicroBlog.search_meow(_params["term"])
    IO.inspect(meow)
    render(conn, "index.html", meow: meow)
  end

  def new(conn, _params) do
    changeset = MicroBlog.change_meow(%Meow{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"meow_vm" => meow_params}) do
    # IO.puts meow_params
    case MicroBlog.create_meow(meow_params) do
      {:ok, meow} ->
        conn
        |> put_flash(:info, "Meow created successfully.")
        |> redirect(to: user_path(conn, :show, meow_params["author_id"]))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    meow = MicroBlog.get_meow!(id)
    render(conn, "show.html", meow: meow)
  end

  def edit(conn, %{"id" => id}) do
    meow = MicroBlog.get_meow!(id)
    changeset = MicroBlog.change_meow(meow)
    render(conn, "edit.html", meow: meow, changeset: changeset)
  end

  def update(conn, %{"id" => id, "meow" => meow_params}) do
    meow = MicroBlog.get_meow!(id)

    case MicroBlog.update_meow(meow, meow_params) do
      {:ok, meow} ->
        conn
        |> put_flash(:info, "Meow updated successfully.")
        |> redirect(to: meow_path(conn, :show, meow))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", meow: meow, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    meow = MicroBlog.get_meow!(id)
    {:ok, _meow} = MicroBlog.delete_meow(meow)

    conn
    |> put_flash(:info, "Meow deleted successfully.")
    |> redirect(to: meow_path(conn, :index))
  end
end
