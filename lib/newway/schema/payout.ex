defmodule NewWay.Schema.Payout do
  use Ecto.Schema
  @schema_prefix "nw"

  import NewWay.Macro.{EnumType, LookupKey}

  defenum(PayoutStatus, [
    :unpaid,
    :paid,
    :cancelled,
    :confirmed
  ])

  defenum(PayoutPaidStatusDetails, [
    :card_details,
    :account_details
  ])

  defenum(UserType, [
    :internal_user,
    :external_user,
    :service_user
  ])

  defenum(PayoutType, [
    :bank_card,
    :bank_account,
    :wallet
  ])

  defenum(PayoutAccountType, [
    :russian_payout_account,
    :international_payout_account
  ])

  lookup_key(payout_id)

  schema "payout" do
    field(:event_id,                                                   :integer)
    field(:event_created_at,                                           :naive_datetime)
    field(:payout_id,                                                  :string)
    field(:party_id,                                                   :string)
    field(:shop_id,                                                    :string)
    field(:contract_id,                                                :string)
    field(:created_at,                                                 :naive_datetime)
    field(:status,                                                     PayoutStatus)
    field(:status_paid_details,                                        PayoutPaidStatusDetails)
    field(:status_paid_details_card_provider_name,                     :string)
    field(:status_paid_details_card_provider_transaction_id,           :string)
    field(:status_cancelled_user_info_id,                              :string)
    field(:status_cancelled_user_info_type,                            UserType)
    field(:status_cancelled_details,                                   :string)
    field(:status_confirmed_user_info_id,                              :string)
    field(:status_confirmed_user_info_type,                            UserType)
    field(:type,                                                       PayoutType)
    field(:type_card_token,                                            :string)
    field(:type_card_payment_system,                                   :string)
    field(:type_card_bin,                                              :string)
    field(:type_card_masked_pan,                                       :string)
    field(:type_card_token_provider,                                   :string)
    field(:type_account_type,                                          PayoutAccountType)
    field(:type_account_russian_account,                               :string)
    field(:type_account_russian_bank_name,                             :string)
    field(:type_account_russian_bank_post_account,                     :string)
    field(:type_account_russian_bank_bik,                              :string)
    field(:type_account_russian_inn,                                   :string)
    field(:type_account_international_account_holder,                  :string)
    field(:type_account_international_bank_name,                       :string)
    field(:type_account_international_bank_address,                    :string)
    field(:type_account_international_iban,                            :string)
    field(:type_account_international_bic,                             :string)
    field(:type_account_international_local_bank_code,                 :string)
    field(:type_account_international_legal_entity_legal_name,         :string)
    field(:type_account_international_legal_entity_trading_name,       :string)
    field(:type_account_international_legal_entity_registered_address, :string)
    field(:type_account_international_legal_entity_actual_address,     :string)
    field(:type_account_international_legal_entity_registered_number,  :string)
    field(:type_account_purpose,                                       :string)
    field(:type_account_legal_agreement_signed_at,                     :naive_datetime)
    field(:type_account_legal_agreement_id,                            :string)
    field(:type_account_legal_agreement_valid_until,                   :naive_datetime)
    field(:wtime,                                                      :naive_datetime)
    field(:current,                                                    :boolean)
    field(:type_account_international_bank_number,                     :string)
    field(:type_account_international_bank_aba_rtn,                    :string)
    field(:type_account_international_bank_country_code,               :string)
    field(:type_account_international_correspondent_bank_number,       :string)
    field(:type_account_international_correspondent_bank_account,      :string)
    field(:type_account_international_correspondent_bank_name,         :string)
    field(:type_account_international_correspondent_bank_address,      :string)
    field(:type_account_international_correspondent_bank_bic,          :string)
    field(:type_account_international_correspondent_bank_iban,         :string)
    field(:type_account_international_correspondent_bank_aba_rtn,      :string)
    field(:type_account_international_correspondent_bank_country_code, :string)
    field(:amount,                                                     :integer)
    field(:fee,                                                        :integer)
    field(:currency_code,                                              :string)
    field(:wallet_id,                                                  :string)
  end
end

defimpl Pathfinder.Protocol.Thrift, for: NewWay.Schema.Payout do
  alias Pathfinder.Protocol.Thrift
  import Thrift.Header

  @spec encode(%NewWay.Schema.Payout{}) :: Thrift.Header.t
  def encode(payout) do
    pf_Payout(
      id:
        Thrift.encode(payout.id),
      event_id:
        Thrift.encode(payout.event_id),
      event_created_at:
        Thrift.encode(payout.event_created_at),
      payout_id:
        Thrift.encode(payout.payout_id),
      party_id:
        Thrift.encode(payout.party_id),
      shop_id:
        Thrift.encode(payout.shop_id),
      contract_id:
        Thrift.encode(payout.contract_id),
      created_at:
        Thrift.encode(payout.created_at),
      status:
        Thrift.encode(payout.status),
      status_paid_details:
        Thrift.encode(payout.status_paid_details),
      status_paid_details_card_provider_name:
        Thrift.encode(payout.status_paid_details_card_provider_name),
      status_paid_details_card_provider_transaction_id:
        Thrift.encode(payout.status_paid_details_card_provider_transaction_id),
      status_cancelled_user_info_id:
        Thrift.encode(payout.status_cancelled_user_info_id),
      status_cancelled_user_info_type:
        Thrift.encode(payout.status_cancelled_user_info_type),
      status_cancelled_details:
        Thrift.encode(payout.status_cancelled_details),
      status_confirmed_user_info_id:
        Thrift.encode(payout.status_confirmed_user_info_id),
      status_confirmed_user_info_type:
        Thrift.encode(payout.status_confirmed_user_info_type),
      type:
        Thrift.encode(payout.type),
      type_card_token:
        Thrift.encode(payout.type_card_token),
      type_card_payment_system:
        Thrift.encode(payout.type_card_payment_system),
      type_card_bin:
        Thrift.encode(payout.type_card_bin),
      type_card_masked_pan:
        Thrift.encode(payout.type_card_masked_pan),
      type_card_token_provider:
        Thrift.encode(payout.type_card_token_provider),
      type_account_type:
        Thrift.encode(payout.type_account_type),
      type_account_russian_account:
        Thrift.encode(payout.type_account_russian_account),
      type_account_russian_bank_name:
        Thrift.encode(payout.type_account_russian_bank_name),
      type_account_russian_bank_post_account:
        Thrift.encode(payout.type_account_russian_bank_post_account),
      type_account_russian_bank_bik:
        Thrift.encode(payout.type_account_russian_bank_bik),
      type_account_russian_inn:
        Thrift.encode(payout.type_account_russian_inn),
      type_account_international_account_holder:
        Thrift.encode(payout.type_account_international_account_holder),
      type_account_international_bank_name:
        Thrift.encode(payout.type_account_international_bank_name),
      type_account_international_bank_address:
        Thrift.encode(payout.type_account_international_bank_address),
      type_account_international_iban:
        Thrift.encode(payout.type_account_international_iban),
      type_account_international_bic:
        Thrift.encode(payout.type_account_international_bic),
      type_account_international_local_bank_code:
        Thrift.encode(payout.type_account_international_local_bank_code),
      type_account_international_legal_entity_legal_name:
        Thrift.encode(payout.type_account_international_legal_entity_legal_name),
      type_account_international_legal_entity_trading_name:
        Thrift.encode(payout.type_account_international_legal_entity_trading_name),
      type_account_international_legal_entity_registered_address:
        Thrift.encode(payout.type_account_international_legal_entity_registered_address),
      type_account_international_legal_entity_actual_address:
        Thrift.encode(payout.type_account_international_legal_entity_actual_address),
      type_account_international_legal_entity_registered_number:
        Thrift.encode(payout.type_account_international_legal_entity_registered_number),
      type_account_purpose:
        Thrift.encode(payout.type_account_purpose),
      type_account_legal_agreement_signed_at:
        Thrift.encode(payout.type_account_legal_agreement_signed_at),
      type_account_legal_agreement_id:
        Thrift.encode(payout.type_account_legal_agreement_id),
      type_account_legal_agreement_valid_until:
        Thrift.encode(payout.type_account_legal_agreement_valid_until),
      wtime:
        Thrift.encode(payout.wtime),
      current:
        Thrift.encode(payout.current),
      type_account_international_bank_number:
        Thrift.encode(payout.type_account_international_bank_number),
      type_account_international_bank_aba_rtn:
        Thrift.encode(payout.type_account_international_bank_aba_rtn),
      type_account_international_bank_country_code:
        Thrift.encode(payout.type_account_international_bank_country_code),
      type_account_international_correspondent_bank_number:
        Thrift.encode(payout.type_account_international_correspondent_bank_number),
      type_account_international_correspondent_bank_account:
        Thrift.encode(payout.type_account_international_correspondent_bank_account),
      type_account_international_correspondent_bank_name:
        Thrift.encode(payout.type_account_international_correspondent_bank_name),
      type_account_international_correspondent_bank_address:
        Thrift.encode(payout.type_account_international_correspondent_bank_address),
      type_account_international_correspondent_bank_bic:
        Thrift.encode(payout.type_account_international_correspondent_bank_bic),
      type_account_international_correspondent_bank_iban:
        Thrift.encode(payout.type_account_international_correspondent_bank_iban),
      type_account_international_correspondent_bank_aba_rtn:
        Thrift.encode(payout.type_account_international_correspondent_bank_aba_rtn),
      type_account_international_correspondent_bank_country_code:
        Thrift.encode(payout.type_account_international_correspondent_bank_country_code),
      amount:
        Thrift.encode(payout.amount),
      fee:
        Thrift.encode(payout.fee),
      currency_code:
        Thrift.encode(payout.currency_code),
      wallet_id:
        Thrift.encode(payout.wallet_id)
    )
  end
end
