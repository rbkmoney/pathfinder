defmodule NewWay.Schema.Identity do
  use Ecto.Schema
  use NewWay.Schema, search_field: :identity_id

  @type t :: Ecto.Schema.t

  @schema_prefix "nw"
  schema "identity" do
    field(:event_created_at,                      :utc_datetime)
    field(:event_occured_at,                      :utc_datetime)
    field(:sequence_id,                           :integer)
    field(:party_id,                              :string)
    field(:party_contract_id,                     :string)
    field(:identity_id,                           :string)
    field(:identity_provider_id,                  :string)
    field(:identity_class_id,                     :string)
    field(:identity_effective_chalenge_id,        :string)
    field(:identity_level_id,                     :string)
    field(:wtime,                                 :utc_datetime)
    field(:current,                               :boolean)
    field(:external_id,                           :string)
    field(:blocked,                               :boolean)
    field(:context_json,                          :string)

    belongs_to :party, NewWay.Schema.Party,
      define_field: false

    has_many :destinations, NewWay.Schema.Destination,
      foreign_key: :identity_id, references: :identity_id
    has_many :wallets, NewWay.Schema.Wallet,
      foreign_key: :identity_id, references: :identity_id
  end
end

defimpl NewWay.Protocol.SearchResult, for: NewWay.Schema.Identity do
  alias NewWay.SearchResult

  @spec encode(NewWay.Schema.Identity.t) :: SearchResult.t
  def encode(identity) do
    %SearchResult{
      id: identity.id,
      entity_id: identity.identity_id,
      ns: :identities,
      wtime: identity.wtime,
      event_time: identity.event_created_at,
      data: identity
    }
  end
end
