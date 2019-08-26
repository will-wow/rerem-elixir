defmodule Rerem.Schema.User do
  use Rerem.Schema

  alias Rerem.Schema.Note

  schema "users" do
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    belongs_to :directory, Note
  end

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, [:username, :password])
    |> validate_required([:username, :password])
    |> hash_password()
  end

  def to_json(user) do
    %{
      username: user.username,
      directory_id: user.directory_id
    }
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        change(changeset, Bcrypt.add_hash(password))

      _ ->
        changeset
    end
  end
end
