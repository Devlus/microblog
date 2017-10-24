defmodule Microblog.MicroBlogTest do
  use Microblog.DataCase
  require Logger
  alias Microblog.MicroBlog

  describe "meow" do
    alias Microblog.MicroBlog.Meow

    def valid_attrs_meow() do
      {:ok, user} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"})
      %{content: "some content", author_id: user.id}
    end
    @update_attrs %{content: "some updated content", posted_dttm: "2011-05-18 15:01:01.000000Z", author_id: 43}
    @invalid_attrs %{content: nil, posted_dttm: nil, author_id: nil}

    def meow_fixture(attrs \\ %{}) do
      {:ok, meow} =
        attrs
        |> Enum.into(valid_attrs_meow())
        |> MicroBlog.create_meow()
      meow
    end

    test "list_meow/0 returns all meow" do
      meow = meow_fixture()
      assert MicroBlog.list_meow() == [meow]
    end

    test "get_meow!/1 returns the meow with given id" do
      meow = meow_fixture()
      assert MicroBlog.get_meow!(meow.id) == meow
    end

    test "create_meow/1 with valid data creates a meow" do
      assert {:ok, %Meow{} = meow} = MicroBlog.create_meow(valid_attrs_meow())
      assert meow.content == "some content"
    end

    test "create_meow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_meow(@invalid_attrs)
    end

    test "update_meow/2 with valid data updates the meow" do
      meow = meow_fixture()
      realValidAttrs = Map.put(@update_attrs, :author_id, meow.author_id)
      IO.inspect realValidAttrs
      assert {:ok, meow} = MicroBlog.update_meow(meow, realValidAttrs)
      assert %Meow{} = meow
      assert meow.content == "some updated content"
    end

    test "update_meow/2 with invalid data returns error changeset" do
      meow = meow_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_meow(meow, @invalid_attrs)
      assert meow == MicroBlog.get_meow!(meow.id)
    end

    test "delete_meow/1 deletes the meow" do
      meow = meow_fixture()
      assert {:ok, %Meow{}} = MicroBlog.delete_meow(meow)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_meow!(meow.id) end
    end

    test "change_meow/1 returns a meow changeset" do
      meow = meow_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_meow(meow)
    end
  end

  describe "user" do
    alias Microblog.MicroBlog.User

    @valid_attrs %{email: "some email", first_name: "some first_name", handle: "some handle", last_name: "some last_name"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", handle: "some updated handle", last_name: "some updated last_name"}
    @invalid_attrs %{email: nil, first_name: nil, handle: nil, last_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MicroBlog.create_user()

      user
    end

    test "list_user/0 returns all user" do
      user = user_fixture()
      assert MicroBlog.list_user() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert MicroBlog.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = MicroBlog.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.handle == "some handle"
      assert user.last_name == "some last_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = MicroBlog.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.handle == "some updated handle"
      assert user.last_name == "some updated last_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_user(user, @invalid_attrs)
      assert user == MicroBlog.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = MicroBlog.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_user(user)
    end
  end
  describe "stalk" do
    require IEx
    alias Microblog.MicroBlog.Stalk

    def valid_attrs_stalk() do
      {:ok, actor} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"}) 
      {:ok, target} = MicroBlog.create_user(%{email: "b@a.com", handle: "c", first_name: "b", last_name: "d"})
      %{actor_id: actor.id, target_id: target.id}
    end

    @invalid_attrs %{actor_id: nil, target_id: nil}
    
    def stalk_fixture(attrs \\ %{}) do
      {:ok, stalk} =
      attrs
      |> Enum.into(valid_attrs_stalk())
      |> MicroBlog.create_stalk()
      stalk
    end

    test "get_stalk!/1 returns the stalk with given id" do
      stalk = stalk_fixture()
      assert MicroBlog.get_stalk!(stalk.id) == stalk
    end

    test "create_stalk/1 with valid data creates a stalk" do
      assert {:ok, %Stalk{} = stalk} = MicroBlog.create_stalk(valid_attrs_stalk())
    end

    test "create_stalk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_stalk(@invalid_attrs)
    end

    test "update_stalk/2 with invalid data returns error changeset" do
      stalk = stalk_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_stalk(stalk, @invalid_attrs)
      assert stalk == MicroBlog.get_stalk!(stalk.id)
    end

    test "delete_stalk/1 deletes the stalk" do
      stalk = stalk_fixture()
      assert {:ok, %Stalk{}} = MicroBlog.delete_stalk(stalk)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_stalk!(stalk.id) end
    end

    test "change_stalk/1 returns a stalk changeset" do
      stalk = stalk_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_stalk(stalk)
    end
  end

  describe "like" do
    alias Microblog.MicroBlog.Like

    def valid_attrs_like do
      {:ok, user} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"}) 
      {:ok, meow} = MicroBlog.create_meow(%{author_id: user.id, content: "some content"})
      %{post_id: meow.id, actor_id: user.id}
    end
    # @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(valid_attrs_like())
        |> MicroBlog.create_like()

      like
    end

    test "list_like/0 returns all like" do
      like = like_fixture()
      assert MicroBlog.list_like() == [like]
    end

    test "get_like!/1 returns the like with given id" do
      like = like_fixture()
      assert MicroBlog.get_like!(like.id) == like
    end

    test "create_like/1 with valid data creates a like" do
      assert {:ok, %Like{} = like} = MicroBlog.create_like(valid_attrs_like())
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, like} = MicroBlog.update_like(like, @update_attrs)
      assert %Like{} = like
    end
    test "delete_like/1 deletes the like" do
      like = like_fixture()
      assert {:ok, %Like{}} = MicroBlog.delete_like(like)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_like!(like.id) end
    end

    test "change_like/1 returns a like changeset" do
      like = like_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_like(like)
    end
  end

  describe "icon" do
    alias Microblog.MicroBlog.Icon

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def icon_fixture(attrs \\ %{}) do
      {:ok, icon} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MicroBlog.create_icon()

      icon
    end

    test "list_icon/0 returns all icon" do
      icon = icon_fixture()
      assert MicroBlog.list_icon() == [icon]
    end

    test "get_icon!/1 returns the icon with given id" do
      icon = icon_fixture()
      assert MicroBlog.get_icon!(icon.id) == icon
    end

    test "create_icon/1 with valid data creates a icon" do
      assert {:ok, %Icon{} = icon} = MicroBlog.create_icon(@valid_attrs)
    end

    test "create_icon/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_icon(@invalid_attrs)
    end

    test "update_icon/2 with valid data updates the icon" do
      icon = icon_fixture()
      assert {:ok, icon} = MicroBlog.update_icon(icon, @update_attrs)
      assert %Icon{} = icon
    end

    test "update_icon/2 with invalid data returns error changeset" do
      icon = icon_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_icon(icon, @invalid_attrs)
      assert icon == MicroBlog.get_icon!(icon.id)
    end

    test "delete_icon/1 deletes the icon" do
      icon = icon_fixture()
      assert {:ok, %Icon{}} = MicroBlog.delete_icon(icon)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_icon!(icon.id) end
    end

    test "change_icon/1 returns a icon changeset" do
      icon = icon_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_icon(icon)
    end
  end
end
