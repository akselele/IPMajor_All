defmodule UserDemo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :first_name, :string
      add :last_name, :string
      add :date_of_birth, :date
    end

    create unique_index(:users, [:first_name, :last_name, :date_of_birth], 
      name: :unique_users_index
    )

  end
end
