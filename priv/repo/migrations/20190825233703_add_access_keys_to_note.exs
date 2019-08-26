defmodule Rerem.Repo.Migrations.AddAccessKeysToNote do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add(:view_key_hash, :text)
      add(:edit_key_hash, :text)
    end
  end
end
