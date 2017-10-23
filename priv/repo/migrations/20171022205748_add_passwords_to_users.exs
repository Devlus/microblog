defmodule Microblog.Repo.Migrations.AddPasswordsToUsers do
  use Ecto.Migration
  #From Nat's lecture notes
  def change do
    alter table("user") do
      add :password_hash, :string
      add :pw_tries, :integer, null: false, default: 0
      add :pw_last_try, :utc_datetime
    end
  end
end
