defmodule ReremWeb.Router do
  use ReremWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ReremWeb do
    pipe_through :api
  end
end
