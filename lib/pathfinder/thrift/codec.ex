defmodule Pathfinder.Thrift.Codec do
  require Pathfinder.Thrift.Proto, as: Proto
  Proto.import_records([
    :pf_Result,
    :pf_Filter
  ])

  # Api

  @type thrift_result :: :pathfinder_proto_lookup_thrift."Result"()
  @spec encode(%NewWay.SearchResult{}) :: thrift_result
  def encode(%NewWay.SearchResult{
    id: id,
    ns: ns,
    data: data
  }) do
    pf_Result(
      id: id,
      ns: ns,
      data: encode_nw_schema(data)
    )
  end

  @type thrift_filter :: :pathfinder_proto_lookup_thrift."Filter"()
  @spec decode(thrift_filter) :: %NewWay.Filter{}
  def decode(pf_Filter(
    limit: limit,
    offset: offset,
    is_current: is_current
  )) do
    filter0 = %NewWay.Filter{}
    filter1 = maybe_put(filter0, :limit, limit)
    filter2 = maybe_put(filter1, :offset, offset)
    maybe_put(filter2, :is_current, is_current)
  end

  # Utilities

  defp maybe_put(struct, _key, :undefined),
    do: struct
  defp maybe_put(struct, key, value),
    do: Map.put(struct, key, value)

  defp encode_nw_schema(%struct_name{} = struct) do
    Map.from_struct(struct)
    |> Enum.filter(fn {k, v} -> Enum.member?(struct_name.__schema__(:fields), k) and v != nil end)
    |> Enum.map(fn {k, v} -> {encode_data(k), encode_data(v)} end)
    |> Enum.into(%{})
  end

  defp encode_data(int) when is_integer(int),
    do: Integer.to_string(int)
  defp encode_data(atom) when is_atom(atom),
    do: Atom.to_string(atom)
  defp encode_data(dt = %DateTime{}),
    do: DateTime.to_iso8601(dt)
  defp encode_data(any),
    do: any
end
