defmodule Microblog.MicroBlog.Meow do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.Meow


  schema "meow" do
    field :content, :string
    field :posted_dttm, :utc_datetime
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Meow{} = meow, attrs) do
    meow
    |> cast(attrs, [:user_id, :content, :posted_dttm])
    |> validate_required([:user_id, :content, :posted_dttm])
  end
end
