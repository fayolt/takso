defmodule Takso.CustomerServiceController do
  use Takso.Web, :controller

  alias Takso.{CSRequest, Trip}

  def lost_and_found(conn, params) when params == %{} do 
    IO.puts("first...")
    changeset = CSRequest.changeset(%CSRequest{})
    query = from t in Trip, select: t 
    trips = Repo.all(query)
    render conn, "lost_and_found.html", changeset: changeset, trips: trips 
  end
  def lost_and_found(conn, %{"cs_request" => %{"date_of_trip" => date, "pickup_address" => pickup_address}}) do
    changeset = CSRequest.changeset(%CSRequest{})
    query = filter_by_date(date) 
            |> filter_by_address(pickup_address)
    query = from q in query, select: q
    trips = Repo.all(query)
    render conn, "lost_and_found.html", changeset: changeset, trips: trips
  end 
  defp filter_by_date(date) do
    from t in Trip, where: t.date == ^date
  end
  defp filter_by_address(query, address) when address == "" do
    query
  end
  defp filter_by_address(query, address) do
    from t in query, where: t.pickup_address == ^address
  end
  defp filtering(date \\ "", address \\ "")
  defp filtering(date, "") do
    IO.puts("one ...")
    from t in Trip, where: t.date == ^date
  end
  defp filtering("", address) do 
    IO.puts("two ...")
    from t in Trip, where: t.pickup_address == ^address
    
  end
  defp filtering(date, address) do
    IO.puts("three ...")
    from t in Trip, where: t.date == ^date and t.pickup_address == ^address
  end
end
