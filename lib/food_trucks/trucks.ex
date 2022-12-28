defmodule FoodTrucks.Trucks do
  @moduledoc """
  Context for interacting with the trucks dataset
  """
  alias :math, as: Math

  NimbleCSV.define(TruckParser, escape: "\"")

  def query(queries) do
    results =
    File.stream!("Mobile_Food_Facility_Permit.csv")
    |> TruckParser.parse_stream()
    |> Stream.map(fn [_,name,_,_,_,_,_,_,_,_,status,food,_,_,lat,long,schedule | _] -> %{name: name, status: status, food: food, lat: lat, long: long, schedule: schedule} end)

    query(results, queries)
  end

  defp query(results, queries) when queries == %{} do
    Enum.map(results, fn row -> row end)
  end

  defp query(results, %{"status" => status} = queries) do
    results = Stream.filter(results, fn row -> row.status == status end)
    queries = Map.delete(queries, "status")

    query(results, queries)
  end

  defp query(results, %{"food" => food} = queries) do
    results = Stream.filter(results, fn row -> String.contains?(String.downcase(row.food), String.downcase(food)) end)
    queries = Map.delete(queries, "food")

    query(results, queries)
  end

  defp query(results, %{"name" => name} = queries) do
    results = Stream.filter(results, fn row -> String.contains?(String.downcase(row.name), String.downcase(name)) end)
    queries = Map.delete(queries, "name")

    query(results, queries)
  end

  defp query(results, %{"distance" => distance} = queries) do
    results =
    results
    |> Stream.map(fn row -> Map.put(row, :distance, determine_distance(row.lat, row.long)) end)
    |> Stream.filter(fn row ->  row.distance < distance end)
    queries = Map.delete(queries, "distance")

    query(results, queries)
  end

  defp determine_distance(truck_lat, truck_long) do
    loc_lat = 37.7792
    loc_long = -122.4191
    {truck_lat, _} = Float.parse(truck_lat)
    {truck_long, _} = Float.parse(truck_long)

    #Credit to https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula for formula
    pi = 0.017453292519943295 # pi / 180
    a = 0.5 - Math.cos((truck_lat - loc_lat) * pi)/2 + Math.cos(loc_lat * pi) * Math.cos(truck_lat * pi) * (1 - Math.cos((truck_long - loc_long) * pi))/2
    7917.6 * Math.asin(Math.sqrt(a))
  end
end
