defmodule MicroblogWeb.PageControllerTest do
  use MicroblogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Listing User"
  end
end
