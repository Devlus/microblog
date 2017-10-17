
defmodule MicroblogWeb.LikeControllerTest do
  
  use MicroblogWeb.ConnCase

  alias Microblog.MicroBlog
  alias Microblog.MicroBlog.Like

  def valid_attrs_like do
    {:ok, user} = MicroBlog.create_user(%{email: "a@b.com", handle: "a", first_name: "b", last_name: "c"}) 
    {:ok, meow} = MicroBlog.create_meow(%{author_id: user.id, content: "some content"})
    %{post_id: meow.id, actor_id: user.id}
  end
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:like) do
    {:ok, like} = MicroBlog.create_like(valid_attrs_like())
    like
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end
  describe "index" do
    @tag :skip
    test "lists all like", %{conn: conn} do
      conn = get conn, like_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end
  describe "create like" do
    @tag :skip
    test "renders like when data is valid", %{conn: conn} do
      like = valid_attrs_like()
      conn = post conn, like_path(conn, :create), like: like
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, like_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, like_path(conn, :create), like: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
  describe "update like" do
    setup [:create_like]
    @tag :skip
    test "renders like when data is valid", %{conn: conn, like: %Like{id: id} = like} do
      conn = put conn, like_path(conn, :update, like), like: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, like_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end
    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, like: like} do
      conn = put conn, like_path(conn, :update, like), like: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
  describe "delete like" do
    setup [:create_like]
    
    @tag :skip
    test "deletes chosen like", %{conn: conn, like: like} do
      conn = delete conn, like_path(conn, :delete, like)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, like_path(conn, :show, like)
      end
    end
  end

  defp create_like(_) do
    like = fixture(:like)
    {:ok, like: like}
  end
end
