defmodule Microblog.MicroBlog.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.MicroBlog.User


  schema "user" do
    field :email, :string
    field :first_name, :string
    field :handle, :string
    field :last_name, :string
    #<From Nat's Lecture Notes>
    field :password_hash, :string
    field :pw_tries, :integer
    field :pw_last_try, :utc_datetime
    field :password, :string, virtual: true
    #</From Nat's Lecture Notes>
    has_many(:meows, Microblog.MicroBlog.Meow)
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :handle, :first_name, :last_name, :password])
    |> validate_required([:email, :handle, :first_name, :last_name, :password])
    #From Nat's Lecture Notes
    |> validate_password(:password)
    |> put_pass_hash()
    |> validate_required([:email, :handle, :first_name, :last_name, :password_hash])
  end
  # Password validation
  # From Comeonin docs (From Nat's Class Notes)
  def validate_password(changeset, field, options \\ []) do
    IO.puts("Got into validate-password")
    validate_change(changeset, field, fn _, password ->
      case valid_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    IO.puts("Saving")
    change(changeset, Comeonin.Argon2.add_hash(password))
  end
  def put_pass_hash(changeset), do: changeset

  def valid_password?(password) when byte_size(password) > 7 do
    IO.puts("Validated")
    {:ok, password}
  end
  def valid_password?(password) do
      IO.puts("Failed"<>Integer.to_string(byte_size(password)))
     {:error, "The password is too short"}
  end
end
