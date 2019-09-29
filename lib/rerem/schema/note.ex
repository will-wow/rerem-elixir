defmodule Rerem.Schema.Note do
  use Rerem.Schema

  schema "notes" do
    field :body, :string
    field :iv, :string
    field :view_key, :string, virtual: true
    field :edit_key, :string, virtual: true
    field :view_key_hash, :string
    field :edit_key_hash, :string
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:body, :iv, :view_key, :edit_key])
    |> validate_length(:body, count: :bytes, max: 2000)
    |> put_pass_hash(:view_key, :view_key_hash)
    |> put_pass_hash(:edit_key, :edit_key_hash)
    |> validate_required([:body, :iv, :view_key_hash, :edit_key_hash])
  end

  def to_json(%__MODULE__{id: id, body: body, iv: iv}) do
    %{
      id: id,
      body: body,
      iv: iv
    }
  end

  defp put_pass_hash(
         changeset = %Ecto.Changeset{valid?: true, changes: changes},
         password_field,
         hash_field
       ) do
    case Map.get(changes, password_field) do
      nil ->
        changeset

      password ->
        change(changeset, %{hash_field => Bcrypt.hash_pwd_salt(password)})
    end
  end

  defp put_pass_hash(changeset, _, _) do
    changeset
  end
end
