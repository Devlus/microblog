defmodule MicroblogWeb.MeowControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.MicroBlog

  @create_attrs %{content: "some content", posted_dttm: "2010-04-17 14:00:00.000000Z", user_id: 42}
  @update_attrs %{content: "some updated content", posted_dttm: "2011-05-18 15:01:01.000000Z", user_id: 43}
  @invalid_attrs %{content: nil, posted_dttm: nil, user_id: nil}

  def fixture(:meow) do
    {:ok, meow} = MicroBlog.create_meow(@create_attrs)
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
      conn = post conn, meow_path(conn, :create), meow: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == meow_path(conn, :show, id)

      conn = get conn, meow_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Meow"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, meow_path(conn, :create), meow: @invalid_attrs
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
      conn = put conn, meow_path(conn, :update, meow), meow: @update_attrs
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
