defmodule Microblog.MicroBlog do
  @moduledoc """
  The MicroBlog context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.MicroBlog.Meow

  @doc """
  Returns the list of meow.

  ## Examples

      iex> list_meow()
      [%Meow{}, ...]

  """
  def list_meow do
    Repo.all(Meow)
  end

  @doc """
  Gets a single meow.

  Raises `Ecto.NoResultsError` if the Meow does not exist.

  ## Examples

      iex> get_meow!(123)
      %Meow{}

      iex> get_meow!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meow!(id), do: Repo.get!(Meow, id)

  @doc """
  Creates a meow.

  ## Examples

      iex> create_meow(%{field: value})
      {:ok, %Meow{}}

      iex> create_meow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meow(attrs \\ %{}) do
    %Meow{}
    |> Meow.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meow.

  ## Examples

      iex> update_meow(meow, %{field: new_value})
      {:ok, %Meow{}}

      iex> update_meow(meow, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meow(%Meow{} = meow, attrs) do
    meow
    |> Meow.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Meow.

  ## Examples

      iex> delete_meow(meow)
      {:ok, %Meow{}}

      iex> delete_meow(meow)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meow(%Meow{} = meow) do
    Repo.delete(meow)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meow changes.

  ## Examples

      iex> change_meow(meow)
      %Ecto.Changeset{source: %Meow{}}

  """
  def change_meow(%Meow{} = meow) do
    Meow.changeset(meow, %{})
  end
end
