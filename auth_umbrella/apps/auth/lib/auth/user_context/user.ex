defmodule Auth.UserContext.User do
  use Ecto.Schema
  import Ecto.Changeset

  @acceptable_roles ["Admin", "Manager", "User"]

  schema "users" do
    field :hashed_password, :string
    field :role, :string
    field :username, :string, default: "User"
  end

  def get_acceptable_roles, do: @acceptable_roles

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :hashed_password, :role])
    |> validate_required([:username, :hashed_password, :role])
    |> validate_inclusion(:role, @acceptable_roles)
    |> put_password_hash()
  end

  defp put_password_hash(
    %Ecto.Changeset{valid? true, changes: %{password: password}} = changeset
  ) do
  change(changeset, hashed_password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset
end
