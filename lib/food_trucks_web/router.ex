defmodule FoodTrucksWeb.Router do
  use FoodTrucksWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {FoodTrucksWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FoodTrucksWeb do
    pipe_through :api

    get "/trucks", TrucksController, :index
  end
end
