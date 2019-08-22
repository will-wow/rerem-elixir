defmodule Rerem.Schema.Note do
  use Rerem.Schema

  schema "notes" do
    field :body, :string
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:body, :view_password_hash, :edit_password_hash])
    |> validate_required([:body, :view_password_hash, :edit_password_hash])
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
