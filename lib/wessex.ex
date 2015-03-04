defmodule WessEx do
  use Application

  # Callback

  def start(_type, _args) do
    :error_logger.tty(false)
    pid = AppSupervisor.start_link
    :wes_lock_ets.start(1000)
    :wes_stats_ets.start_link()
    pid
  end
end
