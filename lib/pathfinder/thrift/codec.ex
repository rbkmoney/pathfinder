defmodule Pathfinder.Thrift.Codec do
  require Pathfinder.Thrift.Proto, as: Proto
  Proto.import_records([
    :pf_Result,
    :pf_Filter
  ])

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
      data: data
    )
  end

  @type thrift_filter :: :pathfinder_proto_lookup_thrift."Filter"()
  @spec encode(%NewWay.Filter{}) :: thrift_filter
  def encode(%NewWay.Filter{
    limit: limit,
    offset: offset,
    is_current: is_current
  }) do
    pf_Filter(
      limit: limit,
      offset: offset,
      is_current: is_current
    )
  end

  @spec decode(thrift_result) :: %NewWay.SearchResult{}
  def decode(pf_Result(
    id: id,
    ns: ns,
    data: data
  )) do
    %NewWay.SearchResult{
      id: id,
      ns: ns,
      data: data
    }
  end

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
end
