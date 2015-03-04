defmodule AppRouterTest do
  use ExUnit.Case
  use Plug.Test

  @opts AppRouter.init([])

  test "POST :user_id" do
    conn = conn(:post, "/user_foo", "" , headers: [{"session-id", "session1"}, {"content-type", "application/json"}])
    conn = AppRouter.call(conn, @opts)
    assert PlayerSession.get_user_state("session1", "user_foo") == [{{:player, "user_foo"}, %{}}]
    PlayerSession.stop_session("session1")
    assert conn.state == :sent
    assert conn.status == 200
  end

  test "POST :user_id/update" do
    session = "session2"
    user_id = "user_f2"

    PlayerSession.start_session(session)
    PlayerSession.create_user(session, user_id)
    assert PlayerSession.get_user_state(session, user_id) == [{{:player, "user_f2"}, %{}}]

    conn = conn(:post, "/user_f2", "{\"level\":\"two\"}" , headers: [{"session-id", session}, {"content-type", "application/json"}])
    conn = AppRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200

    # PlayerSession.get_user_state(session, user_id)
    #    PlayerSession.stop_session(session)
  end

  test "GET :user_id/current" do
    session = "session3"
    user_id = "user_foz"

    PlayerSession.start_session(session)
    PlayerSession.create_user(session, user_id)
    PlayerSession.update(session, user_id, {:level, "one"})

    conn = conn(:get, "/user_foz/current", "" , headers: [{"session-id", session}, {"content-type", "application/json"}])
    conn = AppRouter.call(conn, @opts)
    assert conn.state == :sent
    assert conn.status == 200

    assert PlayerSession.get_user_state(session, user_id) == [{{:player, "user_foz"}, %{level: "one"}}]
    PlayerSession.stop_session(session)
  end

end
