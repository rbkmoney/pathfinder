defmodule NewWay.Schema.Refund do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(RefundStatus, [
    :pending,
    :succeeded,
    :failed
  ])

  lookup_key(:refund_id)

  schema "refund" do
    field(:event_created_at,                                 :naive_datetime)
    field(:domain_revision,                                  :integer)
    field(:refund_id,                                        :string)
    field(:payment_id,                                       :string)
    field(:invoice_id,                                       :string)
    field(:party_id,                                         :string)
    field(:shop_id,                                          :string)
    field(:created_at,                                       :naive_datetime)
    field(:status,                                           RefundStatus)
    field(:status_failed_failure,                            :string)
    field(:amount,                                           :integer)
    field(:currency_code,                                    :string)
    field(:reason,                                           :string)
    field(:wtime,                                            :naive_datetime)
    field(:current,                                          :boolean)
    field(:session_payload_transaction_bound_trx_id,         :string)
    field(:session_payload_transaction_bound_trx_extra_json, :string)
    field(:fee,                                              :integer)
    field(:provider_fee,                                     :integer)
    field(:external_fee,                                     :integer)
    field(:party_revision,                                   :integer)
    field(:sequence_id,                                      :integer)
    field(:change_id,                                        :integer)
    field(:external_id,                                      :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Refund do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Refund{}) :: Thrift.Header.t
  def encode(refund) do
    pf_Refund(
      id:
        Thrift.encode(refund.id),
      event_created_at:
        Thrift.encode(refund.event_created_at),
      domain_revision:
        Thrift.encode(refund.domain_revision),
      refund_id:
        Thrift.encode(refund.refund_id),
      payment_id:
        Thrift.encode(refund.payment_id),
      invoice_id:
        Thrift.encode(refund.invoice_id),
      party_id:
        Thrift.encode(refund.party_id),
      shop_id:
        Thrift.encode(refund.shop_id),
      created_at:
        Thrift.encode(refund.created_at),
      status:
        Thrift.encode(refund.status),
      status_failed_failure:
        Thrift.encode(refund.status_failed_failure),
      amount:
        Thrift.encode(refund.amount),
      currency_code:
        Thrift.encode(refund.currency_code),
      reason:
        Thrift.encode(refund.reason),
      wtime:
        Thrift.encode(refund.wtime),
      current:
        Thrift.encode(refund.current),
      session_payload_transaction_bound_trx_id:
        Thrift.encode(refund.session_payload_transaction_bound_trx_id),
      session_payload_transaction_bound_trx_extra_json:
        Thrift.encode(refund.session_payload_transaction_bound_trx_extra_json),
      fee:
        Thrift.encode(refund.fee),
      provider_fee:
        Thrift.encode(refund.provider_fee),
      external_fee:
        Thrift.encode(refund.external_fee),
      party_revision:
        Thrift.encode(refund.party_revision),
      sequence_id:
        Thrift.encode(refund.sequence_id),
      change_id:
        Thrift.encode(refund.change_id),
      external_id:
        Thrift.encode(refund.external_id)
    )
  end
end
