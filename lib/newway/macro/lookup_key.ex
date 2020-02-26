defmodule NewWay.Macro.LookupKey do
  defmacro lookup_key(key) do
    quote do
      @spec unquote(:"by_#{key}")([Pathfinder.id]) :: [%unquote(__CALLER__.module){}]
      def unquote(:"by_#{key}")(ids) do
        require Ecto.Query
        unquote(__CALLER__.module)
          |> Ecto.Query.where([a], a.unquote(key) in ^ids)
          |> NewWay.Repo.all()
      end
    end
  end
end
