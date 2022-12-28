defmodule FoodTrucksWeb.TrucksController do
  use FoodTrucksWeb, :controller

  alias FoodTrucks.Trucks

  def index(conn, params) do
      with params when is_map(params) <- build_query_params(params),
      results <- Trucks.query(params) do
        json(conn, results)
      else
        {:error, error} -> send_resp(conn, 400, error)
      end
  end

  defp build_query_params(params) do
    params
    |> Map.take(["status", "food", "name", "distance"])
    |> validate_distance()
  end

  defp validate_distance(%{"distance" => distance} = params) do
    case Float.parse(distance) do
      :error -> {:error, "distance must be a valid number"}
      {float, _} -> Map.put(params, "distance", float)
    end
  end

  defp validate_distance(params), do: params
end
