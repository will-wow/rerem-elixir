defmodule Rerem.Repo.Migrations.AddIvToNote do
  use Ecto.Migration

  def change do
    alter table(:notes) do
      add(:iv, :text)
    end

  end
end
