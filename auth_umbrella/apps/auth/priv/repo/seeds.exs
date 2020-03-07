{:ok, _cs} =
  Auth.UserContext.create_user(%{"password" => "t", "role" => "User", "username" => "user"})

{:ok, _cs} =
  Auth.UserContext.create_user(%{
    "password" => "t",
    "role" => "Manager",
    "username" => "manager"
  })

{:ok, _cs} =
  Auth.UserContext.create_user(%{"password" => "t", "role" => "Admin", "username" => "admin"})