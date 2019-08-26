defmodule Rerem.User do
  alias Rerem.Repo
  alias Rerem.Schema.User
  alias Rerem.Note

  def get(params) do
    User
    |> Repo.get(params["username"])
    |> Bcrypt.check_pass(params["password"])
  end

  def create_user(params) do
    Repo.transaction(fn ->
      note = Note.create!(params)

      note
      |> Ecto.build_assoc(:user)
      |> User.changeset(params)
      |> Repo.insert!()
    end)
  end
end
