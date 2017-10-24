defmodule Takso.CSRequest do
  use Takso.Web, :model

  schema "csrequests" do
    field :customer_name, :string
    field :date_of_trip, :date
    field :pickup_address, :string
    field :dropoff_address, :string
    field :comments, :string

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:customer_name, :date_of_trip, :pickup_address, :dropoff_address, :comments])
  end
end