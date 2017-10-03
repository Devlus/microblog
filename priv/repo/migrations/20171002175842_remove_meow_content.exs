defmodule Microblog.Repo.Migrations.RemoveMeowContent do
  use Ecto.Migration

  def change do
    alter table("meow") do
      remove :content_id
      add :content, :text
    end
    drop table("meow_content")
  end
end
