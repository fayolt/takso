# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Takso.Repo.insert!(%Takso.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will halt execution if something goes wrong.

alias Takso.{Repo, Trip}

[%{date: "2017-10-15", pickup_address: "Puusepa 8", dropoff_address: "Jaama 42", 
    pickup_time: "16:20:10", taxi_id: 3, est_pickup_time: "", dropoff_time: "", est_duration: ""},
 %{date: "2017-10-16", pickup_address: "Puusepa 8", dropoff_address: "Kastani 1", 
    pickup_time: "11:32:11", taxi_id: 1, est_pickup_time: "", dropoff_time: "", est_duration: ""},
 %{date: "2017-10-16", pickup_address: "Liivi 2", dropoff_address: "Turu 2", 
    pickup_time: "15:12:20", taxi_id: 2, est_pickup_time: "", dropoff_time: "", est_duration: ""}]
|> Enum.map(fn trip_data -> Trip.changeset(%Trip{}, trip_data) end)
|> Enum.each(fn changeset -> Repo.insert!(changeset) end)