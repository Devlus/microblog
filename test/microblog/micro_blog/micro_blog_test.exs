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
end
