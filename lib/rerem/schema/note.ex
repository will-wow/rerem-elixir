defmodule Rerem.Schema.Note do
  use Rerem.Schema

  @one_mb 1024 * 1024

  schema "notes" do
    field :body, :string
    field :iv, :string
    field :edit_key, :string, virtual: true
    field :edit_key_hash, :string
  end

  def changeset(note, attrs \\ %{}) do
    note
    |> cast(attrs, [:body, :iv, :edit_key])
    |> validate_length(:body, count: :bytes, max: @one_mb)
    |> put_pass_hash(:edit_key, :edit_key_hash)
    |> validate_required([:body, :iv, :edit_key_hash])
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
