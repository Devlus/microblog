defmodule Microblog.Repo.Migrations.AddIconToUser do
  use Ecto.Migration

  def change do
    alter table("user") do
      add :icon, :string
    end

      
  end
end
