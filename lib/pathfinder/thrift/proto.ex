defmodule Pathfinder.Thrift.Proto do
  defmacro import_records(names) do
    quote do
      require Record
      @proto_path "pathfinder_proto/include/pathfinder_proto_lookup_thrift.hrl"
      Enum.each(unquote(names), fn x ->
        Record.defrecord(x, Record.extract(x, from_lib: @proto_path))
      end)
    end
  end
end
