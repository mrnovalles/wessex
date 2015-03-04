defmodule AppSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  @manager_name EventManager
  @registry_name Registry
  @user_sup_name UserSupervisor

  def init(:ok) do
    children = [
      worker(AppRouter, [], restart: :temporary),
      worker(:s3_server, [s3_config], restart: :permanent)
    ]
    supervise(children, strategy: :one_for_one)
  end

  def s3_config do
    credentials = :application.get_all_env(:s3)[:credentials]
    [
      {:timeout, 30000},
      {:return_headers, true},
      {:max_sessions, 10},
      {:max_pipeline_size, 10},
      {:endpoint, 's3-eu-west-1.amazonaws.com'},
    ] ++ credentials
  end

end
