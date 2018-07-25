defmodule OnetapSignxWeb.PageController do
  use OnetapSignxWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def signin(conn, _params) do
    render conn, "signin.html"
  end

  def signup(conn, _params) do
    render conn, "signup.html"
  end

  def id_token(conn, params = %{"id_token" => id_token}) do
    {payload, error} = verify_id_token(id_token)
    conn
    |> assign(:payload, payload)
    |> assign(:error, error)
    |> render("id_token.html")
  end
  def id_token(conn, _) do
    conn
    |> redirect(to: "/")
  end

  defp verify_id_token(id_token) do
    google_jwks = KittenBlue.JWK.Google.fetch!()
    case KittenBlue.JWS.verify(id_token, google_jwks) do
      {:ok, payload} -> verify_id_token_payload(payload)
      {:error, error} -> {"", error |> Atom.to_string()}
    end
  end

  defp verify_id_token_payload(payload) do
    {payload |> Poison.encode!(), ""}
  end
end
