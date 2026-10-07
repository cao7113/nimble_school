defmodule NimbleSchoolWeb.PageController do
  use NimbleSchoolWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
