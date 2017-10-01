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

  alias Microblog.MicroBlog.User

  @doc """
  Returns the list of user.

  ## Examples

      iex> list_user()
      [%User{}, ...]

  """
  def list_user do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Microblog.MicroBlog.MeowContent

  @doc """
  Returns the list of meow_content.

  ## Examples

      iex> list_meow_content()
      [%MeowContent{}, ...]

  """
  def list_meow_content do
    Repo.all(MeowContent)
  end

  @doc """
  Gets a single meow_content.

  Raises `Ecto.NoResultsError` if the Meow content does not exist.

  ## Examples

      iex> get_meow_content!(123)
      %MeowContent{}

      iex> get_meow_content!(456)
      ** (Ecto.NoResultsError)

  """
  def get_meow_content!(id), do: Repo.get!(MeowContent, id)

  @doc """
  Creates a meow_content.

  ## Examples

      iex> create_meow_content(%{field: value})
      {:ok, %MeowContent{}}

      iex> create_meow_content(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_meow_content(attrs \\ %{}) do
    %MeowContent{}
    |> MeowContent.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a meow_content.

  ## Examples

      iex> update_meow_content(meow_content, %{field: new_value})
      {:ok, %MeowContent{}}

      iex> update_meow_content(meow_content, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_meow_content(%MeowContent{} = meow_content, attrs) do
    meow_content
    |> MeowContent.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a MeowContent.

  ## Examples

      iex> delete_meow_content(meow_content)
      {:ok, %MeowContent{}}

      iex> delete_meow_content(meow_content)
      {:error, %Ecto.Changeset{}}

  """
  def delete_meow_content(%MeowContent{} = meow_content) do
    Repo.delete(meow_content)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking meow_content changes.

  ## Examples

      iex> change_meow_content(meow_content)
      %Ecto.Changeset{source: %MeowContent{}}

  """
  def change_meow_content(%MeowContent{} = meow_content) do
    MeowContent.changeset(meow_content, %{})
  end

  alias Microblog.MicroBlog.Stalk

  @doc """
  Returns the list of stalk.

  ## Examples

      iex> list_stalk()
      [%Stalk{}, ...]

  """
  def list_stalk do
    Repo.all(Stalk)
  end

  @doc """
  Gets a single stalk.

  Raises `Ecto.NoResultsError` if the Stalk does not exist.

  ## Examples

      iex> get_stalk!(123)
      %Stalk{}

      iex> get_stalk!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stalk!(id), do: Repo.get!(Stalk, id)

  @doc """
  Creates a stalk.

  ## Examples

      iex> create_stalk(%{field: value})
      {:ok, %Stalk{}}

      iex> create_stalk(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stalk(attrs \\ %{}) do
    %Stalk{}
    |> Stalk.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a stalk.

  ## Examples

      iex> update_stalk(stalk, %{field: new_value})
      {:ok, %Stalk{}}

      iex> update_stalk(stalk, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_stalk(%Stalk{} = stalk, attrs) do
    stalk
    |> Stalk.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Stalk.

  ## Examples

      iex> delete_stalk(stalk)
      {:ok, %Stalk{}}

      iex> delete_stalk(stalk)
      {:error, %Ecto.Changeset{}}

  """
  def delete_stalk(%Stalk{} = stalk) do
    Repo.delete(stalk)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking stalk changes.

  ## Examples

      iex> change_stalk(stalk)
      %Ecto.Changeset{source: %Stalk{}}

  """
  def change_stalk(%Stalk{} = stalk) do
    Stalk.changeset(stalk, %{})
  end
end
