defmodule OnetapSignxWeb.Router do
  use OnetapSignxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OnetapSignxWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/signin", PageController, :signin
    get "/signup", PageController, :signup
    post "/id_token", PageController, :id_token
    get "/id_token", PageController, :id_token
  end

  # Other scopes may use custom stacks.
  # scope "/api", OnetapSignxWeb do
  #   pipe_through :api
  # end
end
