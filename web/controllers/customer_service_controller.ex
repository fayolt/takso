defmodule Takso.CustomerServiceController do
  use Takso.Web, :controller

  alias Takso.{CSRequest, Trip}

  def lost_and_found(conn, %{"cs_request" => %{"date_of_trip" => date, "pickup_address" => pickup_address}}) do
    changeset = CSRequest.changeset(%CSRequest{}, %{date_of_trip: date, pickup_address: pickup_address})
    query = filtering(date, pickup_address)
    query = from q in query, select: q
    trips = Repo.all(query)
    render conn, "lost_and_found.html", changeset: changeset, trips: trips
  end 

  def lost_and_found(conn, _params) do 
    changeset = CSRequest.changeset(%CSRequest{})
    query = from t in Trip, select: t 
    trips = Repo.all(query)
    render conn, "lost_and_found.html", changeset: changeset, trips: trips 
  end

  defp filtering(date, "") do
    from t in Trip, where: t.date == ^date
  end
  defp filtering("", address) do 
    from t in Trip, where: t.pickup_address == ^address
  end
  defp filtering(date, address) do
    from t in Trip, where: t.date == ^date and t.pickup_address == ^address
  end

  def scam_analysis(conn, %{"cs_request" => csrequest_params} = params) do 
    case Map.has_key?(params, "action") do
      true -> csrequest_params = 
                Enum.map(csrequest_params, fn({key, value}) -> {String.to_atom(key), ""} end)
                |> Enum.into(%{})
                changeset = CSRequest.changeset(%CSRequest{}, csrequest_params)
                trips = []
                render conn, "scam_analysis.html", changeset: changeset, trips: trips, 
                checkbox_50plus: "false", checkbox_25plus: "false"

      _ -> csrequest_params = 
            Enum.map(csrequest_params, fn({key, value}) -> {String.to_atom(key), value} end)
            |> Enum.into(%{})
            changeset = CSRequest.changeset(%CSRequest{}, csrequest_params)    
            case csrequest_params[:taxi_id] do
              "" -> query = from t in Trip, 
                    where: # t.date == ^csrequest_params[:date_of_incident] and
                          t.pickup_address == ^csrequest_params[:pickup_address] and 
                          t.dropoff_address == ^csrequest_params[:dropoff_address],
                    select: t 
                    trips = Repo.all(query)
                    render conn, "scam_analysis.html", changeset: changeset, trips: trips, 
                      checkbox_50plus: csrequest_params[:checkbox_50plus], checkbox_25plus: csrequest_params[:checkbox_25plus]
              _ -> query = from t in Trip,
                  where: t.taxi_id == ^csrequest_params[:taxi_id],
                  select: t
                  trips = Repo.all(query)
                  render conn, "scam_analysis.html", changeset: changeset, trips: trips, 
                    checkbox_50plus: csrequest_params[:checkbox_50plus], checkbox_25plus: csrequest_params[:checkbox_25plus]                  
            end    
    end
    
  end

  def scam_analysis(conn, _params) do
    changeset = CSRequest.changeset(%CSRequest{})
    query = from t in Trip, select: t 
    trips = Repo.all(query)
    render conn, "scam_analysis.html", changeset: changeset, checkbox_25plus: "false", checkbox_50plus: "false", trips: trips
  end

end
