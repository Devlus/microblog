defmodule Microblog.MicroBlog.MeowContent do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.MeowContent


  schema "meow_content" do
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(%MeowContent{} = meow_content, attrs) do
    meow_content
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
