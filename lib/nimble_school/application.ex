defmodule NimbleSchool.Application do
  # See https://elixir.hexdocs.pm/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      NimbleSchoolWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:nimble_school, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: NimbleSchool.PubSub},
      # Start a worker by calling: NimbleSchool.Worker.start_link(arg)
      # {NimbleSchool.Worker, arg},
      # Start to serve requests, typically the last entry
      NimbleSchoolWeb.Endpoint
    ]

    # See https://elixir.hexdocs.pm/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NimbleSchool.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    NimbleSchoolWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
