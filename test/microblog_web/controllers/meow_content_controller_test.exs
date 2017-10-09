defmodule MicroblogWeb.MeowContentControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.MicroBlog

  @create_attrs %{content: "some content"}
  @update_attrs %{content: "some updated content"}
  @invalid_attrs %{content: nil}

  def fixture(:meow_content) do
    {:ok, meow_content} = MicroBlog.create_meow_content(@create_attrs)
    meow_content
  end

  describe "index" do
    test "lists all meow_content", %{conn: conn} do
      conn = get conn, meow_content_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Meow content"
    end
  end

  describe "new meow_content" do
    test "renders form", %{conn: conn} do
      conn = get conn, meow_content_path(conn, :new)
      assert html_response(conn, 200) =~ "New Meow content"
    end
  end

  describe "create meow_content" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, meow_content_path(conn, :create), meow_content: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == meow_content_path(conn, :show, id)

      conn = get conn, meow_content_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Meow content"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, meow_content_path(conn, :create), meow_content: @invalid_attrs
      assert html_response(conn, 200) =~ "New Meow content"
    end
  end

  describe "edit meow_content" do
    setup [:create_meow_content]

    test "renders form for editing chosen meow_content", %{conn: conn, meow_content: meow_content} do
      conn = get conn, meow_content_path(conn, :edit, meow_content)
      assert html_response(conn, 200) =~ "Edit Meow content"
    end
  end

  describe "update meow_content" do
    setup [:create_meow_content]

    test "redirects when data is valid", %{conn: conn, meow_content: meow_content} do
      conn = put conn, meow_content_path(conn, :update, meow_content), meow_content: @update_attrs
      assert redirected_to(conn) == meow_content_path(conn, :show, meow_content)

      conn = get conn, meow_content_path(conn, :show, meow_content)
      assert html_response(conn, 200) =~ "some updated content"
    end

    test "renders errors when data is invalid", %{conn: conn, meow_content: meow_content} do
      conn = put conn, meow_content_path(conn, :update, meow_content), meow_content: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Meow content"
    end
  end

  describe "delete meow_content" do
    setup [:create_meow_content]

    test "deletes chosen meow_content", %{conn: conn, meow_content: meow_content} do
      conn = delete conn, meow_content_path(conn, :delete, meow_content)
      assert redirected_to(conn) == meow_content_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, meow_content_path(conn, :show, meow_content)
      end
    end
  end

  defp create_meow_content(_) do
    meow_content = fixture(:meow_content)
    {:ok, meow_content: meow_content}
  end
end
