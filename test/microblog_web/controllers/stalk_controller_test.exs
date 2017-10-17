defmodule MicroblogWeb.StalkControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.MicroBlog

  def valid_attrs_stalk() do
    {:ok, actor} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"}) 
    {:ok, target} = MicroBlog.create_user(%{email: "b@a.com", handle: "c", first_name: "b", last_name: "d"})
    %{actor_id: actor.id, target_id: target.id}
  end
  @update_attrs %{}

  def fixture(:stalk) do
    {:ok, stalk} = MicroBlog.create_stalk(valid_attrs_stalk())
    stalk
  end

  describe "index" do
    test "lists all stalk", %{conn: conn} do
      conn = get conn, stalk_path(conn, :index)
      #User is not logged in so redirect to users
      assert html_response(conn, 302)
    end
  end

  describe "new stalk" do
    test "renders form", %{conn: conn} do
      conn = get conn, stalk_path(conn, :new)
      assert html_response(conn, 200) =~ "New Stalk"
    end
  end

  describe "create stalk" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, stalk_path(conn, :create), stalk: valid_attrs_stalk()

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == stalk_path(conn, :show, id)

      conn = get conn, stalk_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Stalk"
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, stalk_path(conn, :create), stalk: @invalid_attrs
      assert html_response(conn, 200) =~ "New Stalk"
    end
  end

  describe "edit stalk" do
    setup [:create_stalk]

    test "renders form for editing chosen stalk", %{conn: conn, stalk: stalk} do
      conn = get conn, stalk_path(conn, :edit, stalk)
      assert html_response(conn, 200) =~ "Edit Stalk"
    end
  end

  describe "update stalk" do
    setup [:create_stalk]

    test "redirects when data is valid", %{conn: conn, stalk: stalk} do
      conn = put conn, stalk_path(conn, :update, stalk), stalk: @update_attrs
      assert redirected_to(conn) == stalk_path(conn, :show, stalk)

      conn = get conn, stalk_path(conn, :show, stalk)
      assert html_response(conn, 200)
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, stalk: stalk} do
      conn = put conn, stalk_path(conn, :update, stalk), stalk: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Stalk"
    end
  end

  describe "delete stalk" do
    setup [:create_stalk]

    test "deletes chosen stalk", %{conn: conn, stalk: stalk} do
      conn = delete conn, stalk_path(conn, :delete, stalk)
      assert redirected_to(conn) == stalk_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, stalk_path(conn, :show, stalk)
      end
    end
  end

  defp create_stalk(_) do
    stalk = fixture(:stalk)
    {:ok, stalk: stalk}
  end
end
