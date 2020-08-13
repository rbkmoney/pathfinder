defmodule NewWay.Repo do
  @read_only Application.compile_env(:pathfinder, :read_only, :true)

  use Ecto.Repo,
    otp_app: :pathfinder,
    adapter: Ecto.Adapters.Postgres,
    read_only: @read_only

  @spec get_filtered_all(Ecto.Query.t, NewWay.filter) :: [Ecto.Schema.t]
  def get_filtered_all(query, filter) do
    require Ecto.Query
    query
    |> Ecto.Query.order_by(desc: :id)
    |> Ecto.Query.limit(^filter.limit)
    |> Ecto.Query.offset(^filter.offset)
    |> all()
  end
end
