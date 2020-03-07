defmodule UserCats.Repo.Migrations.CreateCats do
  use Ecto.Migration

  def change do
    create table(:cats) do
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false
    end

    create index(:cats, [:user_id])
  end
end
