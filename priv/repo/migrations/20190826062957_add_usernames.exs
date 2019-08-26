defmodule Rerem.Repo.Migrations.AddUsernames do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:username, :text)
      add(:password_hash, :text)
      add(:directory_id, references(:notes))
    end

    create unique_index(:users, [:username])
  end
end
