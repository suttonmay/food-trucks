# FoodTrucks
This is a little application that generates an api(one route 😄) that lets you qeury the included dataset using a multitude of filters

`Mobile_Food_Facility_Permit.csv`

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Usage
I've created tests for every query param at `test/food_trucks/trucks_test.exs` or you can test with your own params using the route

`GET "/trucks"`

Now you can query the data using the following possible queries(as query params)

| param    | description                                                     | type   | example  | column    |
|----------|-----------------------------------------------------------------|--------|----------|-----------|
| status   | status of the food truck's permit                               | string | APPROVED | Status    |
| distance | returns truck within the distance from city hall in miles       | number | 0.5      | n/a       |
| food     | returns trucks when the string is included in their description | string | taco     | FoodItems |
| name     | returns trucks when the string is included in the name          | string | Natan's  | name      |

An example query would be `http://localhost:4000/trucks?distance=1&status=APPROVED"

It returns a list of objects that matches the query. Here is an example of what it returns

```
 [
    {
      "name": "Natan's",
      "status": "APPROVED",
      "distance: "1.0421335848651578",
      "food": "Everything but hot dogs",
      "lat": "37.12121",
      "long": "-122.323838"
      "schedule": "http://schedule.etc"
  }
 ]
```

## Concessions
The following is a list of conecessions I made due to time

* Fixed location: Originally planned on using a variable location to determine distance but thought it would be too extra time to implement asking for valid coordinates as input, as well as a pain for finding useful coords to test.
* Distance as the crow flies vs walking distance: Could have used google maps API to determine distance but that would require billing info to use and this is just a test
* Wanted to include some sorting but needed some time to implement the route/controller
* Would have loved to do a liveview page that displayed the results, but not enough time so opted for a route.

## Thoughts
Originally tried to implement my own ligtweight csv parser but the data had "," in some of the strings so it was corrupting the data. But once implemented NimbleCSV it was really smooth from there.


