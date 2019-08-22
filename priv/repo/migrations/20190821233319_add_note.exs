defmodule Rerem.Repo.Migrations.AddNote do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add(:body, :text)
    end
  end
end
