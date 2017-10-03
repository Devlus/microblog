defmodule Microblog.MicroBlog.Stalk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.Stalk


  schema "stalk" do
    belongs_to(:actor, Microblog.MicroBlog.User)
    belongs_to(:target, Microblog.MicroBlog.User)

    timestamps()
  end

  @doc false
  def changeset(%Stalk{} = stalk, attrs) do
    stalk
    |> cast(attrs, [:actor_id, :target_id])
    |> validate_required([:actor_id, :target_id])
  end
end
