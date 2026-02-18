defmodule MainLayout do
  use Web, :controller

  @spec content(Plug.Conn.t(), any) :: Plug.Conn.t()
  def content(conn, data) do
    conn
    |> put_view(Web.LayoutView)
    |> render(
      "app.html",
      content: [
        data
      ]
    )
  end
end
