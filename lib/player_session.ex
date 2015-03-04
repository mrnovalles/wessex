defmodule PlayerSession do
  defmacro chan(session) do
    quote do
      {:player_session, unquote(session)}
    end
  end

  defmacro actor(user) do
    quote do
      {:player, unquote(user)}
    end
  end

  defmacro spec(user, type) do
    quote do
      {unquote(type), unquote(actor(user)), [unquote(user)]}
    end
  end

  def start_session(session) do
    {:ok, _} = chan(session) |> :wes.ensure_channel()
   end

  def stop_session(session) do
    :ok = chan(session) |> :wes.stop_channel()
  end

  def load_user(session, user) do
    case :wes.ensure_actor(chan(session), spec(user, :load)) do
      :ok -> :ok
      {:error, _cause} -> {:error, :busy}
    end
  end

  def update(session, user_id, {key, value}) do
    payload = {user_id, {key, value}}
    response = :wes.command(chan(session), :update, payload)
    :ok
  end

  def create_user(session, user_id) do
    :wes.create_actor(chan(session), spec(user_id, :create))
  end

  def get_user_state(session, user_id) do
    [{_, current_state}] = :wes.command(chan(session), :current, user_id)
  end

end
