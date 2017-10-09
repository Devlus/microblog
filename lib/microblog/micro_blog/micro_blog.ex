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

  def get_meows_to_display_for_user(user_id) do
    # select * from Public.meow as m
    # where author_id = 1
    # union all
    # select * from public.meow as m
    # where author_id =  ANY(
    # select target_id from stalk
    # where actor_id = 1)

    stalking = Microblog.MicroBlog.Stalk
        |> where([s], s.actor_id == ^user_id)
        |> select([s], s.target_id)
    
    l = Repo.all(stalking)
    l = List.flatten(l,[user_id])
    meows = Meow 
            |> where([m], m.author_id in ^l)
            |> order_by([m],[desc: m.inserted_at])
            |> preload([:author])
            |> Repo.all
    

    # query1 = from m in "meow",
    #     where: m.author_id = ^user_id,
    #     select: %{:content => c.content,
    #     :author => %{:handle => u.handle,
    #                :first_name => u.first_name,
    #                :last_name => u.last_name}}
    # query2 =                   
    #     from m in "meow"
    #     where: author_id = any(from s in "stalk",
    #     where: actor_id = ^user_id,
    #     select: {m.target_id}),
    #     order_by: [desc: m.inserted_at],
    #     select: %{:content => c.content,
    #      :author => %{:handle => u.handle,
    #                 :first_name => u.first_name,
    #                 :last_name => u.last_name}}



#     query = from m in "meow",
#     join: c in "meow_content", where: c.id == m.content_id,
#     join: u in "user", where: u.id == m.author_id,
#     join: s in "stalk", where: s.actor_id == u.id
#     where: m.author_id == ^user_id,
#     order_by: [desc: m.inserted_at],
#     select: %{:content => c.content,
#      :author => %{:handle => u.handle,
#                 :first_name => u.first_name,
#                 :last_name => u.last_name}}
    # Repo.all(query0)
  end

  @doc """
  Creates a meow.

  ## Examples

      iex> create_meow(%{field: value})
      {:ok, %Meow{}}

      iex> create_meow(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
#   def create_meow(attrs \\ %{}) do
#     %Meow{}
#     |> Meow.changeset(attrs)
#     |> Repo.insert()
#   end
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
  Taken from Nat's Lecture Notes
  http://www.ccs.neu.edu/home/ntuck/courses/2017/09/cs4550/notes/06-finish-cart/notes.html
 """
  def get_user_by_email(email) do
    Repo.get_by(User, email: email)
  end


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

  alias Microblog.MicroBlog.Stalk


  def list_stalks_by_actor(actor) do
    # Stalk 
    # |> where([s],s.actor_id == ^actor)
    # # |> preload([:target])
    # |> Repo.all
    from(s in Stalk, where: s.actor_id == ^actor)
    |> preload([:target])
    |> Repo.all
  end

  def unstalk(actor, target)do
    stalk = Stalk
            |> where([s],s.actor_id == ^actor and s.target_id == ^target)
    stalk = Repo.one(stalk)
    delete_stalk(stalk)
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
