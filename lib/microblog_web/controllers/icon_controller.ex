defmodule MicroblogWeb.IconController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog

  def create(conn, %{"icon" => icon_params}) do
    IO.inspect(icon_params["icon"])
    user_id = get_session(conn, :user_id)
    user = MicroBlog.get_user!(user_id)
    case MicroBlog.update_user(user,%{:icon => icon_params["icon"]}) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Icon Updated")
        |> redirect(to: user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        conn
        |> put_flash(:info, "Icon Failed")
        |> redirect(to: user_path(conn, :show, user))
    end
    # with {:ok, icon} <- MicroBlog.create_icon(icon_params) do
    conn
    |> redirect(to: user_path(conn, :show, user))
    # end
  end
end
