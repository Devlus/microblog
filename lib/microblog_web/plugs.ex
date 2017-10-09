defmodule MicroblogWeb.Plugs do
  import Plug.Conn

  @doc """
  Taken from Nat's Lecture Notes
  http://www.ccs.neu.edu/home/ntuck/courses/2017/09/cs4550/notes/06-finish-cart/notes.html
  """
  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = Microblog.MicroBlog.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end
end