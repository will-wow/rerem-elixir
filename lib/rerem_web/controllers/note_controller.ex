defmodule ReremWeb.NoteController do
  use ReremWeb, :controller

  alias Rerem.Repo
  alias Rerem.Note
  alias Rerem.Schema.Note, as: Schema

  def lookup(conn, %{"note" => %{"id" => id}}) do
    case Note.get(id) do
      {:ok, note} ->
        render_json(conn, note)

      {:error, error} ->
        conn
        |> put_status(404)
        |> json(%{errors: error})
    end
  end

  def create(conn, %{"note" => params}) do
    case Note.create(params) do
      {:ok, note} ->
        conn
        |> render_json(201, note)

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_status(404)
        |> json(changeset.errors)
    end
  end

  def update(conn, %{"note" => params}) do
    case Note.update(params) do
      {:ok, note} ->
        conn
        |> render_json(201, note)

      {:error, errors} ->
        conn
        |> put_status(400)
        |> json(%{errors: errors})
    end
  end

  def render_json(conn, status \\ 200, note) do
    data = Schema.to_json(note)

    conn
    |> put_status(status)
    |> json(data)
  end
end
