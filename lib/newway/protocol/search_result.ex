defprotocol NewWay.Protocol.SearchResult do
  @moduledoc "Encodes schema structs to SearchResult struct"
  @fallback_to_any true
  def encode(data)
  #@TODO: define decode when needed
  #def decode(data)
end

defimpl NewWay.Protocol.SearchResult, for: DateTime do
  @spec encode(%DateTime{}) :: binary
  def encode(dt) do
    DateTime.to_iso8601(dt)
  end
end

defimpl NewWay.Protocol.SearchResult, for: Atom do
  @spec encode(atom) :: binary
  def encode(atom), do: Atom.to_string(atom)
end

defimpl NewWay.Protocol.SearchResult, for: Integer do
  @spec encode(integer) :: binary
  def encode(integer), do: Integer.to_string(integer)
end

defimpl NewWay.Protocol.SearchResult, for: Any do
  @spec encode(any) :: any
  def encode(any), do: any
end

defmodule NewWay.Protocol.SearchResult.Utils do
  alias NewWay.Protocol.SearchResult
  def schema_to_map(%struct_name{} = struct) do
    Map.from_struct(struct)
    |> Enum.filter(fn {k, v} -> Enum.member?(struct_name.__schema__(:fields), k) and v != nil end)
    |> Enum.map(fn {k, v} -> {SearchResult.encode(k), SearchResult.encode(v)} end)
    |> Enum.into(%{})
  end
end
