defmodule Microblog.Repo.Migrations.CreateMeowContent do
  use Ecto.Migration

  def change do
    create table(:meow_content) do
      add :content, :string

      timestamps()
    end

  end
end
