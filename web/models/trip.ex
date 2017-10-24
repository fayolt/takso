defmodule Takso.Trip do
  use Takso.Web, :model
  use Timex

  schema "trips" do
    field :date, :date
    field :pickup_address, :string
    field :dropoff_address, :string
    field :pickup_time, :time
    field :dropoff_time, :time
    field :est_pickup_time, :time
    field :est_duration, :time
    field :taxi_id, :integer

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:date, :pickup_time, :pickup_address, :dropoff_address, :taxi_id, :est_pickup_time, :dropoff_time, :est_duration])
  end
end