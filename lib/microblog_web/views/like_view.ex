defmodule MicroblogWeb.LikeView do
  use MicroblogWeb, :view
  alias MicroblogWeb.LikeView

  def render("index.json", %{like: like}) do
    %{data: render_many(like, LikeView, "likers.json")}
  end

  def render("show.json", %{like: like}) do
    %{data: render_one(like, LikeView, "likers.json")}
  end

  def render("like.json", %{like: like}) do
    %{id: like.id}
  end

  def render("likers.json", %{like: like}) do
    %{id: like.id, actor: %{ id: like.actor.id, handle: like.actor.handle, first: like.actor.first_name, last: like.actor.last_name }}
  end
end
