defmodule NewWay.Schema.Wallet do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.LookupKey

  lookup_key(:wallet_id)

  schema "wallet" do
    field(:event_id,             :integer)
    field(:event_created_at,     :naive_datetime)
    field(:event_occured_at,     :naive_datetime)
    field(:sequence_id,          :integer)
    field(:wallet_id,            :string)
    field(:wallet_name,          :string)
    field(:identity_id,          :string)
    field(:party_id,             :string)
    field(:currency_code,        :string)
    field(:wtime,                :naive_datetime)
    field(:current,              :boolean)
    field(:account_id,           :string)
    field(:accounter_account_id, :integer)
    field(:external_id,          :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Wallet do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Wallet{}) :: Thrift.Header.t
  def encode(wallet) do
    pf_Wallet(
      id:
        Thrift.encode(wallet.id),
      event_id:
        Thrift.encode(wallet.event_id),
      event_created_at:
        Thrift.encode(wallet.event_created_at),
      event_occured_at:
        Thrift.encode(wallet.event_occured_at),
      sequence_id:
        Thrift.encode(wallet.sequence_id),
      wallet_id:
        Thrift.encode(wallet.wallet_id),
      wallet_name:
        Thrift.encode(wallet.wallet_name),
      identity_id:
        Thrift.encode(wallet.identity_id),
      party_id:
        Thrift.encode(wallet.party_id),
      currency_code:
        Thrift.encode(wallet.currency_code),
      wtime:
        Thrift.encode(wallet.wtime),
      current:
        Thrift.encode(wallet.current),
      account_id:
        Thrift.encode(wallet.account_id),
      accounter_account_id:
        Thrift.encode(wallet.accounter_account_id),
      external_id:
        Thrift.encode(wallet.external_id)
    )
  end
end
