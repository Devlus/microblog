defmodule Microblog.MicroBlog.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.Like


  schema "like" do
    belongs_to(:post, Microblog.MicroBlog.Meow)
    belongs_to(:actor, Microblog.MicroBlog.User)

    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:actor_id, :post_id])
    |> validate_required([:actor_id, :post_id])
  end
end
