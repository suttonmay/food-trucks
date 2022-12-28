import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :food_trucks, FoodTrucksWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "QCGIfkMh4J2u0V457l+1/4ruU6a6bJ6M8CDNQf0DSkaXKQuAV33cBWR09HkStKiO",
  server: false

# In test we don't send emails.
config :food_trucks, FoodTrucks.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
