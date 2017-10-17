defmodule MicroblogWeb.UpdatesChannel do
  use MicroblogWeb, :channel

  def join("updates:"<>user_id, payload, socket) do
    if authorized?(payload) do
      {:ok, assign(socket, :user_id, user_id)}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end
  def shape_update(meow) do
    %{"content" => meow.content, "id"=> meow.id, "author" =>
     %{"id"=>meow.author.id,
      "first"=>meow.author.first_name,
      "last"=>meow.author.last_name,
      "handle"=>meow.author.handle}}
  end
  def handle_in("pull", payload, socket) do
    int_id = String.to_integer(socket.assigns[:user_id])
    posts = Enum.map(Microblog.MicroBlog.get_meows_to_display_for_user(int_id), &shape_update/1)
    broadcast socket, "posts", %{posts: posts}
    {:noreply, socket}
  end

  def handle_in("post_created", payload, socket) do
    int_id = String.to_integer(socket.assigns[:user_id])
    posts = Enum.map(Microblog.MicroBlog.get_meows_to_display_for_user(int_id), &shape_update/1)
    broadcast socket, "posts", %{posts: posts}

    {:noreply, socket}
  end


  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (updates:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
