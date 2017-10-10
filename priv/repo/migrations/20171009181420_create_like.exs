defmodule Microblog.Repo.Migrations.CreateLike do
  use Ecto.Migration

  def change do
    create table(:like) do
      add :post_id, references(:meow, on_delete: :nothing)
      add :actor_id, references(:user, on_delete: :nothing)

      timestamps()
    end

    create index(:like, [:post_id])
    create index(:like, [:actor_id])
  end
end
