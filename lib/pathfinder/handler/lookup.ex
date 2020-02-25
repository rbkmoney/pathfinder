defmodule Pathfinder.Handler.Lookup do
  @behaviour :woody_server_thrift_handler

  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec get_spec(:woody.options) :: :woody.http_handler(:woody.th_handler)
  def get_spec(opts),
    do: {"/v1/lookup", {{:pathfinder_proto_lookup_thrift, :Lookup}, {__MODULE__, opts}}}

  @impl true
  @spec handle_function(:woody.func, :woody.args, :woody_context.ctx, :woody.options) ::
    {:ok, :woody.result} | no_return
  def handle_function(func, args, ctx, options) do
    :scoper.scope(:lookup, fn ->
      handle_function_(func, args, ctx, options)
    end)
  end

  @spec handle_function_(:woody.func, :woody.args, :woody_context.ctx, :woody.options) ::
    {:ok, :woody.result} | no_return
  def handle_function_(:Lookup, [pf_LookupRequest(ids: target_ids, namespaces: target_namespaces)], _context, _opts) do
    namespaces = get_namespaces(target_namespaces)
    _ = :logger.info("Received request for Lookup. IDs: #{inspect target_ids}, Namespaces: #{inspect namespaces}")

    lookup_result = do_lookup(target_ids, namespaces)

    {:ok, pf_LookupResult(data: lookup_result)}
  end

  @type lookup_result :: [{Pathfinder.namespace, [Thrift.Header.t]}]

  @spec do_lookup([Pathfinder.id], [Pathfinder.namespace]) :: lookup_result
  defp do_lookup(ids, namespaces) do
    namespaces
      |> Enum.reduce([], fn(namespace, acc) ->
           case lookup_schema(ids, namespace) do
             [] -> acc
             results -> [{namespace, to_thift(results)} | acc]
           end
         end)
      |> Enum.reverse
  end

  @spec lookup_schema([Pathfinder.id], Pathfinder.namespace) :: [struct]
  defp lookup_schema(ids, :adjustments),  do: NewWay.Schema.Adjustment.lookup(ids)
  defp lookup_schema(ids, :destinations), do: NewWay.Schema.Destination.lookup(ids)
  defp lookup_schema(ids, :invoices),     do: NewWay.Schema.Invoice.lookup(ids)
  defp lookup_schema(ids, :payments),     do: NewWay.Schema.Payment.lookup(ids)
  defp lookup_schema(ids, :payouts),      do: NewWay.Schema.Payout.lookup(ids)
  defp lookup_schema(ids, :refunds),      do: NewWay.Schema.Refund.lookup(ids)
  defp lookup_schema(ids, :wallets),      do: NewWay.Schema.Wallet.lookup(ids)
  defp lookup_schema(ids, :withdrawals),  do: NewWay.Schema.Withdrawal.lookup(ids)

  @spec get_namespaces([Pathfinder.namespace] | :undefined) :: [Pathfinder.namespace]
  defp get_namespaces(list) when is_list(list),
    do: list
  defp get_namespaces(:undefined),
    do: [:adjustments, :destinations, :invoices, :payments, :payouts, :refunds, :wallets, :withdrawals]

  @spec to_thift([struct]) :: [Thrift.Header.t]
  defp to_thift(list) when is_list(list),
    do: list |> Enum.map(&Pathfinder.Protocol.Thrift.encode/1)
end
