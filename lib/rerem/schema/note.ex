defmodule Rerem.Schema.Note do
  use Rerem.Schema

  schema "notes" do
    field :body, :string
    field :iv, :string
    field :view_key_hash, :string
    field :edit_key_hash, :string
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:body, :iv, :view_key_hash, :edit_key_hash])
    |> validate_required([:body, :iv, :view_key_hash, :edit_key_hash])
    |> validate_length(:body, count: :bytes, max: 2000)
  end

  def to_json(%__MODULE__{id: id, body: body, iv: iv}) do
    %{
      id: id,
      body: body,
      iv: iv
    }
  end
end
