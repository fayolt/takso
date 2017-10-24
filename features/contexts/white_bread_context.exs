defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers
  alias Takso.{Repo,Trip}

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end
  scenario_starting_state fn _state ->
    Ecto.Adapters.SQL.Sandbox.checkout(Takso.Repo)
    Ecto.Adapters.SQL.Sandbox.mode(Takso.Repo, {:shared, self()})
    Hound.start_session
    %{}
  end
  scenario_finalize fn _status, _state -> 
    Ecto.Adapters.SQL.Sandbox.checkin(Takso.Repo)
    #Hound.end_session
  end

  given_ ~r/^STRS's ride history includes the following trips$/, 
  fn state, %{table_data: table} ->
    table
    |> Enum.map(fn trip -> Trip.changeset(%Trip{}, trip) end)
    |> Enum.each(fn changeset -> Repo.insert!(changeset) end)
    {:ok, state}
  end
  and_ ~r/^"(?<argument_one>[^"]+)" lodges a customer service request for lost object$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end
  and_ ~r/^the lost object is a "(?<argument_one>[^"]+)"$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end
  and_ ~r/^the date of the loss is "(?<date_of_loss>[^"]+)"$/,
  fn state, %{date_of_loss: date_of_loss} ->
    {:ok, Map.put(state, :date,  date_of_loss)}
  end
  when_ ~r/^the operator enters the date of loss$/, 
  fn state ->
     navigate_to "/lost_and_found"
     input_into_field({:id, "date_of_trip"}, state[:date])
     click({:id, "submit_button"})
     {:ok, state}
  end
  then_ ~r/^the operator should see (?<rows>\d+) rows$/, 
  fn state, %{rows: rows} ->
     {rows, _} = Integer.parse(rows)
     assert length(find_all_elements(:css, ".table_row")) == rows
     {:ok, state}
  end
  when_ ~r/^the operator enters "(?<pickup_address>[^"]+)" as pickup address$/,
  fn state, %{pickup_address: pickup_address} ->
    fill_field({:id, "pickup_address"}, pickup_address)
    click({:id, "submit_button"})    
    {:ok, state}
  end
end
