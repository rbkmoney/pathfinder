defmodule NewWay.Helper.SearchIn do
  defmacro __using__(opts) do
    quote do
      @spec search([Pathfinder.id]) :: [%__MODULE__{}]
      def search(ids) do
        require Ecto.Query
        __MODULE__
        |> Ecto.Query.where([a], a.unquote(opts[:field]) in ^ids)
        |> NewWay.Repo.all()
      end
    end
  end
end
