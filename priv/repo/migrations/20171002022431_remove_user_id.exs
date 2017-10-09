defmodule Microblog.Repo.Migrations.RemoveUserId do
  use Ecto.Migration

  def change do
    alter table("meow") do
      remove :user_id
    end
  end
end
