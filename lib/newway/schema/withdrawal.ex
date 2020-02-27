defmodule NewWay.Schema.Withdrawal do
  use Ecto.Schema
  use NewWay.Helper.SearchIn, field: :withdrawal_id
  require NewWay.Macro.EnumType, as: EnumType

  EnumType.def_enum(WithdrawalStatus, [
    :pending,
    :succeeded,
    :failed
  ])

  EnumType.def_enum(WithdrawalTransferStatus, [
    :created,
    :prepared,
    :committed,
    :cancelled
  ])

  @schema_prefix "nw"
  schema "withdrawal" do
    field(:event_id,                              :integer)
    field(:event_created_at,                      :utc_datetime)
    field(:event_occured_at,                      :utc_datetime)
    field(:sequence_id,                           :integer)
    field(:wallet_id,                             :string)
    field(:destination_id,                        :string)
    field(:withdrawal_id,                         :string)
    field(:provider_id,                           :string)
    field(:amount,                                :integer)
    field(:currency_code,                         :string)
    field(:withdrawal_status,                     WithdrawalStatus)
    field(:withdrawal_transfer_status,            WithdrawalTransferStatus)
    field(:wtime,                                 :utc_datetime)
    field(:current,                               :boolean)
    field(:fee,                                   :integer)
    field(:provider_fee,                          :integer)
    field(:external_id,                           :string)
    field(:context_json,                          :string)
    field(:withdrawal_status_failed_failure_json, :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Withdrawal do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Withdrawal{}) :: Thrift.Header.t
  def encode(withdrawal) do
    pf_Withdrawal(
      id:
        Thrift.encode(withdrawal.id),
      event_id:
        Thrift.encode(withdrawal.event_id),
      event_created_at:
        Thrift.encode(withdrawal.event_created_at),
      event_occured_at:
        Thrift.encode(withdrawal.event_occured_at),
      sequence_id:
        Thrift.encode(withdrawal.sequence_id),
      wallet_id:
        Thrift.encode(withdrawal.wallet_id),
      destination_id:
        Thrift.encode(withdrawal.destination_id),
      withdrawal_id:
        Thrift.encode(withdrawal.withdrawal_id),
      provider_id:
        Thrift.encode(withdrawal.provider_id),
      amount:
        Thrift.encode(withdrawal.amount),
      currency_code:
        Thrift.encode(withdrawal.currency_code),
      withdrawal_status:
        Thrift.encode(withdrawal.withdrawal_status),
      withdrawal_transfer_status:
        Thrift.encode(withdrawal.withdrawal_transfer_status),
      wtime:
        Thrift.encode(withdrawal.wtime),
      current:
        Thrift.encode(withdrawal.current),
      fee:
        Thrift.encode(withdrawal.fee),
      provider_fee:
        Thrift.encode(withdrawal.provider_fee),
      external_id:
        Thrift.encode(withdrawal.external_id),
      context_json:
        Thrift.encode(withdrawal.context_json),
      withdrawal_status_failed_failure_json:
        Thrift.encode(withdrawal.withdrawal_status_failed_failure_json)
    )
  end
end
