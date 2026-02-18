defmodule Web.HomeController do
  use Web, :controller
  import DB

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    conn
    |> render("home.html")
  end

  def users(conn, _params) do
    conn
    |> content(
      ul(
        DB.list("users")
        |> Enum.map(fn user ->
          li(user["username"] <> " (" <> user["email"] <> ")")
        end)
      )
    )
  end

  def test(conn, _params) do
    conn |> json(%{greeting: "Hello from: "})
  end
end
