# FoodTrucks
This is a little application that returns an api that lets you qeury the included dataset using a multitude of queries

"Mobile_Food_Facility_Permit.csv"

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Usage
Now you can query the data using the following possible queries(as query params)

## Concessions
The following is a list of conecessions I made due to time

* Fixed location: Originally planned on using a variable location to determine distance but thought it would be too extra time to implement asking for valid coordinates as input, as well as a pain for finding useful coords to test.
* Distance as the crow flies vs walking distance: Could have used google maps API to determine distance but that would require billing info to use and this is just a test
* Not returning the distance of the truck: We just return trucks within the radius but not the actual distance. We would need to make another enum call to include it and didn't seem too necessary
* 
