# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :trends_4chan,
  ecto_repos: [Trends4chan.Repo]

# Configures the endpoint
config :trends_4chan, Trends4chanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "hAQuPL9y4tsxNUebPIFvjMY8PHLJBMOQFvQc3ITgOXK0iLWICvRPWLaScQn/tkur",
  render_errors: [view: Trends4chanWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Trends4chan.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
