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
    filter1 = case limit != :undefined do
      true -> %{filter0 | limit: limit}
      false -> filter0
    end
    filter2 = case offset != :undefined do
      true -> %{filter1 | offset: offset}
      false -> filter1
    end
    case is_current != :undefined do
      true -> %{filter2 | is_current: is_current}
      false -> filter2
    end
  end

  # Utilities

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
