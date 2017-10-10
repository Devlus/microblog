defmodule Microblog.MicroBlogTest do
  use Microblog.DataCase

  alias Microblog.MicroBlog

  describe "meow" do
    alias Microblog.MicroBlog.Meow

    @valid_attrs %{content: "some content", posted_dttm: "2010-04-17 14:00:00.000000Z", user_id: 42}
    @update_attrs %{content: "some updated content", posted_dttm: "2011-05-18 15:01:01.000000Z", user_id: 43}
    @invalid_attrs %{content: nil, posted_dttm: nil, user_id: nil}

    def meow_fixture(attrs \\ %{}) do
      {:ok, meow} =
        attrs
        |> Enum.into(@valid_attrs)
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
      assert {:ok, %Meow{} = meow} = MicroBlog.create_meow(@valid_attrs)
      assert meow.content == "some content"
      assert meow.posted_dttm == DateTime.from_naive!(~N[2010-04-17 14:00:00.000000Z], "Etc/UTC")
      assert meow.user_id == 42
    end

    test "create_meow/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_meow(@invalid_attrs)
    end

    test "update_meow/2 with valid data updates the meow" do
      meow = meow_fixture()
      assert {:ok, meow} = MicroBlog.update_meow(meow, @update_attrs)
      assert %Meow{} = meow
      assert meow.content == "some updated content"
      assert meow.posted_dttm == DateTime.from_naive!(~N[2011-05-18 15:01:01.000000Z], "Etc/UTC")
      assert meow.user_id == 43
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

  describe "meow_content" do
    alias Microblog.MicroBlog.MeowContent

    @valid_attrs %{content: "some content"}
    @update_attrs %{content: "some updated content"}
    @invalid_attrs %{content: nil}

    def meow_content_fixture(attrs \\ %{}) do
      {:ok, meow_content} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MicroBlog.create_meow_content()

      meow_content
    end

    test "list_meow_content/0 returns all meow_content" do
      meow_content = meow_content_fixture()
      assert MicroBlog.list_meow_content() == [meow_content]
    end

    test "get_meow_content!/1 returns the meow_content with given id" do
      meow_content = meow_content_fixture()
      assert MicroBlog.get_meow_content!(meow_content.id) == meow_content
    end

    test "create_meow_content/1 with valid data creates a meow_content" do
      assert {:ok, %MeowContent{} = meow_content} = MicroBlog.create_meow_content(@valid_attrs)
      assert meow_content.content == "some content"
    end

    test "create_meow_content/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_meow_content(@invalid_attrs)
    end

    test "update_meow_content/2 with valid data updates the meow_content" do
      meow_content = meow_content_fixture()
      assert {:ok, meow_content} = MicroBlog.update_meow_content(meow_content, @update_attrs)
      assert %MeowContent{} = meow_content
      assert meow_content.content == "some updated content"
    end

    test "update_meow_content/2 with invalid data returns error changeset" do
      meow_content = meow_content_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_meow_content(meow_content, @invalid_attrs)
      assert meow_content == MicroBlog.get_meow_content!(meow_content.id)
    end

    test "delete_meow_content/1 deletes the meow_content" do
      meow_content = meow_content_fixture()
      assert {:ok, %MeowContent{}} = MicroBlog.delete_meow_content(meow_content)
      assert_raise Ecto.NoResultsError, fn -> MicroBlog.get_meow_content!(meow_content.id) end
    end

    test "change_meow_content/1 returns a meow_content changeset" do
      meow_content = meow_content_fixture()
      assert %Ecto.Changeset{} = MicroBlog.change_meow_content(meow_content)
    end
  end

  describe "stalk" do
    alias Microblog.MicroBlog.Stalk

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def stalk_fixture(attrs \\ %{}) do
      {:ok, stalk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> MicroBlog.create_stalk()

      stalk
    end

    test "list_stalk/0 returns all stalk" do
      stalk = stalk_fixture()
      assert MicroBlog.list_stalk() == [stalk]
    end

    test "get_stalk!/1 returns the stalk with given id" do
      stalk = stalk_fixture()
      assert MicroBlog.get_stalk!(stalk.id) == stalk
    end

    test "create_stalk/1 with valid data creates a stalk" do
      assert {:ok, %Stalk{} = stalk} = MicroBlog.create_stalk(@valid_attrs)
    end

    test "create_stalk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_stalk(@invalid_attrs)
    end

    test "update_stalk/2 with valid data updates the stalk" do
      stalk = stalk_fixture()
      assert {:ok, stalk} = MicroBlog.update_stalk(stalk, @update_attrs)
      assert %Stalk{} = stalk
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

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def like_fixture(attrs \\ %{}) do
      {:ok, like} =
        attrs
        |> Enum.into(@valid_attrs)
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
      assert {:ok, %Like{} = like} = MicroBlog.create_like(@valid_attrs)
    end

    test "create_like/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = MicroBlog.create_like(@invalid_attrs)
    end

    test "update_like/2 with valid data updates the like" do
      like = like_fixture()
      assert {:ok, like} = MicroBlog.update_like(like, @update_attrs)
      assert %Like{} = like
    end

    test "update_like/2 with invalid data returns error changeset" do
      like = like_fixture()
      assert {:error, %Ecto.Changeset{}} = MicroBlog.update_like(like, @invalid_attrs)
      assert like == MicroBlog.get_like!(like.id)
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
end
