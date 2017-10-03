defmodule Microblog.Repo.Migrations.DenormalizeMeow do
  use Ecto.Migration

  def change do
    alter table("meow") do
      remove :content
      remove :posted_dttm
      add :content_id, references(:meow_content, on_delete: :nothing)
      add :author_id, references(:user, on_delete: :nothing)
    end
  end
end
