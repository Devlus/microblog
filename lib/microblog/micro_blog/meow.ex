defmodule Microblog.MicroBlog.Meow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.Meow


  schema "meow" do
    belongs_to(:author, Microblog.MicroBlog.User)
    field :content, :string
    # field :content_id, :id
    # field :author_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Meow{} = meow, attrs) do
    meow
    |> cast(attrs, [:author_id, :content])
    |> foreign_key_constraint(:author_id)
    |> validate_required([:author_id, :content])
  end
end
