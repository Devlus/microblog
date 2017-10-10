defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.Like

  action_fallback MicroblogWeb.FallbackController

  def index(conn, _params) do
    like = MicroBlog.list_like()
    render(conn, "index.json", like: like)
  end

  def create(conn, %{"like" => like_params}) do
    likers = MicroBlog.get_like_by_post(like_params["post_id"])
    IO.inspect(likers)
    if(Enum.any?(likers,fn(x)-> x.actor_id == String.to_integer(like_params["actor_id"]) end)) do
      like = Enum.find(likers,fn(x)-> x.actor_id == String.to_integer(like_params["actor_id"]) end)
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("like.json", like: like)
    else
      with {:ok, %Like{} = like} <- MicroBlog.create_like(like_params) do
        conn
        |> put_status(:created)
        |> put_resp_header("location", like_path(conn, :show, like))
        |> render("like.json", like: like)
      end
    end
  end

  def show(conn, %{"id" => post_id}) do
    IO.puts(post_id)
    like = MicroBlog.get_like_by_post(post_id)
    render(conn, "index.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = MicroBlog.get_like!(id)

    with {:ok, %Like{} = like} <- MicroBlog.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = MicroBlog.get_like!(id)
    with {:ok, %Like{}} <- MicroBlog.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end
end
