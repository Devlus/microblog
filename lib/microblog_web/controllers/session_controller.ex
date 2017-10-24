defmodule MicroblogWeb.SessionController do
  @doc """
  Taken from Nat's Lecture Notes
  http://www.ccs.neu.edu/home/ntuck/courses/2017/09/cs4550/notes/06-finish-cart/notes.html
  """
    use MicroblogWeb, :controller
  
    alias Microblog.MicroBlog
  
    def login(conn, %{"user" => %{"email" => email, "password"=>password}}) do
      IO.puts "Attempting to login: "<>email
      IO.puts "Attempting to login: "<>password
      user = MicroBlog.get_and_auth_user(email, password)
  
      if user do
        conn
        |> put_session(:user_id, user.id)
        |> put_flash(:info, "Logged in as #{user.email}")
        |> redirect(to: user_path(conn, :show, user.id))
      else
        conn
        |> put_session(:user_id, nil)
        |> put_flash(:error, "Login Failed, please check your credentials")
        |> redirect(to: user_path(conn, :index))
      end
    end
  
    def logout(conn, _params) do
      IO.puts "Attempting to logout"
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:info, "Logged out")
      |> redirect(to: user_path(conn, :index))
    end
  end