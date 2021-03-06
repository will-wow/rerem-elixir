defmodule ReremWeb.NoteController do
  use ReremWeb, :controller

  alias Rerem.Note
  alias Rerem.Schema.Note, as: Schema

  def show(conn, params) do
    case Note.get(params) do
      {:ok, note} ->
        render_json(conn, note)

      {:error, error} ->
        conn
        |> put_status(404)
        |> json(%{errors: error})
    end
  end

  def create(conn, params) do
    case Note.create(params) do
      {:ok, note} ->
        conn
        |> render_json(201, note)

      {:error, changeset} ->
        conn
        |> render_errors(changeset)
    end
  end

  def update(conn, params) do
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

  def delete(conn, params) do
    case Note.delete(params) do
      {:ok, note} ->
        conn
        |> render_json(204, note)

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

  def render_errors(conn, %Ecto.Changeset{valid?: false, errors: errors}) do
    error_data =
      errors
      |> Enum.into(%{}, fn {key, {message, _}} ->
        {key, message}
      end)

    render_errors(conn, error_data)
  end

  def render_errors(conn, errors) do
    conn
    |> put_status(400)
    |> json(errors)
  end
end
