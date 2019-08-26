defmodule Rerem.UserTest do
  use Rerem.DataCase
  alias Rerem.User

  test "create valid user" do
    {:ok, user} =
      User.create_user(%{
        "username" => "alice@example.com",
        "password" => "Password1!",
        "body" => "Secret text",
        "view_key_hash" => "abc",
        "edit_key_hash" => "def"
      })

    # User data is set up
    assert user.username == "alice@example.com"
    assert user.password != "Password1!"

    # User has a directory
    user = Repo.preload(user, [:directory])
    assert user.directory.body == "Secret text"
  end
end
