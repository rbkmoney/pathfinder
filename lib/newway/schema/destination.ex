defmodule NewWay.Schema.Destination do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(DestinationStatus, [
    :authorized,
    :unauthorized
  ])

  defenum(DestinationResourceType, [
    :bank_card,
    :crypto_wallet
  ])

  lookup_key(:destination_id)

  schema "destination" do
    field(:event_id,                          :integer)
    field(:event_created_at,                  :utc_datetime)
    field(:event_occured_at,                  :utc_datetime)
    field(:sequence_id,                       :integer)
    field(:destination_id,                    :string)
    field(:destination_name,                  :string)
    field(:destination_status,                DestinationStatus)
    field(:resource_bank_card_token,          :string)
    field(:resource_bank_card_payment_system, :string)
    field(:resource_bank_card_bin,            :string)
    field(:resource_bank_card_masked_pan,     :string)
    field(:account_id,                        :string)
    field(:identity_id,                       :string)
    field(:party_id,                          :string)
    field(:accounter_account_id,              :integer)
    field(:currency_code,                     :string)
    field(:wtime,                             :utc_datetime)
    field(:current,                           :boolean)
    field(:external_id,                       :string)
    field(:created_at,                        :utc_datetime)
    field(:context_json,                      :string)
    field(:resource_crypto_wallet_id,         :string)
    field(:resource_crypto_wallet_type,       :string)
    field(:resource_type,                     DestinationResourceType)
    field(:resource_crypto_wallet_data,       :string)
    field(:resource_bank_card_type,           :string)
    field(:resource_bank_card_issuer_country, :string)
    field(:resource_bank_card_bank_name,      :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Destination do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Destination{}) :: Thrift.Header.t
  def encode(destination) do
    pf_Destination(
      id:
        Thrift.encode(destination.id),
      event_id:
        Thrift.encode(destination.event_id),
      event_created_at:
        Thrift.encode(destination.event_created_at),
      event_occured_at:
        Thrift.encode(destination.event_occured_at),
      sequence_id:
        Thrift.encode(destination.sequence_id),
      destination_id:
        Thrift.encode(destination.destination_id),
      destination_name:
        Thrift.encode(destination.destination_name),
      destination_status:
        Thrift.encode(destination.destination_status),
      resource_bank_card_token:
        Thrift.encode(destination.resource_bank_card_token),
      resource_bank_card_payment_system:
        Thrift.encode(destination.resource_bank_card_payment_system),
      resource_bank_card_bin:
        Thrift.encode(destination.resource_bank_card_bin),
      resource_bank_card_masked_pan:
        Thrift.encode(destination.resource_bank_card_masked_pan),
      account_id:
        Thrift.encode(destination.account_id),
      identity_id:
        Thrift.encode(destination.identity_id),
      party_id:
        Thrift.encode(destination.party_id),
      accounter_account_id:
        Thrift.encode(destination.accounter_account_id),
      currency_code:
        Thrift.encode(destination.currency_code),
      wtime:
        Thrift.encode(destination.wtime),
      current:
        Thrift.encode(destination.current),
      external_id:
        Thrift.encode(destination.external_id),
      created_at:
        Thrift.encode(destination.created_at),
      context_json:
        Thrift.encode(destination.context_json),
      resource_crypto_wallet_id:
        Thrift.encode(destination.resource_crypto_wallet_id),
      resource_crypto_wallet_type:
        Thrift.encode(destination.resource_crypto_wallet_type),
      resource_type:
        Thrift.encode(destination.resource_type),
      resource_crypto_wallet_data:
        Thrift.encode(destination.resource_crypto_wallet_data),
      resource_bank_card_type:
        Thrift.encode(destination.resource_bank_card_type),
      resource_bank_card_issuer_country:
        Thrift.encode(destination.resource_bank_card_issuer_country),
      resource_bank_card_bank_name:
        Thrift.encode(destination.resource_bank_card_bank_name)
    )
  end
end
