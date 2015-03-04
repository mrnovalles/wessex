defmodule AppRouter do
  require Logger
  use Plug.Router

  plug :match
  plug Plug.Parsers, parsers: [:urlencoded, :json],
                   pass:  ["text/*"],
                   json_decoder: Jazz
  plug :dispatch

  get "/test" do
    send_resp(conn, 200, "ok")
  end

  get "/:user_id/current" do
    {_, session} = List.keyfind(conn.req_headers, "session-id", 0)
    PlayerSession.start_session(session)
    state = PlayerSession.get_user_state(session, user_id)
    send_resp(conn, 200, "ok")
  end

  post "/:user_id/update" do
    {_, session} = List.keyfind(conn.req_headers, "session-id", 0)
    PlayerSession.start_session(session)
    PlayerSession.load_user(session, user_id)
    Enum.each(conn.params, fn({key, value}) ->
      :ok = PlayerSession.update(session, user_id, {key, value})
    end)
    send_resp(conn, 200, "ok")
  end

  post "/:user_id" do
    {_, session} = List.keyfind(conn.req_headers, "session-id", 0)
    PlayerSession.start_session(session)
    PlayerSession.create_user(session, user_id)
    send_resp(conn, 200, "ok")
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  def start_link do
    Plug.Adapters.Cowboy.http AppRouter, [], port: 8080
  end

  def stop do
    Plug.Adapters.Cowboy.shutdown AppRouter.HTTP
  end
end
