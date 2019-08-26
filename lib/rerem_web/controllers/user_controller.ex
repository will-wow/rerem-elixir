defmodule ReremWeb.UserController do
  use ReremWeb, :controller

  alias Rerem.User
  alias Rerem.Schema.User, as: Schema

  def create(conn, params) do
    case User.create_user(params) do
      {:ok, user} ->
        render_json(conn, user)

      {:error, changeset} ->
        conn
        |> put_status(404)
        |> json(%{errors: changeset.errors})
    end
  end

  def show(conn, params) do
    case User.get(params) do
      {:ok, user} ->
        render_json(conn, user)

      {:error, error} ->
        conn
        |> put_status(404)
        |> json(%{errors: error})
    end
  end

  defp render_json(conn, status \\ 200, note) do
    data = Schema.to_json(note)

    conn
    |> put_status(status)
    |> json(data)
  end
end
