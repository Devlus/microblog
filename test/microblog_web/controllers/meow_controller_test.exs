defmodule MicroblogWeb.MeowControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.MicroBlog

  def valid_attrs_meow() do
    {:ok, user} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"})
    %{content: "some content", author_id: user.id}
  end

  @create_attrs %{content: "some content", author_id: 42}
  @update_attrs %{content: "some updated content", author_id: 43}
  @invalid_attrs %{content: nil, author_id: nil}

  def valid_attrs_meow() do
    {:ok, user} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"})
    %{content: "some content", author_id: user.id}
  end

  def fixture(:meow) do
    {:ok, meow} = MicroBlog.create_meow(valid_attrs_meow())
    meow
  end

  describe "index" do
    test "lists all meow", %{conn: conn} do
      conn = get conn, meow_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Meow"
    end
  end

  describe "new meow" do
    test "renders form", %{conn: conn} do
      conn = get conn, meow_path(conn, :new)
      assert html_response(conn, 200) =~ "New Meow"
    end
  end

  describe "create meow" do
    test "redirects to show when data is valid", %{conn: conn} do
      attrs = valid_attrs_meow()
      conn = post conn, meow_path(conn, :create), meow_vm: attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == user_path(conn, :show, attrs.author_id)

      conn = get conn, user_path(conn, :show, attrs.author_id)
      assert html_response(conn, 200) =~ "some content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      invalid = %{}
      conn = post conn, meow_path(conn, :create), meow_vm: @invalid_attrs
      assert html_response(conn, 200) =~ "New Meow"
    end
  end

  describe "edit meow" do
    setup [:create_meow]

    test "renders form for editing chosen meow", %{conn: conn, meow: meow} do
      conn = get conn, meow_path(conn, :edit, meow)
      assert html_response(conn, 200) =~ "Edit Meow"
    end
  end

  describe "update meow" do
    setup [:create_meow]

    test "redirects when data is valid", %{conn: conn, meow: meow} do
      update_attrs = %{author_id: meow.author_id, content: "some updated content"}
      conn = put conn, meow_path(conn, :update, meow), meow: update_attrs
      assert redirected_to(conn) == meow_path(conn, :show, meow)

      conn = get conn, meow_path(conn, :show, meow)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, meow: meow} do
      conn = put conn, meow_path(conn, :update, meow), meow: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Meow"
    end
  end

  describe "delete meow" do
    setup [:create_meow]

    test "deletes chosen meow", %{conn: conn, meow: meow} do
      conn = delete conn, meow_path(conn, :delete, meow)
      assert redirected_to(conn) == meow_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, meow_path(conn, :show, meow)
      end
    end
  end

  defp create_meow(_) do
    meow = fixture(:meow)
    {:ok, meow: meow}
  end
end
