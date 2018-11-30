defmodule PhxElmStarter.Repo do
  use Ecto.Repo,
    otp_app: :phx_elm_starter,
    adapter: Ecto.Adapters.Postgres
end
