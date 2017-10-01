defmodule Microblog.MicroBlog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.User


  schema "user" do
    field :email, :string
    field :first_name, :string
    field :handle, :string
    field :last_name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :handle, :first_name, :last_name])
    |> validate_required([:email, :handle, :first_name, :last_name])
  end
end
