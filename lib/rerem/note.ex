defmodule Rerem.Note do
  alias Rerem.Schema.Note
  alias Rerem.Repo

  def get(params) do
    with {:ok, note} <- find(Note, params["id"]),
         {:ok, note} <- can_view?(note, params) do
      {:ok, note}
    else
      error -> error
    end
  end

  def create(params) do
    %Note{}
    |> Note.changeset(params)
    |> Repo.insert()
  end

  def update(params) do
    with {:ok, note} <- find(Note, params["id"]),
         {:ok, note} <- can_view?(note, params),
         {:ok, note} <- can_edit?(note, params),
         {:ok, note} <-
           note
           |> Note.changeset(params)
           |> Repo.update() do
      {:ok, note}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        changeset.errors

      {:error, error} ->
        error
    end
  end

  def find(queryable, id, opts \\ []) do
    with {:ok, _} <- Ecto.UUID.cast(id),
         data when not is_nil(data) <- Repo.get(queryable, id, opts) do
      {:ok, data}
    else
      _ -> {:error, :not_found}
    end
  end

  def can_view?(note, params) do
    Bcrypt.check_pass(note, params["view_password"], hash_key: :view_password_hash)
  end

  def can_edit?(note, params) do
    Bcrypt.check_pass(note, params["edit_password"], hash_key: :edit_password_hash)
  end
end
