defmodule Web.Router do
  use Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do

  end

  scope "/", Web do
    pipe_through :api

    get "/_home", HomeController, :home
    get "/*path", HomeController, :index

  end

end
