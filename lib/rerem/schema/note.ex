defmodule Rerem.Schema.Note do
  use Rerem.Schema

  alias Rerem.Schema.User

  schema "notes" do
    field :body, :string
    field :view_key_hash, :string
    field :edit_key_hash, :string
    has_one :user, User, foreign_key: :directory_id
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:body, :view_key_hash, :edit_key_hash])
    |> validate_required([:body, :view_key_hash, :edit_key_hash])
    |> validate_length(:body, count: :bytes, max: 2000)
  end

  @spec to_json(Rerem.Schema.Note.t()) :: %{body: any, id: any}
  def to_json(%__MODULE__{id: id, body: body}) do
    %{
      id: id,
      body: body
    }
  end
end
