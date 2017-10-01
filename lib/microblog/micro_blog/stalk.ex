defmodule Microblog.MicroBlog.Stalk do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.Stalk


  schema "stalk" do
    field :actor, :id
    field :target, :id

    timestamps()
  end

  @doc false
  def changeset(%Stalk{} = stalk, attrs) do
    stalk
    |> cast(attrs, [])
    |> validate_required([])
  end
end
