defmodule ReremWeb.Router do
  use ReremWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReremWeb do
    pipe_through :api

    resources "/users", NoteController, only: [:show, :create]

    resources "/notes", NoteController, only: [:show, :create, :update]
  end
end
