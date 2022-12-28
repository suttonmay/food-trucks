defmodule FoodTrucks.TrucksTest do
  use ExUnit.Case

  alias FoodTrucks.Trucks

  test "No filters" do
    results = Trucks.query(%{})
    assert Enum.count(results) == 482
  end

  test "grabs the correct fields" do
    [first | _] = Trucks.query(%{})
    assert first == %{
      name: "Ziaurehman Amini",
      status: "REQUESTED",
      food: "",
      lat: "37.794331003246846",
      long: "-122.39581105302317",
      schedule: "http://bsm.sfdpw.org/PermitsTracker/reports/report.aspx?title=schedule&report=rptSchedule&params=permit=15MFF-0159&ExportPDF=1&Filename=15MFF-0159_schedule.pdf"
    }
  end

  describe "Filter by status" do
    test "Filter by 'SUSPEND'" do
      results = Trucks.query(%{"status" => "SUSPEND"})
      assert Enum.count(results) == 22
    end

    test "Filter by 'APPROVED'" do
      results = Trucks.query(%{"status" => "APPROVED"})
      assert Enum.count(results) == 148
    end

    test "Filter by invalid status" do
      results = Trucks.query(%{"status" => "NOEXIST"})
      assert Enum.count(results) == 0
    end
  end

  describe "Filter by distance from City Hall" do
    test "mile from city hall" do
      results = Trucks.query(%{"distance" => 1})
      assert Enum.count(results) == 72
    end
  end

  describe "Filter by food type" do
    test "taco trucks" do
      results = Trucks.query(%{"food" => "taco"})
      assert Enum.count(results) == 71
    end

    test "sandwich trucks" do
      results = Trucks.query(%{"food" => "sandwich"})
      assert Enum.count(results) == 231
    end
  end

  describe "Filter by truck name" do
    test "Natan's trucks" do
      results = Trucks.query(%{"name" => "Natan's"})
      assert Enum.count(results) == 37
    end

    test "el alambre trucks using wrong case" do
      results = Trucks.query(%{"name" => "el alambre"})
      assert Enum.count(results) == 4
    end
  end

  describe "multiple queries" do
    test "APPROVED status and taco truck" do
      results = Trucks.query(%{"food" => "taco", "status" => "APPROVED"})
      assert Enum.count(results) == 37
    end

    test "APPROVED status and taco truck within half mile of city hall" do
      results = Trucks.query(%{"food" => "taco", "status" => "APPROVED", "distance" => 0.5})
      assert Enum.count(results) == 4
    end

    test "taco truck within half mile of city hall" do
      results = Trucks.query(%{"food" => "taco", "distance" => 0.5})
      assert Enum.count(results) == 6
    end
  end
end
