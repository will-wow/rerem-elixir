defmodule Rerem.Note do
  alias Rerem.Schema.Note
  alias Rerem.Repo

  def get(id) do
    find(Note, id)
  end

  def create(params) do
    %Note{}
    |> Note.changeset(params)
    |> Repo.insert()
  end

  def update(params) do
    with {:ok, note} <- find(Note, params["id"]),
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
end
