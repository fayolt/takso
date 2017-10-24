defmodule Takso.Repo.Migrations.CreateCSRequest do
  use Ecto.Migration

  def change do
    create table(:csrequests) do
      add :customer_name, :string
      add :date_of_trip, :date
      add :pickup_address, :string
      add :dropoff_address, :string
      add :comments, :string

      timestamps()
    end
  end
end
