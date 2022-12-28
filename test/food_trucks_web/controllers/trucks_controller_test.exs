defmodule FoodTrucksWeb.PageControllerTest do
  use FoodTrucksWeb.ConnCase

  test "GET /trucks", %{conn: conn} do
    conn = get(conn, "/trucks", %{"status" => "APPROVED"})
    assert Enum.count(json_response(conn, 200)) == 148
  end

  test "GET /trucks with invalid distance", %{conn: conn} do
    conn = get(conn, "/trucks", %{"distance" => "test"})
    assert response(conn, 400) == "distance must be a valid number"
  end
end
