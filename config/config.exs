import Config

# Common compile-time app env

config :pathfinder, ecto_repos: [NewWay.Repo]

config :pathfinder, Woody.Server,
       ip: "::",
       port: 8022,
       protocol_opts: %{
         :request_timeout => 3000,
         # Should be greater than any other timeouts
         :idle_timeout => :infinity
       },
       transport_opts: %{
         # Keeping the default value
         :max_connections => 8096
       },
       scoper_event_handler_options: %{
         :event_handler_opts => %{
           :formatter_opts => %{
             :max_length => 1000,
             :max_printable_string_length => 80
           }
         }
       },
       shutdown_timeout: 7000

# Dont use Elixir's logger
config :logger, backends: []

import_config("#{Mix.env()}.exs")
