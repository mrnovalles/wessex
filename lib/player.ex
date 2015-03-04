defmodule Player do
  @behaviour :wes_actor

  def init([id]) do
    {:ok, %{id: id, data: %{} }}
  end

  def command(_session, :update, {user_id, {key, value}}, state) do
    new_state = %{ state | :data => Dict.put(state.data, key, value) }
    {:ok, new_state}
  end

  def command(_session, :current, user_id, state) do
    {:reply, state.data, state}
  end

  def command(_, _, _, state) do
    {:ok, state}
  end

  def command(_, _, _, _, state) do
    {:ok, state}
  end

  def key(id) do
   "#{id}"
  end

  def to_struct(_actor_name, state) do
    {:ok, state} = Jazz.encode(state)
    state
  end

  def from_struct(_key, value) do
    state = Jazz.decode(value,  keys: :atoms)
    {:ok, state}
    state
  end
end
