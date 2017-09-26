defmodule Microblog.Repo.Migrations.CreateMeow do
  use Ecto.Migration

  def change do
    create table(:meow) do
      add :user_id, :integer
      add :content, :text
      add :posted_dttm, :utc_datetime

      timestamps()
    end

  end
end
