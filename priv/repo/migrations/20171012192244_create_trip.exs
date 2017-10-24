defmodule Takso.Repo.Migrations.CreateTrip do
  use Ecto.Migration

  def change do
    create table(:trips) do
      add :date, :date
      add :pickup_address, :string
      add :dropoff_address, :string
      add :pickup_time, :time
      add :dropoff_time, :time
      add :est_pickup_time, :time
      add :est_duration, :time
      add :taxi_id, :integer
      
      timestamps()
    end
  end
end
