defmodule NewWay.Schema.Adjustment do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(AdjustmentStatus, [
    :pending,
    :captured,
    :cancelled,
    :processed
  ])

  lookup_key(:adjustment_id)

  schema "adjustment" do
    field(:event_created_at,    :utc_datetime)
    field(:domain_revision,     :integer)
    field(:adjustment_id,       :string)
    field(:payment_id,          :string)
    field(:invoice_id,          :string)
    field(:party_id,            :string)
    field(:shop_id,             :string)
    field(:created_at,          :utc_datetime)
    field(:status,              AdjustmentStatus)
    field(:status_captured_at,  :utc_datetime)
    field(:status_cancelled_at, :utc_datetime)
    field(:reason,              :string)
    field(:wtime,               :utc_datetime)
    field(:current,             :boolean)
    field(:fee,                 :integer)
    field(:provider_fee,        :integer)
    field(:external_fee,        :integer)
    field(:party_revision,      :integer)
    field(:sequence_id,         :integer)
    field(:change_id,           :integer)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Adjustment do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Adjustment{}) :: Thrift.Header.t
  def encode(adjustment) do
    pf_Adjustment(
      id:
        Thrift.encode(adjustment.id),
      event_created_at:
        Thrift.encode(adjustment.event_created_at),
      domain_revision:
        Thrift.encode(adjustment.domain_revision),
      adjustment_id:
        Thrift.encode(adjustment.adjustment_id),
      payment_id:
        Thrift.encode(adjustment.payment_id),
      invoice_id:
        Thrift.encode(adjustment.invoice_id),
      party_id:
        Thrift.encode(adjustment.party_id),
      shop_id:
        Thrift.encode(adjustment.shop_id),
      created_at:
        Thrift.encode(adjustment.created_at),
      status:
        Thrift.encode(adjustment.status),
      status_captured_at:
        Thrift.encode(adjustment.status_captured_at),
      status_cancelled_at:
        Thrift.encode(adjustment.status_cancelled_at),
      reason:
        Thrift.encode(adjustment.reason),
      wtime:
        Thrift.encode(adjustment.wtime),
      current:
        Thrift.encode(adjustment.current),
      fee:
        Thrift.encode(adjustment.fee),
      provider_fee:
        Thrift.encode(adjustment.provider_fee),
      external_fee:
        Thrift.encode(adjustment.external_fee),
      party_revision:
        Thrift.encode(adjustment.party_revision),
      sequence_id:
        Thrift.encode(adjustment.sequence_id),
      change_id:
        Thrift.encode(adjustment.change_id)
    )
  end
end
